<?php

namespace App\Support;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Scope;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use Throwable;

/**
 * Multi-school isolation. For a logged-in school user, every query on a table that has an
 * institute_id column only sees that school's rows, and "exists"/"unique" validation is checked
 * within the school. The platform admin, guests (public pages, payment callbacks) and console
 * commands are not scoped.
 */
class Tenancy implements Scope
{
    /** Shared or cross-school tables that must never be filtered. */
    private const NEVER = ['users', 'roles', 'permissions', 'role_has_permissions', 'model_has_roles',
        'model_has_permissions', 'institutes', 'oauth_access_tokens', 'oauth_clients', 'jobs', 'failed_jobs'];

    private static ?array $tables = null;

    private static bool $resolving = false;

    public static function tables(): array
    {
        if (self::$tables === null) {
            self::$tables = Cache::remember('tenancy.tables.v1', now()->addDay(), function () {
                try {
                    return DB::table('information_schema.columns')
                        ->where('table_schema', DB::getDatabaseName())
                        ->where('column_name', 'institute_id')
                        ->pluck('table_name')->map(fn ($t) => strtolower($t))->all();
                } catch (Throwable) {
                    return [];
                }
            });
        }

        return self::$tables;
    }

    public static function isTenantTable(string $table): bool
    {
        $table = strtolower(preg_replace('/\s+as\s+.*$/i', '', trim($table)));

        return in_array($table, self::tables(), true) && ! in_array($table, self::NEVER, true);
    }

    /** Institute to scope to, or null when no scoping applies. */
    public static function instituteId(): ?int
    {
        if (self::$resolving || app()->runningInConsole() && ! app()->runningUnitTests()) {
            return null;
        }
        self::$resolving = true;
        try {
            $user = Auth::guard('api')->user() ?? Auth::user();
        } catch (Throwable) {
            $user = null;
        } finally {
            self::$resolving = false;
        }

        if (! $user || ($user->user_type ?? null) === 'SAAS Admin') {
            return null;
        }
        // A school account without a school must not see every school's data.
        if (empty($user->institute_id)) {
            return -1;
        }

        return (int) $user->institute_id;
    }

    public function apply(Builder $builder, Model $model): void
    {
        $id = self::instituteId();
        if ($id !== null) {
            $builder->where($model->qualifyColumn('institute_id'), $id);
        }
    }
}
