@php
    $app = config('app.name', 'Class Compass');
    $frontend = rtrim((string) config('app.frontend_url'), '/');
    $demo = rtrim((string) config('app.demo_url'), '/');
    $contact = config('app.contact', []);
    $asset = fn ($p) => asset('assets/classcompass/'.$p);
    $pageTitle = trim($__env->yieldContent('title')) ?: 'Blog';
    $pageDescription = trim($__env->yieldContent('description')) ?: 'Guides for Kenyan schools on CBC, school fees, M-Pesa, parent communication and running a modern school.';
    $pageImage = trim($__env->yieldContent('image')) ?: $asset('og-image.jpg');
@endphp
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{{ $pageTitle }} | {{ $app }}</title>
    <meta name="description" content="{{ $pageDescription }}">
    <link rel="canonical" href="{{ url()->current() }}">
    <meta property="og:site_name" content="{{ $app }}">
    <meta property="og:type" content="@yield('og_type', 'website')">
    <meta property="og:title" content="{{ $pageTitle }}">
    <meta property="og:description" content="{{ $pageDescription }}">
    <meta property="og:url" content="{{ url()->current() }}">
    <meta property="og:image" content="{{ $pageImage }}">
    <meta name="twitter:card" content="summary_large_image">
    <link rel="alternate" type="application/rss+xml" title="{{ $app }} blog" href="{{ route('blog.feed') }}">
    <link rel="icon" href="{{ asset('favicon.ico') }}">
    <link rel="apple-touch-icon" href="{{ $asset('apple-touch-icon.png') }}">
    <meta name="theme-color" content="#043268">
    @stack('head')
    <style>
        :root{--navy:#043268;--blue:#016DF6;--green:#00C090;--mpesa:#00A651;--ink:#0f1f3a;--text:#41506a;--muted:#6b7a92;--line:#e4eaf3;--bg:#f6f9fd;--radius:18px;--shadow:0 18px 50px rgba(4,50,104,.10)}
        *{box-sizing:border-box}
        html{scroll-behavior:smooth}
        body{margin:0;font-family:"Segoe UI",system-ui,-apple-system,Roboto,"Helvetica Neue",Arial,sans-serif;color:var(--text);background:#fff;line-height:1.7;-webkit-font-smoothing:antialiased}
        img{max-width:100%;display:block}
        a{color:var(--blue)}
        h1,h2,h3{color:var(--ink);line-height:1.2;letter-spacing:-.02em}
        .wrap{width:min(1180px,100% - 32px);margin:0 auto}
        .btn{display:inline-flex;align-items:center;gap:8px;padding:13px 20px;border-radius:12px;font-weight:700;text-decoration:none;border:1px solid transparent;font-size:15px}
        .btn-primary{background:linear-gradient(135deg,var(--blue),#0057d9);color:#fff;box-shadow:0 10px 24px rgba(1,109,246,.28)}
        .btn-ghost{background:#fff;color:var(--navy);border-color:var(--line)}
        .nav{position:sticky;top:0;z-index:20;background:rgba(255,255,255,.94);backdrop-filter:blur(10px);border-bottom:1px solid var(--line)}
        .nav .wrap{display:flex;align-items:center;gap:22px;height:72px}
        .nav img{height:42px;width:auto}
        .nav-links{display:flex;gap:22px;margin-left:auto;font-weight:600;font-size:15px}
        .nav-links a{text-decoration:none;color:var(--text)}.nav-links a:hover,.nav-links a.on{color:var(--blue)}
        .nav .login{font-weight:700;text-decoration:none;color:var(--navy)}
        @media (max-width:860px){.nav-links{display:none}.nav .login{margin-left:auto}}
        .eyebrow{display:inline-block;font-size:13px;font-weight:700;letter-spacing:.08em;text-transform:uppercase;color:var(--blue)}
        .tag{display:inline-block;font-size:12px;font-weight:700;color:var(--navy);background:var(--bg);border:1px solid var(--line);border-radius:999px;padding:3px 10px;margin:0 6px 6px 0;text-decoration:none}
        .meta{font-size:14px;color:var(--muted)}
        footer{background:#061a3a;color:#9fb3cf;padding:48px 0 26px;margin-top:80px}
        footer a{color:#c9d8f2;text-decoration:none;display:block;padding:3px 0}
        .foot{display:grid;grid-template-columns:1.4fr 1fr 1fr 1fr;gap:28px}
        @media (max-width:860px){.foot{grid-template-columns:1fr 1fr}}
        footer h4{color:#fff;margin:0 0 10px;font-size:15px}
        .copy{display:flex;justify-content:space-between;flex-wrap:wrap;gap:10px;border-top:1px solid rgba(255,255,255,.12);margin-top:32px;padding-top:18px;font-size:13px}
        .cta{margin-top:56px;border-radius:24px;padding:36px;background:linear-gradient(135deg,var(--navy),#0b4aa8);color:#d6e4fb;display:flex;flex-wrap:wrap;gap:20px;align-items:center;justify-content:space-between}
        .cta h3{color:#fff;margin:0 0 6px;font-size:24px}.cta p{margin:0}
        .cta .btn-ghost{border-color:transparent}
        @yield('styles')
    </style>
</head>
<body>
<header class="nav">
    <div class="wrap">
        <a href="{{ url('/') }}" aria-label="{{ $app }} home"><img src="{{ $asset('logo.png') }}" alt="{{ $app }}" width="160" height="43"></a>
        <nav class="nav-links" aria-label="Main">
            <a href="{{ url('/') }}#features">Features</a>
            <a href="{{ url('/') }}#mpesa">M-Pesa fees</a>
            <a href="{{ url('/') }}#pricing">Pricing</a>
            <a href="{{ route('blog.index') }}" class="on">Blog</a>
            <a href="{{ $demo }}/sign-in">Live demo</a>
        </nav>
        <a class="login" href="{{ $frontend }}/sign-in">Log in</a>
        <a class="btn btn-primary" href="{{ url('/') }}#get-started">Start free trial</a>
    </div>
</header>

<main>
    @yield('content')
</main>

<footer>
    <div class="wrap">
        <div class="foot">
            <div>
                <img src="{{ $asset('logo-reversed.png') }}" alt="{{ $app }}" width="160" height="49" loading="lazy">
                <p style="margin:12px 0 0;max-width:320px">School management for Kenyan schools: CBC, M-Pesa fees, attendance and parent communication in one place.</p>
            </div>
            <div><h4>Product</h4><a href="{{ url('/') }}#features">Features</a><a href="{{ url('/') }}#pricing">Pricing</a><a href="{{ $demo }}/sign-in">Live demo</a><a href="{{ route('blog.index') }}">Blog</a></div>
            <div><h4>Get started</h4><a href="{{ url('/') }}#get-started">Free trial</a><a href="{{ $frontend }}/sign-in">Log in</a><a href="https://taristudio.africa" rel="noopener">Tari Studio: AI ads for schools</a></div>
            <div><h4>Contact</h4>
                @if (! empty($contact['email']))<a href="mailto:{{ $contact['email'] }}">{{ $contact['email'] }}</a>@endif
                <span style="display:block;padding:3px 0">Nairobi, Kenya</span>
            </div>
        </div>
        <div class="copy"><span>&copy; {{ date('Y') }} {{ $app }}. All rights reserved.</span><span><a href="{{ route('blog.feed') }}" style="display:inline">RSS</a> · Made in Kenya 🇰🇪</span></div>
    </div>
</footer>
</body>
</html>
