<?php

return [

    'paths' => [
        'api/*',
        'oauth/*',
        'sanctum/csrf-cookie',
        'storage/*',
    ],

    'allowed_methods' => ['*'],
    // Comma-separated list, e.g. https://app.classcompass.co.ke,https://compassacademy.ac.ke ("*" = any).
    'allowed_origins' => array_map('trim', explode(',', (string) env('CORS_ALLOWED_ORIGINS', '*'))),
    // Every school's own address (<name>.<SCHOOL_DOMAIN_SUFFIX>) may call the API.
    'allowed_origins_patterns' => env('SCHOOL_DOMAIN_SUFFIX')
        ? ['#^https?://([a-z0-9-]+\.)?'.preg_quote((string) env('SCHOOL_DOMAIN_SUFFIX'), '#').'$#i']
        : [],
    'allowed_headers' => ['*'],
    'exposed_headers' => ['Authorization', 'X-CSRF-TOKEN'],
    'max_age' => 0,
    // The apps authenticate with bearer tokens, not cookies.
    'supports_credentials' => false,
];
