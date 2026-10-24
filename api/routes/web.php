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
// Includes last-modified dates and the main image of each page (Google image sitemap extension).
Route::get('/sitemap.xml', function () {
    $posts = \App\Support\Blog::all();
    $landing = resource_path('views/saas-landing-page.blade.php');
    $homeModified = max(filemtime($landing), $posts->max(fn ($p) => $p['date']->timestamp) ?? 0);
    $img = fn (string $path, string $title) => '<image:image><image:loc>'.e(asset('assets/classcompass/'.$path)).'</image:loc><image:title>'.e($title).'</image:title></image:image>';
    $url = fn (string $loc, string $lastmod, string $freq, string $priority, string $images = '') => '<url><loc>'.e($loc).'</loc><lastmod>'.$lastmod.'</lastmod>'
        .'<changefreq>'.$freq.'</changefreq><priority>'.$priority.'</priority>'.$images.'</url>';

    $xml = '<?xml version="1.0" encoding="UTF-8"?>'
        .'<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">'
        .$url(url('/'), date('Y-m-d', $homeModified), 'weekly', '1.0',
            $img('screens/admin-dashboard.jpg', 'Class Compass school dashboard')
            .$img('screens/mpesa-flow.png', 'Paying school fees with M-Pesa in Class Compass')
            .$img('screens/parent-flow.png', 'Class Compass parent portal'))
        .$url(route('blog.index'), $posts->isNotEmpty() ? $posts->first()['date']->toDateString() : date('Y-m-d', $homeModified), 'weekly', '0.8')
        .$posts->map(fn ($p) => $url(route('blog.show', $p['slug']), date('Y-m-d', max($p['date']->timestamp, $p['updated'] ?? 0)), 'monthly', '0.7',
            $p['cover'] ? $img($p['cover'], $p['title']) : ''))->implode('')
        .'</urlset>';

    return response($xml, 200, ['Content-Type' => 'application/xml; charset=UTF-8']);
})->name('sitemap');

// Blog for the product website (posts are Markdown files in resources/blog).
Route::get('/blog', function (\Illuminate\Http\Request $request) {
    $all = \App\Support\Blog::all();
    $tag = $request->query('tag');
    $posts = $tag ? $all->filter(fn ($p) => in_array($tag, $p['tags'], true))->values() : $all;

    return view('blog.index', ['posts' => $posts, 'tag' => $tag, 'tags' => $all->pluck('tags')->flatten()->unique()->sort()->values()]);
})->name('blog.index');

Route::get('/blog/feed.xml', function () {
    $items = \App\Support\Blog::all()->take(20)->map(fn ($p) => '<item><title>'.e($p['title']).'</title><link>'.e(route('blog.show', $p['slug'])).'</link>'
        .'<guid>'.e(route('blog.show', $p['slug'])).'</guid><pubDate>'.$p['date']->toRfc2822String().'</pubDate><description>'.e($p['excerpt']).'</description></item>')->implode('');
    $xml = '<?xml version="1.0" encoding="UTF-8"?><rss version="2.0"><channel><title>'.e(config('app.name')).' blog</title>'
        .'<link>'.e(route('blog.index')).'</link><description>Guides for Kenyan schools</description><language>en-KE</language>'.$items.'</channel></rss>';

    return response($xml, 200, ['Content-Type' => 'application/rss+xml; charset=UTF-8']);
})->name('blog.feed');

Route::get('/blog/{slug}', function (string $slug) {
    $post = \App\Support\Blog::find($slug);
    abort_unless($post, 404);
    $more = \App\Support\Blog::all()->where('slug', '!=', $slug)
        ->sortByDesc(fn ($p) => count(array_intersect($p['tags'], $post['tags'])))->take(3)->values();

    return view('blog.show', ['post' => $post, 'more' => $more]);
})->where('slug', '[a-z0-9-]+')->name('blog.show');
