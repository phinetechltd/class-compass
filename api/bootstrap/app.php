<?php

use App\Http\Middleware\CheckInstallation;
use App\Http\Middleware\CheckInstallationStatus;
use App\Http\Middleware\CheckSubscription;
use App\Http\Middleware\ParentModelClass;
use App\Http\Middleware\RestrictPortalUsers;
use App\Http\Middleware\Student;
use App\Http\Middleware\Teacher;
use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;
use Illuminate\Http\Middleware\HandleCors;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        api: __DIR__.'/../routes/api.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware) {

        $middleware->alias([
            'parent' => ParentModelClass::class,
            'teacher' => Teacher::class,
            'student' => Student::class,
            'checkInstallation' => CheckInstallation::class,
            'checkInstallationStatus' => CheckInstallationStatus::class,
            'check.subscription' => CheckSubscription::class,
            'saas.admin' => \App\Http\Middleware\SaasAdminOnly::class,
        ]);

        $middleware->append([
            HandleCors::class,
        ]);

        // Behind a load balancer/reverse proxy set TRUSTED_PROXIES (e.g. "*" or a list of IPs).
        if ($proxies = env('TRUSTED_PROXIES')) {
            $middleware->trustProxies(at: $proxies === '*' ? '*' : array_map('trim', explode(',', $proxies)));
        }

        // Parents and learners only reach the portal APIs.
        $middleware->appendToGroup('api', RestrictPortalUsers::class);

        // Staff only reach the modules their role's permissions allow (same groups as the sidebar).
        $middleware->appendToGroup('api', \App\Http\Middleware\EnforceStaffPermissions::class);

        // Shared demo logins cannot change their own login details.
        $middleware->appendToGroup('api', \App\Http\Middleware\ProtectDemoAccounts::class);
    })
    ->withExceptions(function (Exceptions $exceptions) {
        //
    })->create();
