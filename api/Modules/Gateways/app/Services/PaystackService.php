<?php

namespace Modules\Gateways\Services;

use Illuminate\Support\Facades\Http;
use RuntimeException;

/**
 * Minimal Paystack REST client. Amounts are in the main unit (e.g. KES) and converted to
 * the subunit (cents) Paystack expects. Kenyan merchants are settled in KES and can accept
 * cards and M-Pesa through Paystack's checkout.
 */
class PaystackService
{
    private const BASE_URL = 'https://api.paystack.co';

    public function __construct(private readonly string $secretKey) {}

    public static function fromPaymentInfo(?array $paymentInfo): self
    {
        $secret = (string) (($paymentInfo['secret_key'] ?? '') ?: config('services.paystack.secret_key', ''));

        return new self($secret);
    }

    public function isConfigured(): bool
    {
        return $this->secretKey !== '';
    }

    /**
     * @return array{authorization_url:string, access_code:string, reference:string}
     */
    public function initialize(string $email, float $amount, string $currency, string $reference, string $callbackUrl, array $metadata = []): array
    {
        $response = Http::timeout(30)->withToken($this->secretKey)
            ->post(self::BASE_URL.'/transaction/initialize', [
                'email' => $email,
                'amount' => (int) round($amount * 100),
                'currency' => strtoupper($currency),
                'reference' => $reference,
                'callback_url' => $callbackUrl,
                'metadata' => $metadata,
            ]);

        if (! $response->successful() || ! $response->json('status')) {
            throw new RuntimeException($response->json('message') ?? 'Paystack could not start the payment.');
        }

        return $response->json('data');
    }

    /**
     * Verify a transaction. Returns Paystack's "data" object.
     */
    public function verify(string $reference): array
    {
        $response = Http::timeout(30)->withToken($this->secretKey)
            ->get(self::BASE_URL.'/transaction/verify/'.rawurlencode($reference));

        if (! $response->successful() || ! $response->json('status')) {
            throw new RuntimeException($response->json('message') ?? 'Paystack verification failed.');
        }

        return $response->json('data');
    }

    /**
     * True when a verified transaction is successful and matches the expected amount and currency.
     */
    public static function isSuccessfulFor(array $data, float $expectedAmount, string $currency): bool
    {
        return ($data['status'] ?? null) === 'success'
            && (int) ($data['amount'] ?? 0) >= (int) round($expectedAmount * 100)
            && strtoupper((string) ($data['currency'] ?? '')) === strtoupper($currency);
    }

    public function validWebhookSignature(string $payload, ?string $signature): bool
    {
        return $signature !== null && hash_equals(hash_hmac('sha512', $payload, $this->secretKey), $signature);
    }
}
