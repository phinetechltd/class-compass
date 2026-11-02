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

        // Audit trail of every change, sign-in and sign-out (see user_logs).
        $middleware->appendToGroup('api', \App\Http\Middleware\AuditTrail::class);
    })
    ->withExceptions(function (Exceptions $exceptions) {
        // API errors always come back as the app's JSON shape with a plain message. Server errors are
        // logged in full but only a generic message (and a reference) is shown, unless debug is on.
        $exceptions->render(function (Throwable $e, Illuminate\Http\Request $request) {
            if (! $request->is('api/*') && ! $request->expectsJson()) {
                return null;
            }
            $json = fn (int $code, string $message, array $extra = []) => response()->json(
                ['status' => false, 'message' => $message, 'data' => null, 'errors' => []] + $extra, $code);

            return match (true) {
                $e instanceof Illuminate\Validation\ValidationException => $json(422, collect($e->errors())->flatten()->first() ?? 'Please check the form and try again.',
                    ['errors' => collect($e->errors())->map(fn ($m, $f) => ['code' => $f, 'message' => $m[0]])->values()->all()]),
                $e instanceof Illuminate\Auth\AuthenticationException => $json(401, 'Please sign in to continue.'),
                $e instanceof Illuminate\Auth\Access\AuthorizationException => $json(403, 'You do not have permission to do this.'),
                $e instanceof Illuminate\Database\Eloquent\ModelNotFoundException => $json(404, 'The record was not found. It may have been deleted.'),
                // A non-numeric ID in the address (e.g. /api/books/abc) reaching a controller that expects an int.
                $e instanceof TypeError && str_contains($e->getMessage(), 'must be of type int') && str_contains($e->getMessage(), 'Controller')
                    => $json(404, 'The record was not found. It may have been deleted.'),
                $e instanceof Symfony\Component\HttpKernel\Exception\NotFoundHttpException => $json(404, 'This address does not exist.'),
                $e instanceof Symfony\Component\HttpKernel\Exception\MethodNotAllowedHttpException => $json(405, 'This action is not allowed here.'),
                $e instanceof Illuminate\Http\Exceptions\ThrottleRequestsException => $json(429, 'Too many attempts. Please wait a minute and try again.'),
                $e instanceof Symfony\Component\HttpKernel\Exception\HttpExceptionInterface => $json($e->getStatusCode(), $e->getMessage() ?: 'The request could not be completed.'),
                default => (function () use ($e, $json) {
                    $ref = strtoupper(substr(sha1(uniqid('', true)), 0, 8));
                    Illuminate\Support\Facades\Log::error("[{$ref}] ".$e->getMessage(), ['exception' => $e]);

                    return config('app.debug')
                        ? $json(500, $e->getMessage(), ['reference' => $ref])
                        : $json(500, "Something went wrong on our side. Please try again; if it keeps happening, contact support with reference {$ref}.", ['reference' => $ref]);
                })(),
            };
        });
        $exceptions->dontReportDuplicates();
    })->create();
