<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Modules\Authentication\Models\Subscription;
use Symfony\Component\HttpFoundation\Response;

/**
 * SaaS plan enforcement for school staff APIs.
 *
 * - No active subscription (missing, inactive or past end_date): every staff API answers 402,
 *   except the endpoints a school needs to sign in/out and renew (see ALLOW).
 * - Learner limit: checked only when creating learners (POST students, bulk import).
 * - Branch limit: checked only when creating branches (POST branches).
 *
 * The platform admin and portal users (parents, learners) are never blocked here; portal users
 * are already confined to the portal APIs by RestrictPortalUsers.
 *
 * Responses: 402 with {status:false, message, data:{code, ...}}. code is one of
 * subscription_expired, learner_limit_reached, branch_limit_reached.
 */
class CheckSubscription
{
    /** Reachable without an active subscription: [method|*, path regex] */
    private const ALLOW = [
        ['*', '#^api/(login|logout|change-password|profile|profile-update)$#'],
        ['*', '#^api/subscription/#'],
        ['GET', '#^api/(plans|get-packages|get-saas-settings|saas-digital-payment)$#'],
        ['GET', '#^api/administration/general_settings$#'],
    ];

    private const EXEMPT_USER_TYPES = ['SAAS Admin', 'Parent', 'Student'];

    public function handle(Request $request, Closure $next): Response
    {
        $user = $request->user('api');
        if (! $user || in_array($user->user_type, self::EXEMPT_USER_TYPES, true) || $this->allowed($request)) {
            return $next($request);
        }

        $instituteId = (int) $user->institute_id;
        $subscription = $instituteId ? self::activeSubscription($instituteId) : null;

        if (! $subscription) {
            $last = $instituteId ? Subscription::where('institute_id', $instituteId)->latest('end_date')->first() : null;
            $message = $last
                ? 'Your school\'s subscription expired on '.$last->end_date->format('j M Y').'. Renew your plan to continue.'
                : 'Your school has no active subscription. Choose a plan to continue.';

            return self::deny($message, 'subscription_expired', ['expired_on' => $last?->end_date?->toDateString()]);
        }

        if ($request->isMethod('POST')) {
            $path = ltrim($request->path(), '/');
            if (in_array($path, ['api/students', 'api/students-bulk-imports'], true) && self::learnerRoom($instituteId, $subscription) < 1) {
                return self::learnerLimitResponse($subscription);
            }
            if ($path === 'api/branches') {
                $limit = (int) $subscription->planLimits->branch_limit;
                if (DB::table('branches')->where('institute_id', $instituteId)->count() >= $limit) {
                    return self::deny("Your {$subscription->planLimits->name} plan allows {$limit} ".($limit === 1 ? 'branch' : 'branches').'. Upgrade your plan to add another.',
                        'branch_limit_reached', ['limit' => $limit, 'plan' => $subscription->planLimits->name]);
                }
            }
        }

        return $next($request);
    }

    public static function activeSubscription(int $instituteId): ?Subscription
    {
        return Subscription::with('planLimits')
            ->where('institute_id', $instituteId)
            ->where('status', 'active')
            ->whereDate('end_date', '>=', now())
            ->latest('end_date')
            ->first();
    }

    /** How many more learners the school's plan allows (active, not deleted learners count). */
    public static function learnerRoom(int $instituteId, ?Subscription $subscription = null): int
    {
        $subscription ??= self::activeSubscription($instituteId);
        if (! $subscription?->planLimits) {
            return 0;
        }
        $used = DB::table('students')->where('institute_id', $instituteId)->whereNull('deleted_at')->count();

        return max(0, (int) $subscription->planLimits->student_limit - $used);
    }

    public static function learnerLimitResponse(Subscription $subscription, ?int $importing = null): JsonResponse
    {
        $plan = $subscription->planLimits;
        $message = "Your {$plan->name} plan allows up to ".number_format($plan->student_limit).' learners.';
        if ($importing !== null) {
            $room = self::learnerRoom((int) $subscription->institute_id, $subscription);
            $message .= " This file has {$importing} learners but only {$room} more can be added.";
        }

        return self::deny($message.' Upgrade your plan to add more.', 'learner_limit_reached',
            ['limit' => (int) $plan->student_limit, 'plan' => $plan->name]);
    }

    private static function deny(string $message, string $code, array $extra = []): JsonResponse
    {
        return response()->json([
            'status' => false,
            'message' => $message,
            'data' => ['code' => $code] + $extra,
        ], 402);
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
