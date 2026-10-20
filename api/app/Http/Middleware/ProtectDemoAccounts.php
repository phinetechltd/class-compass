<?php

namespace App\Http\Middleware;

use App\Support\DemoAccounts;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

/**
 * Public demo logins must keep working for the next visitor: they cannot change their own
 * password or profile, or delete their account. (Anything else is put back by the nightly
 * `classcompass:demo-accounts --refresh`.)
 */
class ProtectDemoAccounts
{
    private const BLOCKED = [
        'api/change-password', 'api/profile-update', 'api/student-change-password', 'api/student/profile-update',
        'api/delete-account', 'api/account-delete',
    ];

    public function handle(Request $request, Closure $next): Response
    {
        if (! $request->isMethod('GET') && DemoAccounts::enabled() && $request->is(self::BLOCKED)) {
            $user = Auth::guard('api')->user();
            if ($user && DemoAccounts::isDemoEmail($user->email)) {
                return response()->json([
                    'status' => false,
                    'message' => 'This is a shared demo account, so its login details cannot be changed.',
                    'data' => null, 'errors' => [],
                ], 403);
            }
        }

        return $next($request);
    }
}
