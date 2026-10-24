@extends('blog.layout')

@section('title', $tag ? 'Posts about '.$tag : 'Blog: guides for Kenyan schools')
@if ($tag)
    @section('robots', 'noindex, follow')
@endif
@push('head')
    <script type="application/ld+json">{!! json_encode(['@context' => 'https://schema.org', '@type' => 'Blog', 'name' => config('app.name').' blog', 'url' => route('blog.index'), 'inLanguage' => 'en-KE',
        'blogPost' => $posts->take(10)->map(fn ($p) => ['@type' => 'BlogPosting', 'headline' => $p['title'], 'url' => route('blog.show', $p['slug']), 'datePublished' => $p['date']->toDateString()])->values()], JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE) !!}</script>
@endpush
@section('description', 'Practical guides for head teachers, bursars and school owners in Kenya: CBC assessment, school fees and M-Pesa, parent communication, admissions marketing and running a school with Class Compass.')

@section('styles')
    .hero{padding:64px 0 28px;background:radial-gradient(800px 400px at 90% -10%,rgba(0,192,144,.14),transparent 60%),radial-gradient(700px 400px at -10% 0,rgba(1,109,246,.10),transparent 60%)}
    .hero h1{font-size:clamp(32px,4.6vw,52px);margin:10px 0 12px}
    .hero p{max-width:680px;font-size:18px;margin:0}
    .featured{display:grid;grid-template-columns:1.2fr 1fr;gap:36px;align-items:center;margin:36px 0 12px;text-decoration:none;color:inherit}
    .featured img{border-radius:22px;aspect-ratio:16/10;object-fit:cover;width:100%;box-shadow:var(--shadow)}
    .featured h2{font-size:clamp(24px,3vw,34px);margin:8px 0 10px}
    @media (max-width:860px){.featured{grid-template-columns:1fr}}
    .grid{display:grid;grid-template-columns:repeat(3,1fr);gap:24px;margin-top:36px}
    @media (max-width:960px){.grid{grid-template-columns:1fr 1fr}}@media (max-width:600px){.grid{grid-template-columns:1fr}}
    .card{display:flex;flex-direction:column;border:1px solid var(--line);border-radius:var(--radius);overflow:hidden;text-decoration:none;color:inherit;background:#fff;transition:transform .2s,box-shadow .2s}
    .card:hover{transform:translateY(-4px);box-shadow:var(--shadow)}
    .card img{aspect-ratio:16/9;object-fit:cover;width:100%}
    .card .body{padding:20px 22px 24px;display:flex;flex-direction:column;gap:8px;flex:1}
    .card h3{font-size:19px;margin:0}
    .card p{margin:0;font-size:15px}
    .filter{display:flex;flex-wrap:wrap;align-items:center;gap:8px;margin-top:22px}
@endsection

@section('content')
    <section class="hero">
        <div class="wrap">
            <span class="eyebrow">Class Compass blog</span>
            <h1>{{ $tag ? 'Posts about '.$tag : 'Guides for running a modern Kenyan school' }}</h1>
            <p>CBC assessment, school fees and M-Pesa, parent communication, admissions and the everyday work of head teachers and bursars.</p>
            @if ($tags->isNotEmpty())
                <div class="filter">
                    <a class="tag" href="{{ route('blog.index') }}" @if(! $tag) style="background:var(--navy);color:#fff;border-color:var(--navy)" @endif>All posts</a>
                    @foreach ($tags as $t)
                        <a class="tag" href="{{ route('blog.index', ['tag' => $t]) }}" @if($tag === $t) style="background:var(--navy);color:#fff;border-color:var(--navy)" @endif>{{ $t }}</a>
                    @endforeach
                </div>
            @endif
        </div>
    </section>

    <div class="wrap">
        @if ($posts->isEmpty())
            <p style="margin:48px 0">No posts yet. Check back soon.</p>
        @else
            @php $first = $posts->first(); @endphp
            <a class="featured" href="{{ route('blog.show', $first['slug']) }}">
                @if ($first['cover'])<img src="{{ asset('assets/classcompass/'.$first['cover']) }}" alt="" width="1200" height="750">@endif
                <div>
                    <div>@foreach ($first['tags'] as $t)<span class="tag">{{ $t }}</span>@endforeach</div>
                    <h2>{{ $first['title'] }}</h2>
                    <p style="font-size:17px;margin:0 0 12px">{{ $first['excerpt'] }}</p>
                    <span class="meta">{{ $first['date']->format('j F Y') }} · {{ $first['minutes'] }} min read</span>
                </div>
            </a>

            <div class="grid">
                @foreach ($posts->slice(1) as $post)
                    <a class="card" href="{{ route('blog.show', $post['slug']) }}">
                        @if ($post['cover'])<img src="{{ asset('assets/classcompass/'.$post['cover']) }}" alt="" loading="lazy" width="800" height="450">@endif
                        <div class="body">
                            <div>@foreach (array_slice($post['tags'], 0, 2) as $t)<span class="tag">{{ $t }}</span>@endforeach</div>
                            <h3>{{ $post['title'] }}</h3>
                            <p>{{ $post['excerpt'] }}</p>
                            <span class="meta" style="margin-top:auto">{{ $post['date']->format('j M Y') }} · {{ $post['minutes'] }} min read</span>
                        </div>
                    </a>
                @endforeach
            </div>
        @endif

        <div class="cta">
            <div><h3>See it in a real school</h3><p>Log in to Compass Academy, our live demo school, as a head teacher, bursar, teacher or parent.</p></div>
            <div style="display:flex;gap:12px;flex-wrap:wrap"><a class="btn btn-ghost" href="{{ rtrim((string) config('app.demo_url'), '/') }}/sign-in">Try the live demo</a><a class="btn btn-primary" href="{{ url('/') }}#get-started">Start free trial</a></div>
        </div>
    </div>
@endsection
