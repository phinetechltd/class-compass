<?php

namespace App\Providers;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Database\Eloquent\Relations\Relation;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\ServiceProvider;
use Laravel\Passport\Passport;
use Modules\Elearning\Models\Lesson;
use Modules\QuestionBank\Models\Quiz;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        // "exists"/"unique" validation is checked within the logged-in user's school.
        // (extend, not singleton: the validation provider is deferred and would replace a binding)
        $this->app->extend('validation.presence', fn ($verifier, $app) => new \App\Support\TenantPresenceVerifier($app['db']));
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        Relation::morphMap([
            'lesson' => Lesson::class,
            // 'quiz' => Quiz::class,
            // 'assignment' => Assignment::class,
            // 'pdf' => Pdf::class,
            // 'offline' => Offline::class,
        ]);

        Passport::personalAccessTokensExpireIn(now()->addMonths(1));

        // Multi-school isolation: every model on a table with institute_id only sees the
        // logged-in user's school (platform admin, guests and console are not scoped).
        \Illuminate\Support\Facades\Event::listen('eloquent.booted: *', function (string $event, array $payload) {
            $model = $payload[0] ?? null;
            if ($model instanceof \Illuminate\Database\Eloquent\Model && \App\Support\Tenancy::isTenantTable($model->getTable())) {
                $model::addGlobalScope('institute', new \App\Support\Tenancy);
            }
        });

        // Ensure database is configured before running queries
        try {
            if (DB::connection()->getPdo()) {
                // Register factory namespace for the modular structure
                Factory::guessFactoryNamesUsing(function (string $modelName) {
                    return 'Modules\\Authentication\\Database\\Factories\\'.class_basename($modelName).'Factory';
                });
            }
        } catch (\Exception $e) {
            // ❌ Prevent crash when DB is not set up
        }

        Schema::defaultStringLength(191);

        // Behind HTTPS, always generate https:// links (payment callbacks, signed URLs).
        if (str_starts_with((string) config('app.url'), 'https://')) {
            \Illuminate\Support\Facades\URL::forceScheme('https');
        }
    }
}
