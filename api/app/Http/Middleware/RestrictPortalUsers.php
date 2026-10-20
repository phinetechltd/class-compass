<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * Parents and learners may only use the parent/learner portal APIs. Every other
 * authenticated API (students, fees setup, accounting, payroll, settings...) is staff-only.
 */
class RestrictPortalUsers
{
    /** Allowed for parents/learners: [method|*, path regex] */
    private const ALLOW = [
        ['*', '#^api/(parent|student)/#'],
        ['*', '#^api/online-fees(/|$)#'],
        ['*', '#^api/frontend/#'],
        ['*', '#^api/(login|logout|change-password|profile|profile-update)$#'],
        ['*', '#^api/print-links$#'],
        ['GET', '#^api/(languages.*|check-status|notices|initial-data|zooms|galleries|topics|video-cyper)$#'],
        ['GET', '#^api/administration/general_settings$#'],
        ['*', '#^api/answers$#'],
        ['GET', '#^api/(get-packages|get-saas-settings|get-saas-faqs|get-feedbacks)$#'],
    ];

    public function handle(Request $request, Closure $next): Response
    {
        $user = $request->user('api');
        if ($user && in_array($user->user_type, ['Parent', 'Student'], true) && ! $this->allowed($request)) {
            return response()->json([
                'status' => false,
                'message' => 'You are not allowed to access this resource.',
                'data' => null,
            ], 403);
        }

        return $next($request);
    }

    private function allowed(Request $request): bool
    {
        $path = ltrim($request->path(), '/');
        foreach (self::ALLOW as [$method, $pattern]) {
            if (($method === '*' || $request->isMethod($method)) && preg_match($pattern, $path)) {
                return true;
            }
        }

        return false;
    }
}
