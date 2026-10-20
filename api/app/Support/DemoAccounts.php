<?php

namespace App\Support;

use Illuminate\Support\Facades\Storage;

/**
 * Public demo logins for the demo school. Set up with `php artisan classcompass:demo-accounts`;
 * the list lives in storage/app/demo-accounts.json (not in git). The sign-in page shows them
 * only on the demo school's domain, and demo users cannot change their own login details.
 */
class DemoAccounts
{
    private const FILE = 'demo-accounts.json';

    /** Login emails for the demo roles, with the older emails they replace. */
    public const ROLES = [
        'admin' => ['label' => 'School admin', 'description' => 'Runs the whole school: learners, staff, fees, exams and the website.',
            'email' => 'admin@demo.classcompass.co.ke', 'old' => ['superadmin@gmail.com']],
        'accountant' => ['label' => 'Bursar', 'description' => 'Fee collection, M-Pesa payments, invoices and accounts.',
            'email' => 'bursar@demo.classcompass.co.ke', 'old' => ['accountant@gmail.com']],
        'parent' => ['label' => 'Parent', 'description' => 'Wanjiku\'s parent: attendance, report cards and paying fees.',
            'email' => 'parent@demo.classcompass.co.ke', 'old' => ['parent@classcompass.test']],
        'learner' => ['label' => 'Learner', 'description' => 'Wanjiku Kamau, Grade 7: timetable, homework and results.',
            'email' => 'learner@demo.classcompass.co.ke', 'old' => ['learner@classcompass.test']],
    ];

    private static ?array $data = null;

    public static function data(): array
    {
        if (self::$data === null) {
            $raw = Storage::disk('local')->exists(self::FILE) ? Storage::disk('local')->get(self::FILE) : null;
            self::$data = json_decode((string) $raw, true) ?: [];
        }

        return self::$data;
    }

    public static function save(array $data): void
    {
        Storage::disk('local')->put(self::FILE, json_encode($data, JSON_PRETTY_PRINT));
        self::$data = $data;
    }

    public static function enabled(): bool
    {
        return ! empty(self::data()['accounts']);
    }

    public static function domain(): ?string
    {
        return self::data()['domain'] ?? null;
    }

    public static function isDemoEmail(?string $email): bool
    {
        return $email && in_array(strtolower($email), array_map('strtolower', array_column(self::data()['accounts'] ?? [], 'email')), true);
    }

    /** What the sign-in page shows: labels, emails and the shared demo password. */
    public static function forSignIn(): array
    {
        $password = self::data()['password'] ?? '';

        return array_map(fn ($a) => [
            'label' => $a['label'], 'description' => $a['description'], 'email' => $a['email'], 'password' => $password,
        ], self::data()['accounts'] ?? []);
    }
}
