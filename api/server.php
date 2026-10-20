<?php

/**
 * Laravel - A PHP Framework For Web Artisans
 *
 * @author   Taylor Otwell <taylor@laravel.com>
 */
$uri = urldecode(
    parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH)
);

// This file allows us to emulate Apache's "mod_rewrite" functionality from the
// built-in PHP web server. This provides a convenient way to test a Laravel
// application without having installed a "real" web server software here.
if ($uri !== '/' && is_file(__DIR__.'/public'.$uri)) {
    // The Flutter web app runs on another origin and can only draw images that carry a CORS header.
    $types = [
        'png' => 'image/png', 'jpg' => 'image/jpeg', 'jpeg' => 'image/jpeg', 'gif' => 'image/gif',
        'webp' => 'image/webp', 'svg' => 'image/svg+xml', 'ico' => 'image/x-icon', 'pdf' => 'application/pdf',
    ];
    $ext = strtolower(pathinfo($uri, PATHINFO_EXTENSION));
    if (isset($types[$ext])) {
        header('Content-Type: '.$types[$ext]);
        header('Access-Control-Allow-Origin: *');
        header('Content-Length: '.filesize(__DIR__.'/public'.$uri));
        readfile(__DIR__.'/public'.$uri);

        return true;
    }

    return false;
}

require_once __DIR__.'/public/index.php';
