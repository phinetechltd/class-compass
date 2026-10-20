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

// Demo logins for the sign-in page: only on the demo school's own website.
Route::get('/demo-accounts', function (\Illuminate\Http\Request $request) {
    $domain = \App\Support\DemoAccounts::domain();
    $from = strtolower((string) ($request->header('X-Domain') ?: $request->getHost()));
    $accounts = \App\Support\DemoAccounts::enabled() && $domain && $from === strtolower($domain) ? \App\Support\DemoAccounts::forSignIn() : [];

    return response()->json(['status' => true, 'message' => 'Demo accounts', 'data' => ['accounts' => $accounts], 'errors' => []]);
})->middleware('throttle:30,1');
