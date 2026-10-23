<?php

use App\Http\Controllers\LanguageController;
use App\Http\Controllers\PrintLinkController;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Route;

Route::prefix('languages')->group(function () {
    // Public: the app loads translations before login.
    Route::get('/', [LanguageController::class, 'index']);
    Route::get('/export/{name}', [LanguageController::class, 'export']);

    // Translations are shared by every school, so only the platform admin may change them.
    Route::middleware(['auth:api', 'saas.admin'])->group(function () {
        Route::post('/', [LanguageController::class, 'store']);
        Route::post('/update-key/{name}', [LanguageController::class, 'updateKey']);
        Route::post('/import/{name}', [LanguageController::class, 'import']);
        Route::post('/set-default/{name}', [LanguageController::class, 'setDefault']);
    });
});

Route::get('/check-status', function () {
    try {
        DB::connection()->getPdo(); // test DB

        return response()->json([
            'status' => true,
            'message' => 'API and Database are working perfectly',
        ]);
    } catch (Exception $e) {
        return response()->json([
            'status' => false,
            'message' => $e->getMessage(),
        ]);
    }
});

// Signed, short-lived links to the public print pages (ID cards, student vital).
Route::middleware(['auth:api', 'check.subscription', 'throttle:60,1'])->post('/print-links', [PrintLinkController::class, 'generate']);

// Curriculum presets (CBC, 8-4-4, British, College/TVET)
Route::middleware(['auth:api', 'check.subscription'])->group(function () {
    Route::get('/curriculum', [\App\Http\Controllers\CurriculumController::class, 'index']);
    Route::post('/curriculum/apply', [\App\Http\Controllers\CurriculumController::class, 'apply'])->middleware('throttle:10,1');
});

// Demo logins for the sign-in page: on the demo school's own website, from the SaaS product site, and on localhost.
Route::get('/demo-accounts', function (\Illuminate\Http\Request $request) {
    $domain = \App\Support\DemoAccounts::domain();
    $from = strtolower((string) ($request->header('X-Domain') ?: $request->getHost()));
    $fromHost = explode(':', $from)[0];
    $saasHost = parse_url((string) config('app.url'), PHP_URL_HOST);
    $localHosts = ['localhost', '127.0.0.1', '0.0.0.0', 'institute1.com'];
    $allowed = $domain && (
        $fromHost === strtolower($domain) ||
        $fromHost === $saasHost ||
        in_array($fromHost, $localHosts)
    );
    $accounts = \App\Support\DemoAccounts::enabled() && $allowed ? \App\Support\DemoAccounts::forSignIn() : [];

    // Share of register days marked present (1 = present, 2 = absent) on the daily register.
    $attendanceRate = function (int $studentId, int $instituteId): string {
        $days = DB::table('student_attendances')->where('student_id', $studentId)->where('institute_id', $instituteId)->where('period_id', 1);
        $total = (clone $days)->count();

        return $total ? round((clone $days)->where('attendance', 1)->count() / $total * 100, 1).'%' : 'No register yet';
    };

    // Enrich each demo account with historic data so the sign-in page shows what each role will see.
    $enriched = array_map(function ($account) use ($domain, $attendanceRate) {
        $user = \Modules\Authentication\Models\User::where('email', $account['email'])->first();
        if (! $user) {
            return $account;
        }

        $data = array_merge($account, [
            'user_id' => $user->id,
            'user_type' => $user->user_type,
        ]);

        switch (strtolower($user->user_type ?? '')) {
            case 'super admin':
                $data['summary'] = [
                    'students' => DB::table('students')->where('institute_id', $user->institute_id)->count(),
                    'teachers' => DB::table('users')->where('institute_id', $user->institute_id)->where('user_type', 'Teacher')->count(),
                    'classes' => DB::table('classes')->where('institute_id', $user->institute_id)->count(),
                    'fee_records' => DB::table('fees')->where('institute_id', $user->institute_id)->count(),
                ];
                break;

            case 'accountant':
                $total = DB::table('fees')->where('institute_id', $user->institute_id)->sum('fee_amount');
                $data['summary'] = [
                    'total_fees' => $total,
                    'fee_records' => DB::table('fees')->where('institute_id', $user->institute_id)->count(),
                    'currency' => 'KES',
                ];
                break;

            case 'parent':
                // Find the parent's child(ren) via parent_models
                $parentLink = DB::table('parent_models')->where('user_id', $user->id)->where('institute_id', $user->institute_id)->first();
                if ($parentLink) {
                    $child = DB::table('students')->where('id', $parentLink->student_id)->first();
                    if ($child) {
                        $childUser = DB::table('users')->where('id', $child->user_id)->first();
                        $data['summary'] = [
                            'child_name' => $child->first_name . ' ' . $child->last_name,
                            'child_email' => $childUser->email ?? '',
                            'registration_no' => $child->registration_no,
                            'attendance_rate' => $attendanceRate($child->id, $user->institute_id),
                        ];
                    }
                }
                break;

            case 'student':
                $student = DB::table('students')->where('user_id', $user->id)->where('institute_id', $user->institute_id)->first();
                if ($student) {
                    $className = DB::table('student_sessions')->join('classes', 'classes.id', '=', 'student_sessions.class_id')
                        ->where('student_sessions.student_id', $student->id)->orderByDesc('student_sessions.id')->value('classes.class_name');
                    $data['summary'] = [
                        'registration_no' => $student->registration_no,
                        'class' => $className ?? 'Not assigned',
                        'attendance_rate' => $attendanceRate($student->id, $user->institute_id),
                        'attendance_days' => DB::table('student_attendances')
                            ->where('student_id', $student->id)
                            ->where('institute_id', $user->institute_id)
                            ->count(),
                    ];
                }
                break;

            case 'teacher':
                $teacherClasses = DB::table('class_assigns')
                    ->where('class_assigns.teacher_id', $user->id)
                    ->where('class_assigns.institute_id', $user->institute_id)
                    ->join('classes', 'class_assigns.class_id', '=', 'classes.id')
                    ->pluck('classes.class_name')
                    ->toArray();
                $data['summary'] = [
                    'classes' => $teacherClasses,
                    'class_count' => count($teacherClasses),
                ];
                break;

            case 'librarian':
                $data['summary'] = [
                    'books' => DB::table('books')->where('institute_id', $user->institute_id)->count(),
                    'book_issues' => DB::table('book_issues')->where('institute_id', $user->institute_id)->count(),
                ];
                break;

            case 'hostel':
                $data['summary'] = [
                    'message' => 'Hostel management: dormitories, members, meals and boarding bills.',
                ];
                break;

            case 'transport':
                $data['summary'] = [
                    'buses' => DB::table('buses')->where('institute_id', $user->institute_id)->count(),
                    'routes' => DB::table('bus_routes')->where('institute_id', $user->institute_id)->count(),
                    'drivers' => DB::table('drivers')->where('institute_id', $user->institute_id)->count(),
                ];
                break;

            default:
                $data['summary'] = ['message' => 'Demo account for ' . ($user->user_type ?? 'user')];
        }

        return $data;
    }, $accounts);

    return response()->json([
        'status' => true,
        'message' => 'Demo accounts',
        'data' => ['accounts' => $enriched],
        'errors' => [],
    ]);
})->middleware('throttle:30,1');

// One-click demo login: authenticates a demo account and returns a Passport access token.
// Used by the SaaS landing page demo cards so visitors can try the system without signing up.
Route::post('/demo-login', function (\Illuminate\Http\Request $request) {
    $request->validate(['email' => ['required', 'email']]);
    $email = strtolower($request->email);

    $demo = \App\Support\DemoAccounts::data();
    if (! \App\Support\DemoAccounts::enabled()) {
        return response()->json(['status' => false, 'message' => 'Demo logins are not available.'], 403);
    }
    $isDemo = collect($demo['accounts'] ?? [])->contains(fn ($a) => strtolower($a['email'] ?? '') === $email);
    if (! $isDemo) {
        return response()->json(['status' => false, 'message' => 'Not a demo account.'], 403);
    }

    $user = \Modules\Authentication\Models\User::where('email', $email)->first();
    if (! $user) {
        return response()->json(['status' => false, 'message' => 'Demo user not found.'], 404);
    }

    $accessToken = $user->createToken('demo')->accessToken;

    return response()->json([
        'status' => true,
        'message' => 'Demo login successful.',
        'data' => ['access_token' => $accessToken, 'user' => [
            'id' => $user->id,
            'name' => $user->name,
            'email' => $user->email,
            'role' => $user->role?->name ?? 'no-role-assign',
            'user_type' => $user->user_type,
            'institute_id' => $user->institute_id,
        ]],
    ]);
})->middleware('throttle:10,1');
