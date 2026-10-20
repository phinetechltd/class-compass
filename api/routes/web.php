<?php

use App\Http\Controllers\WEB\InstallController;
use App\Http\Controllers\WebsiteController;
use Illuminate\Support\Facades\Route;

Route::get('/', [WebsiteController::class, 'index'])->name('index')->middleware('checkInstallation');
// ---------------- Installation Process ----------------- //
Route::prefix('install')->middleware('checkInstallationStatus')->group(function () {
    // 1️⃣ Start Installation
    Route::get('/', [InstallController::class, 'index'])->name('install.start');
    Route::get('start', [InstallController::class, 'index']);
    // 2️⃣ Requirements Check
    Route::get('requirements', [InstallController::class, 'requirements'])->name('install.requirements');
    // 3️⃣ Permissions Check
    Route::get('permissions', [InstallController::class, 'permissions'])->name('install.permissions');
    // 4️⃣ Database Setup
    Route::get('database', [InstallController::class, 'showDatabaseForm'])->name('install.database');
    Route::post('check-database', [InstallController::class, 'checkDatabase'])->name('install.check_database');
    Route::post('database/save', [InstallController::class, 'saveDatabase'])->name('install.database.save');
    // 5️⃣ Installation / Migration & Seed
    Route::any('installation', [InstallController::class, 'installation'])->name('install.installation');
});
// ---------------- End Installation ----------------- //
// 6️⃣ Complete
Route::get('install/complete', [InstallController::class, 'complete'])->name('install.complete');


Route::get('/saas-landing-page', [WebsiteController::class, 'saasLandingPage'])->name('saas-landing-page');
// Print pages are only reachable through short-lived signed links issued by
// POST /api/print-links (PrintLinkController); unsigned or edited URLs get 403.
Route::middleware('signed')->group(function () {
    Route::get('/student-vital/{encodedData}', [WebsiteController::class, 'vital'])->name('student-vital');
    Route::get('student-list-for-card-print/{encodedData}', [WebsiteController::class, 'studentIdCardList'])->name('studentIdCardList');
    Route::get('staff-list-for-card-print/{encodedData}', [WebsiteController::class, 'staffIdCardList'])->name('staffIdCardList');
    Route::get('teacher-list-for-card-print/{encodedData}', [WebsiteController::class, 'teacherIdCardList'])->name('teacherIdCardList');
});

// Sitemap for the product site (school sites are served by the web app).
Route::get('/sitemap.xml', function () {
    $xml = '<?xml version="1.0" encoding="UTF-8"?>'
        .'<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'
        .'<url><loc>'.e(url('/')).'</loc><changefreq>weekly</changefreq><priority>1.0</priority></url>'
        .'</urlset>';

    return response($xml, 200, ['Content-Type' => 'application/xml']);
})->name('sitemap');
