<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class SaasAdminOnly
{
    public function handle(Request $request, Closure $next): Response
    {
        if ($request->user()?->user_type !== 'SAAS Admin') {
            return response()->json(['status' => false, 'message' => 'Only the platform admin can do this.', 'data' => null], 403);
        }

        return $next($request);
    }
}
