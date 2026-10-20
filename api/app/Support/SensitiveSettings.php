<?php

namespace App\Support;

use Illuminate\Contracts\Auth\Authenticatable;

/**
 * Keeps credentials (SMS, Zoom, payment gateways, Vercel...) out of settings responses for
 * anyone who is not allowed to manage the school's or the platform's configuration.
 */
class SensitiveSettings
{
    /** Settings that hold a whole payment-gateway configuration. */
    private const GATEWAYS = ['bkash', 'flutterwave', 'mpesa', 'paymob_accept', 'paypal', 'paystack', 'paytm', 'pvit',
        'razor_pay', 'senang_pay', 'ssl_commerz', 'stripe', 'liqpay', 'mercadopago', 'paytabs'];

    public static function isSensitive(string $name): bool
    {
        return in_array($name, self::GATEWAYS, true)
            || (bool) preg_match('/(secret|token|password|passkey|api_key|_sid$|client_key|account_id|vercel_)/i', $name);
    }

    public static function redact(iterable $settings): array
    {
        $out = [];
        foreach ($settings as $name => $value) {
            if (! self::isSensitive((string) $name)) {
                $out[$name] = $value;
            }
        }

        return $out;
    }

    /** School admins with the system-settings permission, or the platform admin. */
    public static function canManage(?Authenticatable $user): bool
    {
        if (! $user) {
            return false;
        }
        if (($user->user_type ?? null) === 'SAAS Admin') {
            return true;
        }
        if (in_array($user->user_type ?? null, ['Parent', 'Student', 'Teacher'], true)) {
            return false;
        }

        try {
            return $user->getAllPermissions()->contains('name', 'master_configuration.system_settings');
        } catch (\Throwable) {
            return false;
        }
    }
}
