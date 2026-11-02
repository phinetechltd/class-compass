<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Modules\Authentication\Models\User;
use Symfony\Component\HttpFoundation\Response;
use Throwable;

/**
 * Audit trail: every successful change made through the API (POST/PUT/PATCH/DELETE) is written to
 * user_logs with who, what kind of record, which record, the address and the IP. Sign-ins and
 * sign-outs are recorded too. Request bodies are never stored, so passwords, keys and personal
 * details stay out of the log. Logging can never break the request it records.
 */
class AuditTrail
{
    /** Endpoints that change nothing worth auditing, or are recorded elsewhere. */
    private const SKIP = ['api/print-links', 'api/demo-accounts', 'api/demo-login', 'api/online-fees/payments/*',
        'api/payment/*', 'api/frontend/*', 'api/user-logs*', 'api/v1/student-otp-*', 'api/get-*'];

    public function handle(Request $request, Closure $next): Response
    {
        $response = $next($request);

        try {
            $this->record($request, $response);
        } catch (Throwable $e) {
            report($e);
        }

        return $response;
    }

    private function record(Request $request, Response $response): void
    {
        $method = $request->method();
        if (! in_array($method, ['POST', 'PUT', 'PATCH', 'DELETE'], true) || $response->getStatusCode() >= 300 || $request->attributes->get('audited')) {
            return;
        }
        $path = ltrim($request->path(), '/');
        if (! str_starts_with($path, 'api/') || $request->is(self::SKIP)) {
            return;
        }

        if ($request->is('api/login', 'api/v1/student-login')) {
            $user = User::where('email', (string) $request->input('email'))->first();
            $this->write($user, 'login', 'Signed in', 'User', $user?->id, $request);

            return;
        }

        $user = Auth::guard('api')->user();
        if (! $user) {
            return;
        }
        if ($request->is('api/logout', 'api/student-logout')) {
            $this->write($user, 'logout', 'Signed out', 'User', $user->id, $request);

            return;
        }

        // "api/students/12" -> model "students", id 12; "api/fee-collect" -> "fee-collect".
        $segments = array_values(array_filter(explode('/', Str::after($path, 'api/'))));
        $modelId = collect($request->route()?->parameters() ?? [])->first(fn ($v) => is_numeric($v));
        $model = collect($segments)->reject(fn ($s) => is_numeric($s))->implode('/');
        $action = match (true) {
            $method === 'DELETE' || Str::contains($model, ['delete', 'destroy']) => 'delete',
            Str::contains($model, ['fee-collect', 'quick-collection', 'student-collection', 'collect']) => 'fee_collect',
            Str::contains($model, ['payment', 'pay']) => 'payment',
            in_array($method, ['PUT', 'PATCH'], true) || Str::contains($model, ['update', 'edit', 'status']) || $modelId !== null => 'update',
            default => 'create',
        };
        $label = ucfirst(str_replace(['-', '_', '/'], ' ', $model));
        $this->write($user, $action, Str::limit(ucfirst($action === 'fee_collect' ? 'fee collection' : $action).': '.$label.($modelId ? " #{$modelId}" : ''), 185, ''),
            Str::limit($model, 185, ''), is_numeric($modelId) ? (int) $modelId : null, $request);
    }

    private function write(?User $user, string $action, string $detail, ?string $model, ?int $modelId, Request $request): void
    {
        if (! $user || ! $user->institute_id) {
            return;
        }
        DB::table('user_logs')->insert([
            'institute_id' => $user->institute_id,
            'branch_id' => $user->branch_id ?: 1,
            'user_id' => $user->id,
            'ip_address' => $request->ip(),
            'action' => $action,
            'detail' => $detail,
            'model' => $model,
            'model_id' => $modelId,
            'url' => Str::limit($request->path(), 185, ''),
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    }
}
