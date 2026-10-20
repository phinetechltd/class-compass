<?php

namespace Modules\Gateways\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;
use Modules\Academic\Models\Student;
use Modules\Gateways\Models\PaymentRequest;
use Modules\Gateways\Services\MpesaDarajaService;
use Modules\Gateways\Services\OnlineFeePaymentService;
use Modules\Gateways\Services\PaystackService;
use Modules\SystemConfiguration\Models\Setting;
use Throwable;

/**
 * Parents and students pay school fees online with M-Pesa (STK push) or Paystack.
 */
class OnlineFeePaymentController extends Controller
{
    public function __construct(private readonly OnlineFeePaymentService $service) {}

    // ---------------------------------------------------------------- parent / student

    public function due(Request $request): JsonResponse
    {
        $student = $this->currentStudent();
        if (! $student) {
            return $this->responseError([], _lang('No student is linked to this account.'), 404);
        }

        $feeHeads = $this->service->unpaidFeeHeads($student->id);

        return $this->responseSuccess([
            'student' => [
                'id' => $student->id,
                'name' => trim(($student->first_name ?? '').' '.($student->last_name ?? '')) ?: ($student->user?->name ?? ''),
                'admission_no' => $student->registration_no ?: $student->id,
            ],
            'fee_heads' => $feeHeads,
            'total_due' => $this->service->totalDue($feeHeads),
            'currency' => $this->currency(),
            'methods' => $this->availableMethods(),
        ], 'Fee balance fetched successfully.');
    }

    public function pay(Request $request): JsonResponse
    {
        $request->validate([
            'method' => 'required|in:mpesa,paystack',
            'amount' => 'required|numeric|min:1',
            'phone' => 'required_if:method,mpesa|nullable|string|max:20',
            'redirect_url' => 'nullable|url|max:255',
        ]);

        $student = $this->currentStudent();
        if (! $student) {
            return $this->responseError([], _lang('No student is linked to this account.'), 404);
        }

        $feeHeads = $this->service->unpaidFeeHeads($student->id);
        $due = $this->service->totalDue($feeHeads);
        if ($due <= 0) {
            return $this->responseError([], _lang('This student has no outstanding fees.'), 422);
        }

        $amount = round((float) $request->amount, 2);
        if ($amount > $due) {
            return $this->responseError([], _lang('Amount is more than the balance of').' '.$due, 422);
        }

        $method = $request->input('method');
        $setting = $this->gatewaySetting($method);
        $simulate = $method === 'mpesa' && $this->simulatesMpesa($setting);
        if (! $simulate && (! $setting || $setting->status != '1')) {
            return $this->responseError([], _lang('This payment method is not enabled by the school.'), 422);
        }

        $user = Auth::user();
        $payment = PaymentRequest::create([
            'institute_id' => $user->institute_id,
            'branch_id' => $user->branch_id,
            'payment_amount' => $amount,
            'currency_code' => $this->currency(),
            'payment_method' => $method,
            'payment_type' => OnlineFeePaymentService::TYPE,
            'attribute_id' => (string) $student->id,
            'attribute' => 'student',
            'payment_platform' => 'web',
            'external_redirect_link' => $request->redirect_url,
            'payer_information' => ['name' => $user->name, 'email' => $user->email, 'phone' => $request->phone ?? $user->phone],
            'additional_data' => json_encode([
                'status' => 'pending',
                'payer_user_id' => $user->id,
                'fee_heads' => $feeHeads,
            ]),
        ]);

        if ($simulate) {
            return $this->startSimulatedMpesa($payment, (string) $request->phone);
        }

        try {
            return $method === 'mpesa'
                ? $this->startMpesa($payment, $setting, $student, (string) $request->phone)
                : $this->startPaystack($payment, $setting, $user);
        } catch (Throwable $e) {
            report($e);
            $this->service->fail($payment, $e->getMessage());

            return $this->responseError([], $e->getMessage(), 422);
        }
    }

    public function status(string $paymentId): JsonResponse
    {
        $payment = PaymentRequest::whereKey($paymentId)
            ->where('payment_type', OnlineFeePaymentService::TYPE)
            ->where('institute_id', Auth::user()->institute_id)
            ->first();
        if (! $payment) {
            return $this->responseError([], _lang('Payment not found.'), 404);
        }

        $data = $this->service->additionalData($payment);

        // Demo school: the simulated M-Pesa payment "arrives" a few seconds after the prompt.
        if (! $payment->is_paid && ! empty($data['simulated']) && ($data['status'] ?? '') === 'pending'
            && $payment->created_at->diffInSeconds(now()) >= 6) {
            $this->service->confirm($payment->id, (float) $payment->payment_amount, 'DEMO'.strtoupper(Str::random(6)), ['simulated' => true]);
            $payment->refresh();
            $data = $this->service->additionalData($payment);
        }

        // M-Pesa callbacks can be slow or blocked by firewalls: ask Safaricom directly.
        if (! $payment->is_paid && $payment->payment_method === 'mpesa' && ($data['status'] ?? '') === 'pending'
            && ! empty($data['checkout_request_id']) && $payment->created_at->diffInSeconds(now()) >= 15) {
            $this->queryMpesa($payment, $data['checkout_request_id']);
            $payment->refresh();
            $data = $this->service->additionalData($payment);
        }

        return $this->responseSuccess($this->present($payment, $data), 'Payment status fetched successfully.');
    }

    public function history(): JsonResponse
    {
        $student = $this->currentStudent();
        $payments = PaymentRequest::where('payment_type', OnlineFeePaymentService::TYPE)
            ->where('institute_id', Auth::user()->institute_id)
            ->where('attribute_id', (string) ($student?->id ?? 0))
            ->latest()->limit(50)->get()
            ->map(fn ($p) => $this->present($p, $this->service->additionalData($p)));

        return $this->responseSuccess($payments, 'Payments fetched successfully.');
    }

    // ---------------------------------------------------------------- school admin

    public function adminIndex(Request $request): JsonResponse
    {
        $payments = PaymentRequest::where('payment_type', OnlineFeePaymentService::TYPE)
            ->where('institute_id', Auth::user()->institute_id)
            ->when($request->status === 'paid', fn ($q) => $q->where('is_paid', 1))
            ->latest()
            ->paginate((int) ($request->per_page ?: 20));

        $payments->getCollection()->transform(function ($p) {
            $student = Student::find((int) $p->attribute_id);

            return array_merge($this->present($p, $this->service->additionalData($p)), [
                'student_id' => $p->attribute_id,
                'student_name' => $student ? trim($student->first_name.' '.$student->last_name) : null,
                'payer' => $p->payer_information,
            ]);
        });

        return $this->responseSuccess($payments, 'Online fee payments fetched successfully.');
    }

    public function testMpesa(): JsonResponse
    {
        $setting = $this->gatewaySetting('mpesa');
        $mpesa = MpesaDarajaService::fromPaymentInfo($setting?->payment_info, $setting?->mode);
        if (! $mpesa->isConfigured()) {
            return $this->responseError([], _lang('Fill in the consumer key, consumer secret, shortcode and passkey first.'), 422);
        }

        try {
            $mpesa->accessToken();
        } catch (Throwable $e) {
            return $this->responseError([], $e->getMessage(), 422);
        }

        return $this->responseSuccess([
            'environment' => $mpesa->baseUrl(),
            'callback_url' => $mpesa->callbackBaseUrl().'/api/payment/mpesa/callback/{payment}/{token}',
        ], _lang('M-Pesa credentials are valid.'));
    }

    // ---------------------------------------------------------------- gateway callbacks (public)

    public function mpesaCallback(Request $request, string $paymentId, string $token): JsonResponse
    {
        $ack = response()->json(['ResultCode' => 0, 'ResultDesc' => 'Accepted']);
        if (! hash_equals($this->callbackToken($paymentId), $token)) {
            Log::warning('M-Pesa callback with bad token', ['payment_id' => $paymentId, 'ip' => $request->ip()]);

            return response()->json(['ResultCode' => 1, 'ResultDesc' => 'Rejected'], 403);
        }

        $callback = $request->input('Body.stkCallback', []);
        $payment = PaymentRequest::find($paymentId);
        if (! $payment || ! $callback) {
            return $ack;
        }

        $data = $this->service->additionalData($payment);
        if (($callback['CheckoutRequestID'] ?? null) !== ($data['checkout_request_id'] ?? null)) {
            Log::warning('M-Pesa callback for another checkout', ['payment_id' => $paymentId]);

            return $ack;
        }

        $this->applyMpesaResult($payment, (int) ($callback['ResultCode'] ?? 1), (string) ($callback['ResultDesc'] ?? ''), MpesaDarajaService::callbackMetadata($callback));

        return $ack;
    }

    public function paystackCallback(Request $request): RedirectResponse|JsonResponse
    {
        $payment = PaymentRequest::where('payment_type', OnlineFeePaymentService::TYPE)->find($request->query('payment_id'));
        if (! $payment) {
            return response()->json(['message' => 'Payment not found'], 404);
        }

        $ok = $this->verifyPaystack($payment, (string) $request->query('reference', ''));
        $target = $payment->external_redirect_link ?: rtrim((string) config('app.frontend_url'), '/').'/';

        return redirect()->away($target.(str_contains($target, '?') ? '&' : '?').http_build_query([
            'payment_id' => $payment->id,
            'flag' => $ok ? 'success' : 'fail',
        ]));
    }

    public function paystackWebhook(Request $request): JsonResponse
    {
        $reference = (string) $request->input('data.reference', '');
        $payment = PaymentRequest::where('payment_type', OnlineFeePaymentService::TYPE)
            ->where('payment_method', 'paystack')
            ->where('transaction_id', $reference)
            ->first();
        if (! $payment) {
            return response()->json(['status' => 'ignored']);
        }

        $setting = $this->gatewaySetting('paystack', $payment->institute_id, $payment->branch_id);
        $paystack = PaystackService::fromPaymentInfo($setting?->payment_info);
        if (! $paystack->validWebhookSignature($request->getContent(), $request->header('x-paystack-signature'))) {
            return response()->json(['status' => 'invalid signature'], 401);
        }

        if ($request->input('event') === 'charge.success') {
            $this->verifyPaystack($payment, $reference);
        }

        return response()->json(['status' => 'ok']);
    }

    // ---------------------------------------------------------------- internals

    private function startMpesa(PaymentRequest $payment, Setting $setting, Student $student, string $phone): JsonResponse
    {
        $msisdn = MpesaDarajaService::normalizePhone($phone);
        if (! $msisdn) {
            throw new \RuntimeException(_lang('Enter a valid Safaricom number, e.g. 0712 345 678.'));
        }

        $mpesa = MpesaDarajaService::fromPaymentInfo($setting->payment_info, $setting->mode);
        if (! $mpesa->isConfigured()) {
            throw new \RuntimeException(_lang('M-Pesa is not set up for this school yet.'));
        }

        $callbackUrl = $mpesa->callbackBaseUrl().'/api/payment/mpesa/callback/'.$payment->id.'/'.$this->callbackToken($payment->id);
        $result = $mpesa->stkPush($msisdn, (int) ceil($payment->payment_amount), 'ADM'.($student->registration_no ?: $student->id), 'School fees', $callbackUrl);

        $payment->transaction_id = $result['CheckoutRequestID'];
        $this->service->saveAdditionalData($payment, [
            'checkout_request_id' => $result['CheckoutRequestID'],
            'merchant_request_id' => $result['MerchantRequestID'] ?? null,
            'phone' => $msisdn,
        ]);

        return $this->responseSuccess([
            'payment_id' => $payment->id,
            'method' => 'mpesa',
            'message' => $result['CustomerMessage'] ?? _lang('Check your phone and enter your M-Pesa PIN.'),
        ], _lang('Payment prompt sent to your phone.'));
    }

    /**
     * The public demo school takes "payments" without Safaricom keys so visitors can try the
     * whole flow: no prompt is sent and no money moves. Real schools always need their own keys.
     */
    private function simulatesMpesa(?Setting $setting): bool
    {
        $demoInstitute = \App\Support\DemoAccounts::data()['institute'] ?? null;
        if (! \App\Support\DemoAccounts::enabled() || (int) Auth::user()?->institute_id !== (int) $demoInstitute) {
            return false;
        }

        return ! ($setting && $setting->status == '1' && MpesaDarajaService::fromPaymentInfo($setting->payment_info, $setting->mode)->isConfigured());
    }

    private function startSimulatedMpesa(PaymentRequest $payment, string $phone): JsonResponse
    {
        $msisdn = MpesaDarajaService::normalizePhone($phone);
        if (! $msisdn) {
            $this->service->fail($payment, 'Invalid phone number');

            return $this->responseError([], _lang('Enter a valid Safaricom number, e.g. 0712 345 678.'), 422);
        }
        $this->service->saveAdditionalData($payment, ['simulated' => true, 'phone' => $msisdn]);

        return $this->responseSuccess([
            'payment_id' => $payment->id,
            'method' => 'mpesa',
            'message' => _lang('Demo school: no real prompt is sent and no money moves. The payment will confirm in a few seconds.'),
        ], _lang('Payment prompt sent to your phone.'));
    }

    private function startPaystack(PaymentRequest $payment, Setting $setting, $user): JsonResponse
    {
        $paystack = PaystackService::fromPaymentInfo($setting->payment_info);
        if (! $paystack->isConfigured()) {
            throw new \RuntimeException(_lang('Paystack is not set up for this school yet.'));
        }

        $reference = 'CC-'.Str::upper(Str::random(12));
        $email = $user->email ?: ($setting->payment_info['merchant_email'] ?? null);
        if (! $email) {
            throw new \RuntimeException(_lang('Add an email address to your profile to pay with Paystack.'));
        }

        $result = $paystack->initialize($email, (float) $payment->payment_amount, $payment->currency_code, $reference,
            url('/payment/paystack/fee-callback').'?payment_id='.$payment->id,
            ['payment_id' => $payment->id, 'student_id' => $payment->attribute_id, 'custom_fields' => [
                ['display_name' => 'Student', 'variable_name' => 'student_id', 'value' => $payment->attribute_id],
            ]]);

        $payment->transaction_id = $reference;
        $this->service->saveAdditionalData($payment, ['reference' => $reference]);

        return $this->responseSuccess([
            'payment_id' => $payment->id,
            'method' => 'paystack',
            'authorization_url' => $result['authorization_url'],
        ], _lang('Redirecting to Paystack.'));
    }

    private function verifyPaystack(PaymentRequest $payment, string $reference): bool
    {
        if ($payment->is_paid) {
            return true;
        }
        if ($reference === '' || $reference !== $payment->transaction_id) {
            return false;
        }

        $setting = $this->gatewaySetting('paystack', $payment->institute_id, $payment->branch_id);
        try {
            $data = PaystackService::fromPaymentInfo($setting?->payment_info)->verify($reference);
        } catch (Throwable $e) {
            report($e);

            return false;
        }

        if (PaystackService::isSuccessfulFor($data, (float) $payment->payment_amount, $payment->currency_code)) {
            $this->service->confirm($payment->id, ((int) $data['amount']) / 100, $reference, ['channel' => $data['channel'] ?? null]);

            return true;
        }

        if (in_array($data['status'] ?? '', ['failed', 'abandoned', 'reversed'], true)) {
            $this->service->fail($payment, 'Paystack: '.($data['gateway_response'] ?? $data['status']));
        }

        return false;
    }

    private function queryMpesa(PaymentRequest $payment, string $checkoutRequestId): void
    {
        $setting = $this->gatewaySetting('mpesa', $payment->institute_id, $payment->branch_id);
        try {
            $result = MpesaDarajaService::fromPaymentInfo($setting?->payment_info, $setting?->mode)->stkQuery($checkoutRequestId);
        } catch (Throwable $e) {
            report($e);

            return;
        }
        if ($result !== null) {
            // The query does not return the receipt number; the callback fills it in if it arrives.
            $this->applyMpesaResult($payment, (int) $result['ResultCode'], (string) ($result['ResultDesc'] ?? ''), []);
        }
    }

    private function applyMpesaResult(PaymentRequest $payment, int $resultCode, string $resultDesc, array $meta): void
    {
        if ($resultCode === 0) {
            $receipt = (string) ($meta['MpesaReceiptNumber'] ?? $this->service->additionalData($payment)['checkout_request_id'] ?? '');
            $amount = (float) ($meta['Amount'] ?? $payment->payment_amount);
            $confirmed = $this->service->confirm($payment->id, $amount, $receipt, array_filter([
                'mpesa_receipt' => $meta['MpesaReceiptNumber'] ?? null,
                'mpesa_phone' => isset($meta['PhoneNumber']) ? (string) $meta['PhoneNumber'] : null,
                'result_desc' => $resultDesc,
            ]));
            // A late callback after a status-query confirmation still records the receipt.
            if ($confirmed && isset($meta['MpesaReceiptNumber'])) {
                $this->service->saveAdditionalData($confirmed, ['mpesa_receipt' => $meta['MpesaReceiptNumber']]);
            }

            return;
        }

        $this->service->fail($payment, $resultDesc ?: 'M-Pesa payment was not completed.');
    }

    private function present(PaymentRequest $payment, array $data): array
    {
        return [
            'id' => $payment->id,
            'method' => $payment->payment_method,
            'amount' => (float) $payment->payment_amount,
            'currency' => $payment->currency_code,
            'status' => $payment->is_paid ? 'paid' : ($data['status'] ?? 'pending'),
            'receipt' => $data['mpesa_receipt'] ?? ($payment->is_paid ? $payment->transaction_id : null),
            'message' => $data['result_desc'] ?? null,
            'posted_to_fees' => isset($data['collection_id']),
            'posting_error' => $data['posting_error'] ?? null,
            'created_at' => $payment->created_at?->toDateTimeString(),
        ];
    }

    private function currentStudent(): ?Student
    {
        $user = Auth::user();
        if ($user->user_type === 'Parent') {
            $studentId = DB::table('parent_models')->where('user_id', $user->id)->value('student_id');

            return $studentId ? Student::where('institute_id', $user->institute_id)->find($studentId) : null;
        }

        return Student::where('institute_id', $user->institute_id)->where('user_id', $user->id)->first();
    }

    private function gatewaySetting(string $name, ?int $instituteId = null, ?int $branchId = null): ?Setting
    {
        $instituteId ??= Auth::user()?->institute_id;
        $branchId ??= Auth::user()?->branch_id;

        return Setting::where('type', PAYMENT_CONFIG)->where('name', $name)
            ->where('institute_id', $instituteId)
            ->orderByRaw('branch_id = ? desc', [(int) $branchId])
            ->first();
    }

    private function availableMethods(): array
    {
        $methods = [];
        foreach (['mpesa' => 'M-Pesa', 'paystack' => 'Card / Paystack'] as $key => $label) {
            $setting = $this->gatewaySetting($key);
            $configured = $key === 'mpesa'
                ? MpesaDarajaService::fromPaymentInfo($setting?->payment_info, $setting?->mode)->isConfigured()
                : PaystackService::fromPaymentInfo($setting?->payment_info)->isConfigured();
            if ($setting && $setting->status == '1' && $configured) {
                $methods[] = ['key' => $key, 'label' => $label];
            } elseif ($key === 'mpesa' && $this->simulatesMpesa($setting)) {
                $methods[] = ['key' => 'mpesa', 'label' => 'M-Pesa (demo – no money moves)'];
            }
        }

        return $methods;
    }

    private function currency(): string
    {
        return strtoupper(get_option('currency_code') ?: 'KES');
    }

    private function callbackToken(string $paymentId): string
    {
        return substr(hash_hmac('sha256', 'mpesa|'.$paymentId, (string) config('app.key')), 0, 40);
    }
}
