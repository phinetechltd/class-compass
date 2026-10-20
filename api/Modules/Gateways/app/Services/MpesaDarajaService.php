<?php

namespace Modules\Gateways\Services;

use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Http;
use RuntimeException;

/**
 * Safaricom M-Pesa Daraja client (Lipa na M-Pesa Online / STK Push).
 *
 * Each school stores its own credentials in settings.payment_info (name = "mpesa"):
 *   consumer_key, consumer_secret, shortcode, passkey,
 *   transaction_type ("paybill" | "till"), till_number (Buy Goods only),
 *   environment ("sandbox" | "production"), callback_url (optional public HTTPS base URL).
 */
class MpesaDarajaService
{
    public const SANDBOX_URL = 'https://sandbox.safaricom.co.ke';

    public const PRODUCTION_URL = 'https://api.safaricom.co.ke';

    public function __construct(private readonly array $config) {}

    public static function fromPaymentInfo(?array $paymentInfo, ?string $mode = null): self
    {
        $config = $paymentInfo ?? [];
        $config['environment'] = $config['environment'] ?? ($mode === 'live' ? 'production' : 'sandbox');

        return new self($config);
    }

    public function isConfigured(): bool
    {
        foreach (['consumer_key', 'consumer_secret', 'shortcode', 'passkey'] as $key) {
            if (empty($this->config[$key])) {
                return false;
            }
        }

        return ! ($this->isTill() && empty($this->config['till_number']));
    }

    public function baseUrl(): string
    {
        return ($this->config['environment'] ?? 'sandbox') === 'production' ? self::PRODUCTION_URL : self::SANDBOX_URL;
    }

    public function isTill(): bool
    {
        return ($this->config['transaction_type'] ?? 'paybill') === 'till';
    }

    public function accessToken(): string
    {
        $cacheKey = 'mpesa_token_'.md5($this->baseUrl().($this->config['consumer_key'] ?? ''));

        return Cache::remember($cacheKey, now()->addMinutes(50), function () {
            $response = Http::timeout(30)
                ->withBasicAuth((string) $this->config['consumer_key'], (string) $this->config['consumer_secret'])
                ->get($this->baseUrl().'/oauth/v1/generate', ['grant_type' => 'client_credentials']);

            $token = $response->json('access_token');
            if (! $response->successful() || ! $token) {
                throw new RuntimeException('M-Pesa authentication failed. Check the consumer key, consumer secret and environment.');
            }

            return $token;
        });
    }

    /**
     * Send an STK push prompt to the customer's phone.
     *
     * @return array{MerchantRequestID:string, CheckoutRequestID:string, ResponseCode:string, CustomerMessage:string}
     */
    public function stkPush(string $phone, int $amount, string $accountReference, string $description, string $callbackUrl): array
    {
        $timestamp = now('Africa/Nairobi')->format('YmdHis');
        $shortcode = (string) $this->config['shortcode'];

        $response = Http::timeout(30)->withToken($this->accessToken())
            ->post($this->baseUrl().'/mpesa/stkpush/v1/processrequest', [
                'BusinessShortCode' => $shortcode,
                'Password' => $this->password($timestamp),
                'Timestamp' => $timestamp,
                'TransactionType' => $this->isTill() ? 'CustomerBuyGoodsOnline' : 'CustomerPayBillOnline',
                'Amount' => max(1, $amount),
                'PartyA' => $phone,
                'PartyB' => $this->isTill() ? (string) $this->config['till_number'] : $shortcode,
                'PhoneNumber' => $phone,
                'CallBackURL' => $callbackUrl,
                'AccountReference' => mb_substr($accountReference, 0, 12),
                'TransactionDesc' => mb_substr($description, 0, 13),
            ]);

        $body = $response->json() ?? [];
        if (! $response->successful() || ($body['ResponseCode'] ?? null) !== '0') {
            throw new RuntimeException($body['errorMessage'] ?? $body['ResponseDescription'] ?? 'M-Pesa could not send the payment prompt.');
        }

        return $body;
    }

    /**
     * Ask Safaricom for the result of an STK push (used when the callback is late or missing).
     * Returns null while the customer has not finished yet.
     */
    public function stkQuery(string $checkoutRequestId): ?array
    {
        $timestamp = now('Africa/Nairobi')->format('YmdHis');

        $response = Http::timeout(30)->withToken($this->accessToken())
            ->post($this->baseUrl().'/mpesa/stkpushquery/v1/query', [
                'BusinessShortCode' => (string) $this->config['shortcode'],
                'Password' => $this->password($timestamp),
                'Timestamp' => $timestamp,
                'CheckoutRequestID' => $checkoutRequestId,
            ]);

        $body = $response->json() ?? [];
        if (isset($body['ResultCode'])) {
            return $body;
        }

        // "The transaction is being processed" comes back as an error until the customer acts.
        return null;
    }

    public function callbackBaseUrl(): string
    {
        return rtrim($this->config['callback_url'] ?? '' ?: config('app.url'), '/');
    }

    private function password(string $timestamp): string
    {
        return base64_encode($this->config['shortcode'].$this->config['passkey'].$timestamp);
    }

    /**
     * Normalise Kenyan numbers (07.., 01.., +254.., 254..) to 2547XXXXXXXX / 2541XXXXXXXX.
     */
    public static function normalizePhone(?string $phone): ?string
    {
        $digits = preg_replace('/\D+/', '', (string) $phone);
        if (preg_match('/^0([17]\d{8})$/', $digits, $m)) {
            return '254'.$m[1];
        }
        if (preg_match('/^([17]\d{8})$/', $digits, $m)) {
            return '254'.$m[1];
        }
        if (preg_match('/^254([17]\d{8})$/', $digits)) {
            return $digits;
        }

        return null;
    }

    /**
     * Flatten the CallbackMetadata items of an STK callback into [Name => Value].
     */
    public static function callbackMetadata(array $stkCallback): array
    {
        $items = $stkCallback['CallbackMetadata']['Item'] ?? [];
        $data = [];
        foreach ($items as $item) {
            if (isset($item['Name'])) {
                $data[$item['Name']] = $item['Value'] ?? null;
            }
        }

        return $data;
    }
}
