<?php

namespace App\Console\Commands;

use App\Support\DemoAccounts;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

/**
 * Sets up the public demo logins for the demo school, and locks the other accounts that
 * came with the vendor demo (they all shared a well-known password).
 *
 *   php artisan classcompass:demo-accounts --password="Demo..." --admin-email=you@example.com
 *   php artisan classcompass:demo-accounts --refresh      (nightly: puts demo logins back)
 */
class DemoAccountsCommand extends Command
{
    protected $signature = 'classcompass:demo-accounts
        {--password= : Shared password for the demo logins (shown on the demo sign-in page)}
        {--institute=1 : The demo school}
        {--domain=demo.classcompass.co.ke : Domain of the demo school website}
        {--admin-email= : New login email for the platform (SaaS) admin}
        {--refresh : Re-apply the saved demo logins (for the nightly schedule)}
        {--disable : Stop showing demo logins}';

    protected $description = 'Create the public demo logins and lock the vendor default accounts';

    public function handle(): int
    {
        if ($this->option('disable')) {
            DemoAccounts::save([]);
            $this->info('Demo logins are no longer shown.');

            return self::SUCCESS;
        }

        $saved = DemoAccounts::data();
        $refresh = (bool) $this->option('refresh');
        $password = $refresh ? ($saved['password'] ?? null) : $this->option('password');
        if (! $password) {
            if ($refresh) {
                return self::SUCCESS; // nothing set up yet
            }
            $this->error('Pass --password for the demo logins.');

            return self::FAILURE;
        }
        if (! $refresh && strlen($password) < 8) {
            $this->error('Use at least 8 characters.');

            return self::FAILURE;
        }

        $institute = (int) ($refresh ? ($saved['institute'] ?? 1) : $this->option('institute'));
        $domain = $refresh ? ($saved['domain'] ?? null) : $this->option('domain');
        $hash = Hash::make($password);
        $accounts = [];

        foreach (DemoAccounts::ROLES as $key => $role) {
            $user = DB::table('users')->where('institute_id', $institute)
                ->whereIn('email', array_merge([$role['email']], $role['old']))->orderByRaw('email = ? desc', [$role['email']])->first();
            if (! $user) {
                $this->warn("No {$role['label']} account found in school {$institute}; skipped.");

                continue;
            }
            DB::table('users')->where('id', $user->id)->update([
                'email' => $role['email'], 'password' => $hash, 'status' => 1, 'updated_at' => now(),
            ] + (isset($role['name']) ? ['name' => $role['name']] : []));
            $accounts[] = ['key' => $key, 'label' => $role['label'], 'description' => $role['description'], 'email' => $role['email'], 'user_id' => $user->id];
        }
        // Signed-in demo sessions keep working; a changed password from the day is undone.
        DemoAccounts::save(['institute' => $institute, 'domain' => $domain, 'password' => $password, 'accounts' => $accounts]);

        if ($refresh) {
            $this->info('Demo logins refreshed.');

            return self::SUCCESS;
        }

        // Every other vendor demo account shared the password "12345678": give each a random one.
        $demoIds = array_column($accounts, 'user_id');
        $locked = 0;
        foreach (DB::table('users')->where('email', 'like', '%@gmail.com')->whereNotIn('id', $demoIds)
            ->whereIn('email', ['saasadmin@gmail.com', 'systemadmin@gmail.com', 'librarian@gmail.com', 'hostel@gmail.com', 'transport@gmail.com', 'teacher1@gmail.com', 'parent@gmail.com', 'student@gmail.com'])
            ->get() as $user) {
            $new = Str::password(20, symbols: false);
            $changes = ['password' => Hash::make($new), 'updated_at' => now()];
            if ($user->user_type === 'SAAS Admin') {
                if ($email = $this->option('admin-email')) {
                    $changes['email'] = $email;
                }
                DB::table('users')->where('id', $user->id)->update($changes);
                $this->line('');
                $this->info('Platform (SaaS) admin login — save this now, it is not stored anywhere:');
                $this->line('  Email:    '.($changes['email'] ?? $user->email));
                $this->line('  Password: '.$new);
            } else {
                DB::table('users')->where('id', $user->id)->update($changes);
                $locked++;
            }
        }
        DB::table('oauth_access_tokens')->whereNotIn('user_id', $demoIds)->update(['revoked' => 1]);

        $this->line('');
        $this->info(count($accounts).' demo logins ready on '.$domain.'; '.$locked.' other vendor accounts locked with random passwords.');

        return self::SUCCESS;
    }
}
