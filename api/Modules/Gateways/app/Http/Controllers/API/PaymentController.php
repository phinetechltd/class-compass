<?php

namespace Modules\Gateways\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Traits\Authenticatable;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Modules\Authentication\Models\SAASSetting;
use Modules\Gateways\Models\PaymentRequest;
use Modules\SystemConfiguration\Models\Setting;

class PaymentController extends Controller
{
    use Authenticatable;

    /**
     * Gateways every school can configure. Rows are created on first use, so schools that
     * signed up through onboarding (which seeds no gateway rows) still get them.
     */
    private const SCHOOL_GATEWAYS = [
        'mpesa' => [
            'consumer_key' => '', 'consumer_secret' => '', 'shortcode' => '', 'passkey' => '',
            'transaction_type' => 'paybill', 'till_number' => '', 'environment' => 'sandbox', 'callback_url' => '',
        ],
        'paystack' => ['public_key' => '', 'secret_key' => '', 'merchant_email' => '', 'callback_url' => ''],
    ];

    public function index(Request $request): JsonResponse
    {
        abort_unless(\App\Support\SensitiveSettings::canManage($request->user()), 403, 'You are not allowed to view payment settings.');
        $instituteId = $this->getCurrentInstituteId();
        $branchId = auth()->user()->branch_id;
        foreach (self::SCHOOL_GATEWAYS as $name => $defaults) {
            $exists = Setting::where(['type' => PAYMENT_CONFIG, 'name' => $name, 'institute_id' => $instituteId])->exists();
            if (! $exists && $instituteId) {
                Setting::create([
                    'institute_id' => $instituteId, 'branch_id' => $branchId, 'type' => PAYMENT_CONFIG,
                    'name' => $name, 'payment_info' => $defaults, 'mode' => 'test', 'status' => '0',
                ]);
            }
        }

        $paymentMethods = Setting::where('type', PAYMENT_CONFIG)
            ->where('institute_id', $instituteId)
            ->orderByRaw("FIELD(name, 'mpesa', 'paystack') = 0, FIELD(name, 'mpesa', 'paystack')")
            ->get();

        return $this->responseSuccess($paymentMethods, 'Payment methods list fetched successfully.');
    }

    private function findSchoolGateway($settingId): ?Setting
    {
        abort_unless(\App\Support\SensitiveSettings::canManage(auth()->user()), 403, 'You are not allowed to change payment settings.');

        return Setting::where('type', PAYMENT_CONFIG)
            ->where('institute_id', $this->getCurrentInstituteId())
            ->findOrFail($settingId);
    }

    public function saasIndex(Request $request): JsonResponse
    {
        $paymentMethods = SAASSetting::where('type', PAYMENT_CONFIG)->get();

        // Schools only need to know which platform gateways exist, never their keys.
        if (auth()->user()->user_type !== 'SAAS Admin') {
            $paymentMethods = $paymentMethods->map(fn ($m) => [
                'id' => $m->id, 'name' => $m->name, 'type' => $m->type, 'mode' => $m->mode, 'status' => $m->status,
            ])->values();
        }

        return $this->responseSuccess($paymentMethods, 'Payment methods list fetched successfully.');
    }

    public function update(Request $request, $settingId): JsonResponse
    {
        $setting = $this->findSchoolGateway($settingId);
        $info = is_array($request->payment_info) ? $request->payment_info : [];
        if (isset(self::SCHOOL_GATEWAYS[$setting->name])) {
            // Keep only this gateway's keys, trimmed (the app sends every gateway's fields).
            $info = array_map(fn ($v) => is_string($v) ? trim($v) : $v,
                array_intersect_key(array_merge(self::SCHOOL_GATEWAYS[$setting->name], array_filter($info, fn ($v) => $v !== null)), self::SCHOOL_GATEWAYS[$setting->name]));
        }
        $setting->update([
            'payment_info' => $info,
            'mode' => $request->mode ?? 'test',
            'status' => $request->status ?? '1',
            'updated_at' => now(),
        ]);

        return $this->responseSuccess($setting, 'Payment method credentials update successfully.');
    }

    public function statusUpdate($paymentId)
    {
        $setting = $this->findSchoolGateway($paymentId);
        $setting->update([
            'status' => $setting->status === '1' ? '0' : '1',
            'updated_at' => now(),
        ]);

        return $this->responseSuccess($setting, 'Payment method status updated successfully.');
    }

    public function saasUpdate(Request $request, $settingId): JsonResponse
    {
        abort_unless(auth()->user()->user_type === 'SAAS Admin', 403, 'Only the platform admin can change platform payment settings.');
        $setting = SAASSetting::findOrFail($settingId);
        $setting->update([
            'payment_info' => $request->payment_info,
            'mode' => $request->mode ?? 'test',
            'status' => $request->status ?? '1',
            'updated_at' => now(),
        ]);

        return $this->responseSuccess($setting, 'Payment method credentials update successfully.');
    }

    public function saasStatusUpdate($paymentId)
    {
        abort_unless(auth()->user()->user_type === 'SAAS Admin', 403, 'Only the platform admin can change platform payment settings.');
        $setting = SAASSetting::findOrFail($paymentId);
        $setting->update([
            'status' => $setting->status === '1' ? '0' : '1',
            'updated_at' => now(),
        ]);

        return $this->responseSuccess($setting, 'SAAS Payment method status updated successfully.');
    }

    public function payment(Request $request): JsonResponse
    {
        // Validate request
        $validator = Validator::make($request->all(), [
            'payment_method' => 'required|string',
            'payment_type' => 'required|string',
            'amount' => 'required|numeric|min:0',
            'currency' => 'required|string',
            'name' => 'nullable|string',
            'phone' => 'required|string',
            'email' => 'nullable|string',
            'plan_id' => 'nullable|string',
            'notes' => 'nullable|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => 'fail',
                'message' => $validator->errors()->first(),
            ], 400);
        }

        $paymentMethod = strtolower($request->payment_method);
        $amount = $request->amount;
        $currencyCode = $request->currency ?? 'USD'; // Set your default currency or fetch dynamically

        $payment = new PaymentRequest;
        $payment->institute_id = get_institute_id();
        $payment->branch_id = get_branch_id();
        $payment->payment_amount = $amount;
        $payment->currency_code = $currencyCode;
        $payment->payment_method = $paymentMethod;
        $payment->payment_type = $request->payment_type;
        $payment->name = $request->name ?? null;
        $payment->phone = $request->phone ?? null;
        $payment->email = $request->email ?? null;
        $payment->plan_id = $request->plan_id ?? null;
        $payment->notes = $request->notes ?? null;
        $payment->gateway_callback_url = $request->gateway_callback_url ?? null;
        $payment->external_redirect_link = $request->external_redirect_link ?? null;
        $payment->success_hook = $request->success_hook ?? null;
        $payment->failure_hook = $request->failure_hook ?? null;
        $payment->payment_platform = $request->payment_platform ?? null;

        $payment->save();

        $paymentUrl = $this->generatePaymentUrl($payment);
        if (! $paymentUrl) {
            return response()->json([
                'status' => 'fail',
                'message' => 'Invalid payment method.',
            ], 400);
        }

        return response()->json([
            'status' => 'success',
            'payment_url' => $paymentUrl,
        ]);
    }

    private function generatePaymentUrl(PaymentRequest $payment)
    {
        $routes = [
            'ssl_commerz' => 'payment/sslcommerz/pay',
            'stripe' => 'payment/stripe/pay',
            'paymob_accept' => 'payment/paymob/pay',
            'flutterwave' => 'payment/flutterwave-v3/pay',
            'paytm' => 'payment/paytm/pay',
            'paypal' => 'payment/paypal/pay',
            'paytabs' => 'payment/paytabs/pay',
            'liqpay' => 'payment/liqpay/pay',
            'razor_pay' => 'payment/razor-pay/pay',
            'senang_pay' => 'payment/senang-pay/pay',
            'mercadopago' => 'payment/mercadopago/pay',
            'bkash' => 'payment/bkash/make-payment',
            'paystack' => 'payment/paystack/pay',
        ];

        if (array_key_exists($payment->payment_method, $routes)) {
            return url("{$routes[$payment->payment_method]}?payment_id={$payment->id}");
        }

        return false;
    }

    public function success(Request $request): JsonResponse
    {
        return response()->json(['message' => 'Payment succeeded'], 200);
    }

    public function fail(): JsonResponse
    {
        return response()->json(['message' => 'Payment failed'], 403);
    }

    public function saasPayment(Request $request): JsonResponse
    {
        // Validate request
        $validator = Validator::make($request->all(), [
            'payment_method' => 'required|string',
            'payment_type' => 'required|string',
            'amount' => 'required|numeric|min:0',
            'currency' => 'required|string',
            'name' => 'nullable|string',
            'phone' => 'required|string',
            'email' => 'nullable|string',
            'plan_id' => 'nullable|string',
            'notes' => 'nullable|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => 'fail',
                'message' => $validator->errors()->first(),
            ], 400);
        }

        $paymentMethod = strtolower($request->payment_method);
        $amount = $request->amount;
        $currencyCode = $request->currency ?? 'USD'; // Set your default currency or fetch dynamically

        $payment = new PaymentRequest;
        $payment->institute_id = get_institute_id();
        $payment->branch_id = get_branch_id();
        $payment->payment_amount = $amount;
        $payment->currency_code = $currencyCode;
        $payment->payment_method = $paymentMethod;
        $payment->payment_type = $request->payment_type;
        $payment->name = $request->name ?? null;
        $payment->phone = $request->phone ?? null;
        $payment->email = $request->email ?? null;
        $payment->plan_id = $request->plan_id ?? null;
        $payment->notes = $request->notes ?? null;
        $payment->gateway_callback_url = $request->gateway_callback_url ?? null;
        $payment->external_redirect_link = $request->external_redirect_link ?? null;
        $payment->success_hook = $request->success_hook ?? null;
        $payment->failure_hook = $request->failure_hook ?? null;
        $payment->payment_platform = $request->payment_platform ?? null;

        $payment->save();

        $paymentUrl = $this->generatePaymentUrl($payment);
        if (! $paymentUrl) {
            return response()->json([
                'status' => 'fail',
                'message' => 'Invalid payment method.',
            ], 400);
        }

        return response()->json([
            'status' => 'success',
            'payment_url' => $paymentUrl,
        ]);
    }
}
