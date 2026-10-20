<?php

namespace Modules\Gateways\Http\Controllers\WEB;

use App\Http\Controllers\Controller;
use App\Traits\PaymentProcess;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use Modules\Gateways\Models\PaymentRequest;
use Modules\Gateways\Services\PaystackService;
use Throwable;

/**
 * Redirect-style Paystack checkout used by the generic digital-payment flow
 * (e.g. a school paying its Class Compass subscription).
 *
 * The transaction is initialised server-side with a callback that carries the payment id,
 * and the result is verified with Paystack (status, amount and currency) before it is marked paid.
 */
class PaystackController extends Controller
{
    use PaymentProcess;

    public function index(Request $request): RedirectResponse|JsonResponse
    {
        $validator = Validator::make($request->all(), ['payment_id' => 'required|uuid']);
        if ($validator->fails()) {
            return response()->json($this->responseFormatter(GATEWAYS_DEFAULT_400, null, $this->errorProcessor($validator)), 400);
        }

        $payment = PaymentRequest::where('id', $request->payment_id)->where('is_paid', 0)->first();
        if (! $payment) {
            return response()->json($this->responseFormatter(GATEWAYS_DEFAULT_204), 200);
        }

        $paystack = $this->client($payment);
        if (! $paystack->isConfigured()) {
            return response()->json(['message' => 'Paystack is not configured.'], 422);
        }

        $reference = 'CC-'.Str::upper(Str::random(12));
        $email = $payment->email ?: ($payment->payer_information['email'] ?? null) ?: 'billing@'.parse_url(config('app.url'), PHP_URL_HOST);

        try {
            $result = $paystack->initialize($email, (float) $payment->payment_amount, $payment->currency_code ?: 'KES', $reference,
                route('paystack.callback', ['payment_id' => $payment->id]),
                ['payment_id' => $payment->id, 'payment_type' => $payment->payment_type]);
        } catch (Throwable $e) {
            report($e);

            return response()->json(['message' => $e->getMessage()], 422);
        }

        $payment->update(['transaction_id' => $reference]);

        return redirect()->away($result['authorization_url']);
    }

    public function redirectToGateway(Request $request): RedirectResponse|JsonResponse
    {
        return $this->index($request);
    }

    public function handleGatewayCallback(Request $request): RedirectResponse|JsonResponse
    {
        $payment = PaymentRequest::find($request->query('payment_id'));
        if (! $payment) {
            return response()->json(['message' => 'Payment not found.'], 404);
        }
        if ($payment->is_paid) {
            return $this->paymentResponse($payment, 'success');
        }

        $reference = (string) $request->query('reference', $request->query('trxref', ''));
        if ($reference === '' || $reference !== $payment->transaction_id) {
            return $this->paymentResponse($payment, 'fail');
        }

        try {
            $data = $this->client($payment)->verify($reference);
        } catch (Throwable $e) {
            report($e);

            return $this->paymentResponse($payment, 'fail');
        }

        if (! PaystackService::isSuccessfulFor($data, (float) $payment->payment_amount, $payment->currency_code ?: 'KES')) {
            return $this->paymentResponse($payment, 'fail');
        }

        $payment->update(['payment_method' => 'paystack', 'is_paid' => 1]);

        return $this->paymentResponse($payment->fresh(), 'success');
    }

    private function client(PaymentRequest $payment): PaystackService
    {
        $config = $this->paymentConfig('paystack', PAYMENT_CONFIG, $payment);

        return PaystackService::fromPaymentInfo($config?->payment_info);
    }
}
