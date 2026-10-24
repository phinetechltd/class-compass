@extends('blog.layout')

@section('title', $post['title'])
@section('description', $post['excerpt'])
@section('og_type', 'article')
@if ($post['cover'])
    @section('image', asset('assets/classcompass/'.$post['cover']))
@endif

@push('head')
    <meta property="article:published_time" content="{{ $post['date']->toIso8601String() }}">
    <script type="application/ld+json">{!! json_encode([
        '@context' => 'https://schema.org',
        '@type' => 'BlogPosting',
        'headline' => $post['title'],
        'description' => $post['excerpt'],
        'datePublished' => $post['date']->toDateString(),
        'author' => ['@type' => 'Organization', 'name' => $post['author']],
        'publisher' => ['@type' => 'Organization', 'name' => config('app.name'), 'logo' => ['@type' => 'ImageObject', 'url' => asset('assets/classcompass/logo.png')]],
        'image' => $post['cover'] ? asset('assets/classcompass/'.$post['cover']) : null,
        'mainEntityOfPage' => url()->current(),
        'dateModified' => date('Y-m-d', max($post['date']->timestamp, $post['updated'] ?? 0)),
        'keywords' => implode(', ', $post['tags']),
        'inLanguage' => 'en-KE',
    ], JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE) !!}</script>
    <script type="application/ld+json">{!! json_encode(['@context' => 'https://schema.org', '@type' => 'BreadcrumbList', 'itemListElement' => [
        ['@type' => 'ListItem', 'position' => 1, 'name' => config('app.name'), 'item' => url('/')],
        ['@type' => 'ListItem', 'position' => 2, 'name' => 'Blog', 'item' => route('blog.index')],
        ['@type' => 'ListItem', 'position' => 3, 'name' => $post['title'], 'item' => url()->current()],
    ]], JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE) !!}</script>
@endpush

@section('styles')
    .post-head{padding:56px 0 24px;max-width:780px}
    .post-head h1{font-size:clamp(30px,4.4vw,48px);margin:12px 0 14px}
    .post-head .lead{font-size:19px;margin:0 0 16px}
    .cover{border-radius:24px;aspect-ratio:21/9;object-fit:cover;width:100%;box-shadow:var(--shadow)}
    .article{max-width:740px;margin:40px auto 0;font-size:18px}
    .article h2{font-size:28px;margin:44px 0 12px}
    .article h3{font-size:21px;margin:30px 0 8px}
    .article p,.article li{color:#2e3b52}
    .article ul,.article ol{padding-left:22px}
    .article li{margin:6px 0}
    .article blockquote{margin:28px 0;padding:18px 22px;border-left:4px solid var(--green);background:var(--bg);border-radius:0 14px 14px 0}
    .article blockquote p{margin:0}
    .article table{width:100%;border-collapse:collapse;margin:24px 0;font-size:16px}
    .article th,.article td{border:1px solid var(--line);padding:10px 12px;text-align:left;vertical-align:top}
    .article th{background:var(--bg);color:var(--ink)}
    .article img{border-radius:16px;margin:24px 0}
    .article code{background:var(--bg);padding:2px 6px;border-radius:6px;font-size:.9em}
    .more{display:grid;grid-template-columns:repeat(3,1fr);gap:20px;margin-top:20px}
    @media (max-width:860px){.more{grid-template-columns:1fr}}
    .more a{border:1px solid var(--line);border-radius:16px;padding:18px 20px;text-decoration:none;color:inherit}
    .more a:hover{border-color:var(--blue)}
    .more b{display:block;color:var(--ink);margin-bottom:6px;line-height:1.35}
    .back{font-weight:700;text-decoration:none}
@endsection

@section('content')
    <div class="wrap">
        <header class="post-head">
            <a class="back" href="{{ route('blog.index') }}">← All posts</a>
            <div style="margin-top:18px">@foreach ($post['tags'] as $t)<a class="tag" href="{{ route('blog.index', ['tag' => $t]) }}">{{ $t }}</a>@endforeach</div>
            <h1>{{ $post['title'] }}</h1>
            <p class="lead">{{ $post['excerpt'] }}</p>
            <span class="meta">{{ $post['author'] }} · {{ $post['date']->format('j F Y') }} · {{ $post['minutes'] }} min read</span>
        </header>
        @if ($post['cover'])<img class="cover" src="{{ asset('assets/classcompass/'.$post['cover']) }}" alt="" width="1600" height="686">@endif

        <article class="article">
            {!! $post['html'] !!}
        </article>

        <div class="article" style="margin-top:0">
            <div class="cta">
                <div><h3>Try it in a real school</h3><p>Compass Academy is our live demo: log in as a head teacher, bursar, teacher or parent, no sign-up needed.</p></div>
                <div style="display:flex;gap:12px;flex-wrap:wrap"><a class="btn btn-ghost" href="{{ rtrim((string) config('app.demo_url'), '/') }}/sign-in">Open the live demo</a><a class="btn btn-primary" href="{{ url('/') }}#get-started">Start free trial</a></div>
            </div>
        </div>

        @if ($more->isNotEmpty())
            <section class="article" style="margin-top:56px">
                <h2 style="margin-top:0">Keep reading</h2>
                <div class="more">
                    @foreach ($more as $m)
                        <a href="{{ route('blog.show', $m['slug']) }}"><b>{{ $m['title'] }}</b><span class="meta">{{ $m['minutes'] }} min read</span></a>
                    @endforeach
                </div>
            </section>
        @endif
    </div>
@endsection
