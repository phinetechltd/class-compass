<?php

namespace App\Http\Middleware;

use Closure;

class CheckInstallation
{
    public function handle($request, Closure $next)
    {
        if (! file_exists(storage_path('classCompass'))) {
            return redirect('/install');
        }

        return $next($request);
    }
}
