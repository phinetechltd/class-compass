@php
    $app = config('app.name', 'Class Compass');
    $frontend = rtrim((string) config('app.frontend_url'), '/');
    $contact = config('app.contact', []);
    $asset = fn ($p) => asset('assets/classcompass/'.$p);
    $screen = fn ($p) => asset('assets/classcompass/screens/'.$p);
    $demo = rtrim((string) config('app.demo_url'), '/');
    // Prices in KES per term (3 terms a year). Keep in sync with the `plans` table.
    $plans = [
        ['key' => 'msingi', 'name' => 'Msingi', 'tag' => 'Small schools getting started', 'price' => 2500, 'learners' => 'Up to 200 learners', 'max' => 200,
            'features' => ['Learners, staff & classes', 'Attendance (daily & subject)', 'CBC assessments & report cards', 'Fee billing + M-Pesa STK collection', 'Parent & learner portal', 'Up to 5 staff accounts', 'Email & WhatsApp support']],
        ['key' => 'shule', 'name' => 'Shule', 'tag' => 'Most popular for primary & junior schools', 'price' => 5000, 'learners' => '201 – 700 learners', 'max' => 700, 'popular' => true,
            'features' => ['Everything in Msingi', 'SMS notifications to parents', 'Timetables & exam scheduling', 'Library & question bank', 'Payroll & staff attendance', 'Up to 20 staff accounts', 'Priority WhatsApp support']],
        ['key' => 'shule-pro', 'name' => 'Shule Pro', 'tag' => 'Boarding & large day schools', 'price' => 9500, 'learners' => '701 – 1,500 learners', 'max' => 1500,
            'features' => ['Everything in Shule', 'Boarding / hostel & meals', 'Transport routes & buses', 'E-learning, quizzes & Zoom classes', 'Full accounting & reports', 'Up to 3 campuses, unlimited staff', 'Onboarding training for your team']],
        ['key' => 'enterprise', 'name' => 'Group & College', 'tag' => 'School groups, colleges & TVETs', 'price' => null, 'learners' => '1,500+ learners or many campuses', 'max' => PHP_INT_MAX,
            'features' => ['Everything in Shule Pro', 'Unlimited campuses & branches', 'College / TVET structure (units, years)', 'Data migration from your old system', 'Custom domain & branded parent app', 'Dedicated account manager', 'Service-level agreement']],
    ];
    $modules = [
        ['users', 'Learners & admissions', 'Profiles, admission numbers, streams, promotions and transfer letters.'],
        ['calendar-check', 'Attendance', 'Daily and lesson attendance with automatic SMS to parents when a learner is absent.'],
        ['clipboard-list', 'CBC assessments', 'Strands, rubrics (EE / ME / AE / BE) and termly report cards ready to print or share.'],
        ['wallet', 'Fees & M-Pesa', 'Fee structures per class and term, STK push collection, receipts and balances.'],
        ['message-square', 'SMS & notices', 'Bulk SMS, notices and events for parents, staff and learners.'],
        ['calculator', 'Accounting', 'Ledgers, vouchers, income & expenditure and trial balance from the same data.'],
        ['book-open', 'Library', 'Catalogue, barcodes, issues, returns and fines.'],
        ['bed-double', 'Boarding', 'Dormitories, members, meals and boarding bills.'],
        ['bus', 'Transport', 'Routes, stops, buses, drivers and learner assignments.'],
        ['video', 'E-learning', 'Courses, assignments, quizzes and live Zoom classes.'],
        ['layers', 'Timetables & exams', 'Class routines, exam schedules, mark entry and merit lists.'],
        ['building-2', 'Multi-campus', 'Run many branches or schools from one account with separate data.'],
    ];
    $faqs = [
        ['Does Class Compass support CBC?', 'Yes. Choose CBC when you sign up and we create PP1 to Grade 12 with the learning areas for each level and the KNEC rubric (EE1 – BE2). You can also run 8-4-4 (Form 3–4), British (Cambridge / Edexcel) or a College / TVET structure — or mix them across campuses.'],
        ['How do parents pay fees with M-Pesa?', 'The school adds its own Paybill or Till through Safaricom Daraja. A parent opens the parent portal, enters the amount and their phone number, and approves the STK prompt with their M-Pesa PIN. The money goes straight to the school\'s account and the receipt is posted to the learner\'s fee statement automatically. Card and mobile money via Paystack is also available.'],
        ['Is there a free trial?', 'Yes — 30 days free with no card needed. Your data stays when you upgrade, and you pay per term.'],
        ['Can we move data from our current system or Excel?', 'Yes. Learners, staff and fee balances can be imported from Excel. On the Group & College plan we do the migration for you.'],
        ['Is our data safe?', 'Each school\'s data is kept separate, passwords are encrypted, access is controlled by roles, and actions are logged. We designed Class Compass with Kenya\'s Data Protection Act, 2019 in mind, and we never sell school or learner data.'],
        ['Does it work on phones?', 'Yes. Class Compass works in any browser on phones, tablets and computers, and there are Android and desktop apps for staff and parents.'],
    ];
@endphp
<!DOCTYPE html>
<html lang="en-KE">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{{ $app }} — School Management System for Kenyan Schools | CBC, M-Pesa Fees</title>
    <meta name="description" content="{{ $app }} is a school management system built for Kenya: CBC assessments and report cards, fee collection by M-Pesa STK push, attendance, SMS to parents, boarding, transport and accounting. Free 30-day trial, from KSh 2,500 per term.">
    <meta name="keywords" content="school management system Kenya, CBC software, school ERP Kenya, M-Pesa school fees, CBC report cards, school fees management, Kenya school system">
    <link rel="canonical" href="{{ url('/') }}">
    <meta name="theme-color" content="#043268">
    <meta property="og:type" content="website">
    <meta property="og:site_name" content="{{ $app }}">
    <meta property="og:title" content="{{ $app }} — CBC-ready school management for Kenya">
    <meta property="og:description" content="Fees by M-Pesa, CBC report cards, attendance and parent SMS in one place. Free 30-day trial.">
    <meta property="og:image" content="{{ $asset('og-image.jpg') }}">
    <meta property="og:url" content="{{ url('/') }}">
    <meta property="og:locale" content="en_KE">
    <meta name="twitter:card" content="summary_large_image">
    <link rel="icon" type="image/png" href="{{ asset('favicon.png') }}">
    <link rel="apple-touch-icon" href="{{ $asset('apple-touch-icon.png') }}">
    <script type="application/ld+json">
    {!! json_encode([
        '@context' => 'https://schema.org',
        '@type' => 'SoftwareApplication',
        'name' => $app,
        'applicationCategory' => 'EducationalApplication',
        'operatingSystem' => 'Web, Android, Windows',
        'areaServed' => 'KE',
        'description' => 'School management system for Kenyan schools with CBC assessments and M-Pesa fee collection.',
        'offers' => collect($plans)->whereNotNull('price')->map(fn ($p) => ['@type' => 'Offer', 'name' => $p['name'], 'price' => $p['price'], 'priceCurrency' => 'KES', 'description' => 'Per term. '.$p['learners']])->values(),
    ], JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE) !!}
    </script>
    <style>
        :root{--navy:#043268;--navy-2:#0a2550;--blue:#016DF6;--green:#00C090;--mpesa:#00A651;--ink:#0f1f3a;--text:#41506a;--muted:#6b7a92;--line:#e4eaf3;--bg:#f6f9fd;--card:#fff;--radius:18px;--shadow:0 18px 50px rgba(4,50,104,.10)}
        *{box-sizing:border-box}html{scroll-behavior:smooth}
        body{margin:0;font-family:"Segoe UI",system-ui,-apple-system,Roboto,"Helvetica Neue",Arial,sans-serif;color:var(--text);background:#fff;line-height:1.6;-webkit-font-smoothing:antialiased}
        a{color:inherit}img{max-width:100%;display:block}
        .wrap{width:min(1180px,100% - 32px);margin-inline:auto}
        .ic{width:22px;height:22px;flex:none}
        h1,h2,h3{color:var(--ink);line-height:1.15;margin:0;letter-spacing:-.02em}
        h2{font-size:clamp(28px,3.6vw,42px);font-weight:800}
        .eyebrow{display:inline-flex;align-items:center;gap:8px;font-size:13px;font-weight:700;letter-spacing:.08em;text-transform:uppercase;color:var(--blue)}
        .lead{font-size:clamp(16px,1.6vw,19px);color:var(--text);max-width:640px}
        .btn{display:inline-flex;align-items:center;gap:10px;padding:14px 22px;border-radius:12px;font-weight:700;text-decoration:none;border:0;cursor:pointer;font-size:16px;transition:transform .15s ease,box-shadow .2s ease,background .2s}
        .btn:hover{transform:translateY(-1px)}
        .btn-primary{background:linear-gradient(135deg,var(--blue),#0057d9);color:#fff;box-shadow:0 10px 24px rgba(1,109,246,.28)}
        .btn-green{background:var(--green);color:#03261c}
        .btn-ghost{background:#fff;color:var(--navy);border:1.5px solid var(--line)}
        .btn-white{background:#fff;color:var(--navy)}
        section{padding:clamp(64px,8vw,110px) 0}
        .center{text-align:center}.center .lead{margin-inline:auto}
        /* nav */
        .nav{position:sticky;top:0;z-index:50;background:rgba(255,255,255,.86);backdrop-filter:saturate(1.4) blur(12px);border-bottom:1px solid transparent;transition:border-color .2s}
        .nav.scrolled{border-color:var(--line)}
        .nav .wrap{display:flex;align-items:center;justify-content:space-between;height:72px;gap:16px}
        .nav img{height:46px;width:auto}
        .nav-links{display:flex;gap:28px;font-weight:600;font-size:15px}
        .nav-links a{text-decoration:none;color:var(--text)}.nav-links a:hover{color:var(--blue)}
        .nav-cta{display:flex;gap:10px;align-items:center}
        .nav-cta .login{font-weight:700;text-decoration:none;color:var(--navy);padding:10px 14px}
        .menu-btn{display:none;background:none;border:0;color:var(--navy);padding:8px;cursor:pointer}
        .nav-cta .btn{white-space:nowrap}
        @media (max-width:560px){.nav img{height:36px}.nav-cta .btn{padding:10px 14px;font-size:14px}}
        @media (max-width:960px){.nav-links,.nav-cta .login{display:none}.menu-btn{display:block}
            .nav.open .nav-links{display:flex;position:absolute;top:72px;left:0;right:0;flex-direction:column;background:#fff;padding:18px 24px;border-bottom:1px solid var(--line);gap:16px}}
        /* hero */
        .hero{position:relative;overflow:hidden;padding:clamp(48px,6vw,84px) 0 clamp(64px,8vw,100px);background:radial-gradient(900px 500px at 85% -10%,rgba(0,192,144,.16),transparent 60%),radial-gradient(800px 500px at -10% 10%,rgba(1,109,246,.12),transparent 60%),#fff}
        .hero .wrap{display:grid;grid-template-columns:1.05fr 1fr;gap:56px;align-items:center}
        .hero h1{font-size:clamp(36px,5.2vw,62px);font-weight:800;margin:16px 0 18px}
        .hero h1 .hl{background:linear-gradient(90deg,var(--blue),var(--green));-webkit-background-clip:text;background-clip:text;color:transparent}
        .hero-ctas{display:flex;flex-wrap:wrap;gap:12px;margin:28px 0 18px}
        .reassure{display:flex;flex-wrap:wrap;gap:18px;font-size:14px;color:var(--muted)}
        .reassure span{display:inline-flex;align-items:center;gap:6px}.reassure .ic{width:16px;height:16px;color:var(--green)}
        .pill-row{display:flex;flex-wrap:wrap;gap:10px;margin-top:28px}
        .pill{display:inline-flex;align-items:center;gap:8px;padding:8px 14px;border-radius:999px;background:var(--bg);border:1px solid var(--line);font-size:14px;font-weight:600;color:var(--navy)}
        @media (max-width:960px){.hero .wrap{grid-template-columns:1fr}}
        /* real screenshots */
        .shots{position:relative;padding:0 6% 50px 0}
        .browser{border-radius:16px;overflow:hidden;background:#fff;box-shadow:0 40px 80px rgba(4,50,104,.25);border:1px solid var(--line)}
        .browser .bar{display:flex;align-items:center;gap:7px;padding:10px 14px;background:#eef3fa;border-bottom:1px solid var(--line)}
        .browser .bar i{width:10px;height:10px;border-radius:50%;background:#ff5f57}.browser .bar i:nth-child(2){background:#febc2e}.browser .bar i:nth-child(3){background:#28c840}
        .browser .bar span{margin-left:10px;font-size:12px;color:var(--muted);background:#fff;border-radius:6px;padding:3px 10px}
        .browser img{display:block;width:100%;height:auto}
        .phone{position:absolute;right:0;bottom:0;width:23%;min-width:120px;border-radius:30px;padding:8px;background:#0b1a33;box-shadow:0 30px 60px rgba(4,50,104,.35);animation:float 7s ease-in-out infinite}
        .phone img{display:block;width:100%;border-radius:23px}
        .shot-note{display:flex;align-items:center;gap:8px;margin-top:14px;font-size:13px;color:var(--muted)}
        @media (max-width:560px){.phone{right:0;width:38%}}
        .tour-tabs{display:flex;flex-wrap:wrap;gap:8px;justify-content:center;margin:36px 0 24px}
        .tour-tabs button{border:1px solid var(--line);background:#fff;color:var(--navy);font:inherit;font-weight:700;font-size:14px;padding:10px 16px;border-radius:999px;cursor:pointer}
        .tour-tabs button[aria-selected=true]{background:var(--navy);color:#fff;border-color:var(--navy)}
        .tour-panel{display:none}.tour-panel.on{display:grid;grid-template-columns:1.6fr 1fr;gap:36px;align-items:center}
        .tour-panel.mobile.on{grid-template-columns:1fr 1.1fr}
        @media (max-width:960px){.tour-panel.on,.tour-panel.mobile.on{grid-template-columns:1fr}}
        .tour-panel .phones{display:flex;gap:16px;justify-content:center}
        .tour-panel .phones img{width:100%;max-width:250px;border-radius:26px;border:8px solid #0b1a33;box-shadow:0 30px 60px rgba(4,50,104,.22)}
        .tour-panel .phones picture{width:46%;max-width:250px}
        .tour-panel h3{font-size:24px;margin-bottom:10px}
        .demo-box{display:grid;grid-template-columns:repeat(4,1fr);gap:14px;margin-top:40px}
        @media (max-width:960px){.demo-box{grid-template-columns:1fr 1fr}}@media (max-width:520px){.demo-box{grid-template-columns:1fr}}
        .demo-role{background:#fff;border:1px solid var(--line);border-radius:var(--radius);padding:20px}
        .demo-role b{display:block;color:var(--navy);font-size:17px;margin-bottom:4px}.demo-role p{margin:0 0 10px;font-size:14px}
        .demo-role code{font-size:12.5px;background:var(--bg);padding:3px 7px;border-radius:6px;color:var(--navy);word-break:break-all}
        /* dashboard mock */
        .mock{position:relative;background:linear-gradient(160deg,#0b2a5c,#06204a);border-radius:24px;padding:18px;box-shadow:0 40px 80px rgba(4,50,104,.28);color:#d9e6fb;animation:float 7s ease-in-out infinite}
        .mock-top{display:flex;align-items:center;gap:8px;margin-bottom:14px}.mock-top i{width:10px;height:10px;border-radius:50%;background:#ff5f57}.mock-top i:nth-child(2){background:#febc2e}.mock-top i:nth-child(3){background:#28c840}
        .mock-top span{margin-left:10px;font-size:12px;color:#8fa6cb}
        .mock-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:12px}
        .kpi{background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.08);border-radius:14px;padding:14px}
        .kpi small{display:block;font-size:12px;color:#8fa6cb}.kpi b{display:block;font-size:22px;color:#fff;margin-top:4px}.kpi em{font-style:normal;font-size:12px;color:var(--green)}
        .mock-row{display:grid;grid-template-columns:1.3fr 1fr;gap:12px;margin-top:12px}
        .panel{background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.08);border-radius:14px;padding:14px}
        .panel h4{margin:0 0 10px;font-size:13px;color:#fff;font-weight:700}
        .bars{display:flex;align-items:flex-end;gap:8px;height:110px}.bars i{flex:1;border-radius:6px 6px 2px 2px;background:linear-gradient(180deg,var(--green),var(--blue));opacity:.9;transform-origin:bottom;animation:grow 1.2s ease both}
        .feed div{display:flex;justify-content:space-between;align-items:center;font-size:12px;padding:8px 0;border-bottom:1px dashed rgba(255,255,255,.1)}.feed div:last-child{border:0}
        .feed b{color:#fff;font-weight:600}.feed .ok{color:#2ee6a6;font-weight:700}
        .toast{position:absolute;left:-26px;bottom:34px;background:#fff;color:var(--ink);border-radius:14px;padding:12px 14px;box-shadow:var(--shadow);display:flex;gap:10px;align-items:center;font-size:13px;animation:pop 6s ease-in-out infinite}
        .toast .dot{width:34px;height:34px;border-radius:10px;background:var(--mpesa);display:grid;place-items:center;color:#fff;font-weight:800;font-size:12px}
        .toast small{display:block;color:var(--muted)}
        .grade{position:absolute;right:-18px;top:-22px;background:#fff;border-radius:14px;padding:10px 14px;box-shadow:var(--shadow);font-size:13px;color:var(--ink)}
        .grade b{color:var(--green);font-size:18px;margin-right:6px}
        @media (max-width:560px){.mock-grid{grid-template-columns:1fr 1fr}.mock-grid .kpi:last-child{display:none}.mock-row{grid-template-columns:1fr}.toast{left:8px}.grade{right:8px}}
        @keyframes float{0%,100%{transform:translateY(0)}50%{transform:translateY(-10px)}}
        @keyframes grow{from{transform:scaleY(.1)}}
        @keyframes pop{0%,12%{opacity:0;transform:translateY(10px)}18%,82%{opacity:1;transform:none}90%,100%{opacity:0;transform:translateY(-6px)}}
        /* strip */
        .strip{padding:28px 0;border-block:1px solid var(--line);background:var(--bg)}
        .strip .wrap{display:flex;flex-wrap:wrap;justify-content:center;gap:14px 34px;align-items:center;font-weight:700;color:var(--navy)}
        .strip span{display:inline-flex;align-items:center;gap:8px}.strip .ic{color:var(--green)}
        /* features */
        .grid{display:grid;grid-template-columns:repeat(4,1fr);gap:18px;margin-top:44px}
        @media (max-width:1024px){.grid{grid-template-columns:repeat(2,1fr)}}@media (max-width:560px){.grid{grid-template-columns:1fr}}
        .card{background:var(--card);border:1px solid var(--line);border-radius:var(--radius);padding:24px;transition:transform .2s,box-shadow .2s,border-color .2s}
        .card:hover{transform:translateY(-4px);box-shadow:var(--shadow);border-color:transparent}
        .card .ico{width:46px;height:46px;border-radius:12px;display:grid;place-items:center;background:linear-gradient(135deg,rgba(1,109,246,.12),rgba(0,192,144,.16));color:var(--blue);margin-bottom:16px}
        .card h3{font-size:18px;margin-bottom:6px}.card p{margin:0;font-size:15px}
        /* split */
        .split{display:grid;grid-template-columns:1fr 1fr;gap:56px;align-items:center}
        .split.rev .media{order:-1}
        @media (max-width:960px){.split{grid-template-columns:1fr}.split.rev .media{order:0}}
        .media img{border-radius:22px;box-shadow:var(--shadow);width:100%;max-width:560px;margin-inline:auto}
        .media img.plain{border-radius:0;box-shadow:none;max-width:520px}
        .ticks{list-style:none;padding:0;margin:24px 0 0;display:grid;gap:12px}
        .ticks li{display:flex;gap:12px;align-items:flex-start}.ticks .ic{color:var(--green);margin-top:2px}
        .curricula{display:grid;grid-template-columns:repeat(4,1fr);gap:14px;margin-top:40px}
        @media (max-width:960px){.curricula{grid-template-columns:1fr 1fr}}@media (max-width:520px){.curricula{grid-template-columns:1fr}}
        .cur{border-radius:var(--radius);padding:22px;background:#fff;border:1px solid var(--line)}
        .cur.main{background:linear-gradient(160deg,var(--navy),#0b4aa8);color:#d6e4fb;border:0}.cur.main h3{color:#fff}
        .cur h3{font-size:19px;margin:6px 0 8px}.cur p{margin:0;font-size:14px}
        .cur .chips{display:flex;flex-wrap:wrap;gap:6px;margin-top:14px}.cur .chips i{font-style:normal;font-size:12px;font-weight:700;padding:4px 9px;border-radius:999px;background:rgba(0,192,144,.14);color:#007a5c}
        .cur.main .chips i{background:rgba(255,255,255,.14);color:#fff}
        .steps{display:grid;grid-template-columns:repeat(3,1fr);gap:16px;margin-top:28px}
        @media (max-width:640px){.steps{grid-template-columns:1fr}}
        .step{background:#fff;border:1px solid var(--line);border-radius:16px;padding:18px}
        .step b{display:inline-grid;place-items:center;width:30px;height:30px;border-radius:50%;background:var(--mpesa);color:#fff;font-size:14px;margin-bottom:8px}
        .dark{background:linear-gradient(165deg,var(--navy-2),var(--navy));color:#c9d8f2}.dark h2,.dark h3{color:#fff}.dark .eyebrow{color:#5be2bd}.dark .lead{color:#c9d8f2}
        /* pricing */
        .toggle{display:inline-flex;background:var(--bg);border:1px solid var(--line);border-radius:999px;padding:5px;margin-top:26px}
        .toggle button{border:0;background:none;padding:10px 18px;border-radius:999px;font-weight:700;color:var(--text);cursor:pointer;font-size:15px}
        .toggle button.on{background:#fff;color:var(--navy);box-shadow:0 4px 12px rgba(4,50,104,.12)}
        .toggle small{color:var(--mpesa);font-weight:800;margin-left:4px}
        .finder{margin:26px auto 0;max-width:560px;background:var(--bg);border:1px solid var(--line);border-radius:16px;padding:16px 20px;text-align:left}
        .finder label{font-weight:700;color:var(--navy);display:flex;justify-content:space-between}
        .finder input{width:100%;accent-color:var(--blue);margin-top:10px}
        .plans{display:grid;grid-template-columns:repeat(4,1fr);gap:18px;margin-top:36px;align-items:stretch}
        @media (max-width:1100px){.plans{grid-template-columns:repeat(2,1fr)}}@media (max-width:620px){.plans{grid-template-columns:1fr}}
        .plan{position:relative;display:flex;flex-direction:column;background:#fff;border:1.5px solid var(--line);border-radius:22px;padding:26px;text-align:left;transition:border-color .25s,box-shadow .25s,transform .25s}
        .plan.rec{border-color:var(--blue);box-shadow:0 22px 50px rgba(1,109,246,.18);transform:translateY(-6px)}
        .plan .badge{position:absolute;top:-13px;left:24px;background:linear-gradient(90deg,var(--blue),var(--green));color:#fff;font-size:12px;font-weight:800;padding:5px 12px;border-radius:999px;opacity:0;transition:opacity .2s}
        .plan.rec .badge{opacity:1}
        .plan h3{font-size:22px}.plan .tag{font-size:14px;color:var(--muted);min-height:44px;margin:4px 0 14px}
        .price{font-size:38px;font-weight:800;color:var(--ink);letter-spacing:-.02em}.price small{font-size:15px;font-weight:600;color:var(--muted)}
        .plan .learners{font-weight:700;color:var(--navy);margin:6px 0 18px;font-size:14px}
        .plan ul{list-style:none;padding:0;margin:0 0 24px;display:grid;gap:10px;font-size:14.5px;flex:1}
        .plan li{display:flex;gap:10px}.plan li .ic{width:18px;height:18px;color:var(--green);margin-top:3px}
        .plan .btn{justify-content:center}
        .note{margin-top:22px;font-size:14px;color:var(--muted)}
        /* faq */
        .faq{max-width:820px;margin:40px auto 0;display:grid;gap:12px}
        details{background:#fff;border:1px solid var(--line);border-radius:14px;padding:18px 22px}
        summary{cursor:pointer;font-weight:700;color:var(--ink);list-style:none;display:flex;justify-content:space-between;gap:12px}
        summary::-webkit-details-marker{display:none}summary::after{content:"+";font-size:22px;line-height:1;color:var(--blue)}
        details[open] summary::after{content:"–"}details p{margin:12px 0 0}
        /* signup */
        .signup{display:grid;grid-template-columns:1fr 1.1fr;gap:48px;align-items:start}
        @media (max-width:960px){.signup{grid-template-columns:1fr}}
        form.box{background:#fff;color:var(--text);border-radius:22px;padding:28px;box-shadow:0 30px 70px rgba(0,0,0,.25)}
        .row{display:grid;grid-template-columns:1fr 1fr;gap:14px}@media (max-width:560px){.row{grid-template-columns:1fr}}
        .field{display:flex;flex-direction:column;gap:6px;margin-bottom:14px}
        .field label{font-size:13px;font-weight:700;color:var(--navy)}
        .field input,.field select{font:inherit;padding:12px 14px;border:1.5px solid var(--line);border-radius:10px;background:#fff;color:var(--ink);outline:none;transition:border-color .2s,box-shadow .2s}
        .field input:focus,.field select:focus{border-color:var(--blue);box-shadow:0 0 0 4px rgba(1,109,246,.12)}
        .legend{font-size:12px;font-weight:800;letter-spacing:.08em;text-transform:uppercase;color:var(--muted);margin:6px 0 10px}
        .msg{display:none;padding:12px 14px;border-radius:10px;margin-bottom:14px;font-size:14px}
        .msg.err{display:block;background:#fff1f0;color:#b42318;border:1px solid #fecdca}
        .msg.ok{display:block;background:#ecfdf3;color:#067647;border:1px solid #abefc6}
        form.box .btn{width:100%;justify-content:center}
        .fine{font-size:12.5px;color:var(--muted);margin-top:12px;text-align:center}
        /* footer */
        footer{background:#061a3a;color:#9fb3cf;padding:56px 0 28px;font-size:14.5px}
        .foot{display:grid;grid-template-columns:1.4fr 1fr 1fr 1fr;gap:30px}@media (max-width:860px){.foot{grid-template-columns:1fr 1fr}}
        footer h4{color:#fff;margin:0 0 12px;font-size:15px}footer a{text-decoration:none;color:#9fb3cf;display:block;padding:3px 0}footer a:hover{color:#fff}
        footer img{height:42px;width:auto;margin-bottom:14px}
        .copy{border-top:1px solid rgba(255,255,255,.08);margin-top:36px;padding-top:20px;display:flex;justify-content:space-between;flex-wrap:wrap;gap:10px;font-size:13px}
        .wa{position:fixed;right:18px;bottom:18px;z-index:60;width:56px;height:56px;border-radius:50%;background:#25D366;display:grid;place-items:center;color:#fff;box-shadow:0 12px 30px rgba(0,0,0,.25)}
        /* reveal */
        .reveal{opacity:0;transform:translateY(18px);transition:opacity .7s ease,transform .7s ease}.reveal.in{opacity:1;transform:none}
        @media (prefers-reduced-motion:reduce){*{animation:none!important;transition:none!important}.reveal{opacity:1;transform:none}}
    </style>
</head>
<body>
{!! file_get_contents(public_path('assets/classcompass/icons.svg')) !!}

<header class="nav" id="nav">
    <div class="wrap">
        <a href="{{ url('/') }}" aria-label="{{ $app }} home"><img src="{{ $asset('logo.png') }}" alt="{{ $app }}" width="160" height="43"></a>
        <nav class="nav-links" aria-label="Main">
            <a href="#demo">Live demo</a>
            <a href="#features">Features</a>
            <a href="#curriculum">CBC & curricula</a>
            <a href="#mpesa">M-Pesa fees</a>
            <a href="#pricing">Pricing</a>
            <a href="#faq">FAQ</a>
        </nav>
        <div class="nav-cta">
            <a class="login" href="{{ $frontend }}/sign-in">Log in</a>
            <a class="btn btn-primary" href="#get-started">Start free trial</a>
            <button class="menu-btn" id="menuBtn" aria-label="Open menu" aria-expanded="false"><svg class="ic"><use href="#i-menu"/></svg></button>
        </div>
    </div>
</header>

<main>
    <section class="hero">
        <div class="wrap">
            <div class="reveal">
                <span class="eyebrow"><svg class="ic" style="width:16px;height:16px"><use href="#i-sparkles"/></svg>Built for Kenyan schools</span>
                <h1>Run your whole school <span class="hl">from one place</span></h1>
                <p class="lead">CBC assessments and report cards, fees collected straight to your Paybill with M-Pesa, attendance alerts and parent SMS — set up in minutes, not weeks.</p>
                <div class="hero-ctas">
                    <a class="btn btn-primary" href="#get-started">Start 30-day free trial <svg class="ic"><use href="#i-arrow-right"/></svg></a>
                    <a class="btn btn-ghost" href="#demo">Try the live demo</a>
                </div>
                <div class="reassure">
                    <span><svg class="ic"><use href="#i-check"/></svg>No card needed</span>
                    <span><svg class="ic"><use href="#i-check"/></svg>Free setup</span>
                    <span><svg class="ic"><use href="#i-check"/></svg>Pay per term</span>
                </div>
                <div class="pill-row">
                    <span class="pill">CBC · KNEC rubric</span><span class="pill">8-4-4</span><span class="pill">British / IGCSE</span><span class="pill">College / TVET</span>
                </div>
            </div>
            <div class="reveal">
                <div class="shots">
                    <div class="browser"><div class="bar"><i></i><i></i><i></i><span>demo.classcompass.co.ke · Dashboard</span></div>
                        <picture><source srcset="{{ $screen('admin-dashboard.webp') }}" type="image/webp"><img src="{{ $screen('admin-dashboard.jpg') }}" alt="Class Compass school dashboard with learners, teachers, attendance and fees collected" width="1440" height="900"></picture></div>
                    <div class="phone"><picture><source srcset="{{ $screen('parent-mpesa-paid.webp') }}" type="image/webp"><img src="{{ $screen('parent-mpesa-paid.jpg') }}" alt="Parent paying school fees with M-Pesa in the parent portal" width="390" height="844" loading="lazy"></picture></div>
                </div>
                <div class="shot-note"><svg class="ic" style="width:16px;height:16px"><use href="#i-badge-check"/></svg>Real screens from the live demo school.</div>
            </div>
        </div>
    </section>

    <div class="strip" aria-label="Highlights">
        <div class="wrap">
            <span><svg class="ic"><use href="#i-badge-check"/></svg>CBC, 8-4-4, British & TVET</span>
            <span><svg class="ic"><use href="#i-smartphone"/></svg>M-Pesa STK push & Paystack</span>
            <span><svg class="ic"><use href="#i-message-square"/></svg>SMS to parents</span>
            <span><svg class="ic"><use href="#i-building-2"/></svg>Multi-campus</span>
            <span><svg class="ic"><use href="#i-shield-check"/></svg>Role-based access</span>
        </div>
    </div>

    <section id="demo">
        <div class="wrap">
            <div class="reveal" style="text-align:center;max-width:760px;margin:0 auto">
                <span class="eyebrow">See the real system</span>
                <h2 style="margin-top:10px">Try Class Compass before you sign up</h2>
                <p class="lead" style="margin-top:14px">Compass Academy is a live demo school with 198 learners, 12 teachers, six weeks of attendance and real fee records. Log in as any role, click around and even pay fees by M-Pesa — in the demo, no money moves.</p>
            </div>
            <div class="tour-tabs" role="tablist" aria-label="Screens">
                <button type="button" role="tab" aria-selected="true" data-tab="t-dash">Dashboard</button>
                <button type="button" role="tab" aria-selected="false" data-tab="t-learners">Learners</button>
                <button type="button" role="tab" aria-selected="false" data-tab="t-fees">Fee collection</button>
                <button type="button" role="tab" aria-selected="false" data-tab="t-attendance">Attendance</button>
                <button type="button" role="tab" aria-selected="false" data-tab="t-mpesa">M-Pesa payments</button>
                <button type="button" role="tab" aria-selected="false" data-tab="t-parent">Parent app</button>
            </div>
            @php
                $tour = [
                    ['t-dash', 'admin-dashboard', 'School dashboard', 'Learners, teachers, today\'s attendance and fees collected this month — at a glance for the head teacher and the bursar.'],
                    ['t-learners', 'admin-learners', 'Learner records', 'Every learner\'s admission number, class, parents and contacts. Admit a learner in under a minute and promote whole classes at the end of the year.'],
                    ['t-fees', 'admin-fees', 'Fee collection', 'Termly fee structures per class, balances per learner and every receipt — from M-Pesa, Paystack or the bursar\'s desk.'],
                    ['t-attendance', 'admin-attendance', 'Attendance', 'Mark the daily register in seconds on a phone or computer; parents see it in their portal.'],
                ];
            @endphp
            @foreach ($tour as $i => [$id, $img, $title, $text])
                <div class="tour-panel {{ $i === 0 ? 'on' : '' }}" id="{{ $id }}" role="tabpanel">
                    <div class="browser"><div class="bar"><i></i><i></i><i></i><span>demo.classcompass.co.ke</span></div>
                        <picture><source srcset="{{ $screen($img.'.webp') }}" type="image/webp"><img src="{{ $screen($img.'.jpg') }}" alt="{{ $title }} in Class Compass" loading="lazy" width="1440" height="900"></picture></div>
                    <div><h3>{{ $title }}</h3><p>{{ $text }}</p><a class="btn btn-primary" href="{{ $demo }}/sign-in" style="margin-top:12px">Open the live demo <svg class="ic"><use href="#i-arrow-right"/></svg></a></div>
                </div>
            @endforeach
            <div class="tour-panel mobile" id="t-mpesa" role="tabpanel">
                <div class="phones">
                    <picture><source srcset="{{ $screen('parent-mpesa-pay.webp') }}" type="image/webp"><img src="{{ $screen('parent-mpesa-pay.jpg') }}" alt="Pay school fees screen with M-Pesa" loading="lazy" width="390" height="844"></picture>
                    <picture><source srcset="{{ $screen('parent-mpesa-paid.webp') }}" type="image/webp"><img src="{{ $screen('parent-mpesa-paid.jpg') }}" alt="M-Pesa payment confirmed with receipt" loading="lazy" width="390" height="844"></picture>
                </div>
                <div><h3>M-Pesa STK push</h3><p>The parent enters the amount and their Safaricom number, approves the prompt with their PIN, and the receipt posts to the learner's fee statement and the school's accounts at once.</p><a class="btn btn-primary" href="{{ $demo }}/sign-in" style="margin-top:12px">Try paying as a parent <svg class="ic"><use href="#i-arrow-right"/></svg></a></div>
            </div>
            <div class="tour-panel mobile" id="t-parent" role="tabpanel">
                <div class="phones">
                    <picture><source srcset="{{ $screen('parent-dashboard.webp') }}" type="image/webp"><img src="{{ $screen('parent-dashboard.jpg') }}" alt="Parent portal dashboard with attendance" loading="lazy" width="390" height="844"></picture>
                    <picture><source srcset="{{ $screen('parent-fees.webp') }}" type="image/webp"><img src="{{ $screen('parent-fees.jpg') }}" alt="Parent portal fee statement" loading="lazy" width="390" height="844"></picture>
                </div>
                <div><h3>Parent &amp; learner app</h3><p>Attendance, report cards, homework, notices and fee balances on any phone — in the browser or the Android app.</p><a class="btn btn-primary" href="{{ $demo }}/sign-in" style="margin-top:12px">Log in as a parent <svg class="ic"><use href="#i-arrow-right"/></svg></a></div>
            </div>

            <div class="demo-box">
                @foreach ([['School admin', 'Runs the whole school: learners, staff, fees, exams and the website.', 'admin@demo.classcompass.co.ke'], ['Bursar', 'Fee collection, M-Pesa payments, invoices and accounts.', 'bursar@demo.classcompass.co.ke'], ['Parent', 'Wanjiku\'s parent: attendance, report cards and paying fees.', 'parent@demo.classcompass.co.ke'], ['Learner', 'Wanjiku Kamau, Grade 7: timetable, homework and results.', 'learner@demo.classcompass.co.ke']] as [$role, $what, $email])
                    <div class="demo-role reveal"><b>{{ $role }}</b><p>{{ $what }}</p><code>{{ $email }}</code></div>
                @endforeach
            </div>
            <p style="text-align:center;margin-top:22px">The demo password is shown on the <a href="{{ $demo }}/sign-in"><strong>demo sign-in page</strong></a>. Demo data resets every night.</p>
        </div>
    </section>

    <section id="features">
        <div class="wrap center">
            <span class="eyebrow">Everything in one system</span>
            <h2 style="margin-top:10px">One platform for the office, the classroom and home</h2>
            <p class="lead" style="margin-top:14px">Replace spreadsheets, receipt books and WhatsApp groups with one system your bursar, teachers and parents actually use.</p>
            <div class="grid" style="text-align:left">
                @foreach ($modules as [$icon, $title, $text])
                    <article class="card reveal">
                        <div class="ico"><svg class="ic"><use href="#i-{{ $icon }}"/></svg></div>
                        <h3>{{ $title }}</h3>
                        <p>{{ $text }}</p>
                    </article>
                @endforeach
            </div>
        </div>
    </section>

    <section id="curriculum" style="background:var(--bg)">
        <div class="wrap">
            <div class="center">
                <span class="eyebrow">CBC first — every curriculum supported</span>
                <h2 style="margin-top:10px">Pick your curriculum. We set up the rest.</h2>
                <p class="lead" style="margin-top:14px">Choose a curriculum at sign-up and Class Compass creates the classes, streams, learning areas and grading scale — ready for your first assessment.</p>
            </div>
            <div class="curricula">
                <div class="cur main reveal"><span class="eyebrow" style="color:#5be2bd">Kenya CBC / CBE</span><h3>PP1 – Grade 12</h3><p>Pre-primary, primary, junior and senior school with learning areas per level and the KNEC 8-level rubric.</p><div class="chips"><i>EE1</i><i>EE2</i><i>ME1</i><i>ME2</i><i>AE1</i><i>AE2</i><i>BE1</i><i>BE2</i></div></div>
                <div class="cur reveal"><span class="eyebrow">8-4-4</span><h3>Form 3 – Form 4</h3><p>For the final KCSE cohorts, with the 12-point A to E scale and KCSE subjects.</p><div class="chips"><i>A</i><i>B+</i><i>C</i><i>D-</i><i>E</i></div></div>
                <div class="cur reveal"><span class="eyebrow">British</span><h3>Reception – Year 13</h3><p>Cambridge / Edexcel: primary, Key Stage 3, IGCSE and A-Level, graded A* to U.</p><div class="chips"><i>A*</i><i>A</i><i>B</i><i>C</i><i>U</i></div></div>
                <div class="cur reveal"><span class="eyebrow">College / TVET</span><h3>Certificate & Diploma</h3><p>Years, units and KNEC / CDACC style grading for colleges and technical institutes.</p><div class="chips"><i>Distinction</i><i>Credit</i><i>Pass</i></div></div>
            </div>
        </div>
    </section>

    <section id="mpesa">
        <div class="wrap split">
            <div class="reveal">
                <span class="eyebrow" style="color:var(--mpesa)">Lipa na M-Pesa</span>
                <h2 style="margin-top:10px">Fees land in your Paybill. Receipts post themselves.</h2>
                <p class="lead" style="margin-top:14px">Connect your own Paybill or Till through Safaricom Daraja. Parents pay from the parent portal with an STK prompt — no account numbers to mistype, no bank slips to chase.</p>
                <div class="steps">
                    <div class="step"><b>1</b><div>Parent enters the amount and their Safaricom number.</div></div>
                    <div class="step"><b>2</b><div>An M-Pesa prompt appears; they approve with their PIN.</div></div>
                    <div class="step"><b>3</b><div>The receipt is posted to the learner's fee statement and accounts.</div></div>
                </div>
                <ul class="ticks">
                    <li><svg class="ic"><use href="#i-check"/></svg>Money goes straight to the school — Class Compass never holds your funds.</li>
                    <li><svg class="ic"><use href="#i-check"/></svg>Paybill or Till (Buy Goods), sandbox for testing.</li>
                    <li><svg class="ic"><use href="#i-check"/></svg>Cards and mobile money through Paystack as well.</li>
                </ul>
            </div>
            <div class="media reveal"><picture><source srcset="{{ $screen('mpesa-flow.webp') }}" type="image/webp"><img class="plain" src="{{ $screen('mpesa-flow.png') }}" alt="Real Class Compass screens: paying school fees with M-Pesa and the confirmed receipt" loading="lazy" width="950" height="896"></picture></div>
        </div>
    </section>

    <section class="dark">
        <div class="wrap split rev">
            <div class="reveal">
                <span class="eyebrow">Parents & learners</span>
                <h2 style="margin-top:10px">Keep every parent in the loop</h2>
                <p class="lead" style="margin-top:14px">Report cards, attendance, homework, notices and fee balances on any phone. Fewer calls to the office, happier parents.</p>
                <ul class="ticks">
                    <li><svg class="ic"><use href="#i-check"/></svg>Instant SMS when a learner is absent or a payment is received.</li>
                    <li><svg class="ic"><use href="#i-check"/></svg>CBC report cards parents can open and download.</li>
                    <li><svg class="ic"><use href="#i-check"/></svg>Works on low-cost Android phones and in any browser.</li>
                </ul>
            </div>
            <div class="media reveal"><picture><source srcset="{{ $screen('parent-flow.webp') }}" type="image/webp"><img class="plain" src="{{ $screen('parent-flow.png') }}" alt="Real Class Compass parent portal screens: dashboard and fee statement" loading="lazy" width="950" height="896"></picture></div>
        </div>
    </section>

    <section id="pricing">
        <div class="wrap center">
            <span class="eyebrow">Simple pricing in Kenya shillings</span>
            <h2 style="margin-top:10px">Pay per term. Upgrade any time.</h2>
            <p class="lead" style="margin-top:14px">Every plan starts with a 30-day free trial. Pay by M-Pesa or card.</p>
            <div class="toggle" role="tablist" aria-label="Billing period">
                <button class="on" data-period="term" role="tab" aria-selected="true">Per term</button>
                <button data-period="year" role="tab" aria-selected="false">Per year <small>save 10%</small></button>
            </div>
            <div class="finder">
                <label for="learners"><span>How many learners?</span><span id="learnersOut">350</span></label>
                <input id="learners" type="range" min="20" max="2500" step="10" value="350" aria-describedby="learnersOut">
            </div>
            <div class="plans">
                @foreach ($plans as $plan)
                    <div class="plan reveal" data-max="{{ $plan['max'] === PHP_INT_MAX ? 999999 : $plan['max'] }}">
                        <span class="badge">Recommended for you</span>
                        <h3>{{ $plan['name'] }}</h3>
                        <div class="tag">{{ $plan['tag'] }}</div>
                        @if ($plan['price'])
                            <div class="price" data-term="{{ $plan['price'] }}">KSh <span class="amt">{{ number_format($plan['price']) }}</span><small class="per"> / term</small></div>
                        @else
                            <div class="price">Custom</div>
                        @endif
                        <div class="learners">{{ $plan['learners'] }}</div>
                        <ul>
                            @foreach ($plan['features'] as $f)
                                <li><svg class="ic"><use href="#i-check"/></svg><span>{{ $f }}</span></li>
                            @endforeach
                        </ul>
                        @if ($plan['price'])
                            <a class="btn {{ ! empty($plan['popular']) ? 'btn-primary' : 'btn-ghost' }}" href="#get-started" data-plan="{{ $plan['key'] }}">Start free trial</a>
                        @else
                            <a class="btn btn-ghost" href="{{ ! empty($contact['email']) ? 'mailto:'.$contact['email'].'?subject=Class%20Compass%20Group%20plan' : '#get-started' }}">Talk to us</a>
                        @endif
                    </div>
                @endforeach
            </div>
            <p class="note">Prices exclude 16% VAT where applicable. Bulk SMS is billed separately at cost. Annual billing covers three terms.</p>
        </div>
    </section>

    <section id="faq" style="background:var(--bg)">
        <div class="wrap center">
            <span class="eyebrow">Questions</span>
            <h2 style="margin-top:10px">Frequently asked questions</h2>
            <div class="faq" style="text-align:left">
                @foreach ($faqs as [$q, $a])
                    <details class="reveal"><summary>{{ $q }}</summary><p>{{ $a }}</p></details>
                @endforeach
            </div>
        </div>
    </section>

    <section id="get-started" class="dark">
        <div class="wrap signup">
            <div class="reveal">
                <span class="eyebrow">Free for 30 days</span>
                <h2 style="margin-top:10px">Get your school live before next term</h2>
                <p class="lead" style="margin-top:14px">Create your school account in two minutes. Your curriculum, classes and grading are set up for you, and you can invite your bursar and teachers straight away.</p>
                <ul class="ticks">
                    <li><svg class="ic"><use href="#i-check"/></svg>No card needed — upgrade only when you are happy.</li>
                    <li><svg class="ic"><use href="#i-check"/></svg>Free help importing learners and fee balances.</li>
                    <li><svg class="ic"><use href="#i-check"/></svg>Your data stays yours. Export it any time.</li>
                </ul>
            </div>
            <form class="box reveal" id="signup" novalidate>
                <div class="msg" id="formMsg" role="alert"></div>
                <div class="legend">Your school</div>
                <div class="field"><label for="institute_name">School name</label><input id="institute_name" name="institute_name" required maxlength="100" autocomplete="organization" placeholder="e.g. Green Valley Academy"></div>
                <div class="row">
                    <div class="field"><label for="institute_email">School email</label><input id="institute_email" name="institute_email" type="email" required autocomplete="email" placeholder="info@school.ac.ke"></div>
                    <div class="field"><label for="institute_phone">School phone</label><input id="institute_phone" name="institute_phone" required maxlength="15" inputmode="tel" placeholder="0712 345 678"></div>
                </div>
                <div class="row">
                    <div class="field"><label for="curriculum">Curriculum</label>
                        <select id="curriculum" name="curriculum">
                            <option value="cbc" selected>CBC (PP1 – Grade 12)</option>
                            <option value="844">8-4-4 (Form 3 – 4)</option>
                            <option value="british">British (Cambridge / Edexcel)</option>
                            <option value="college">College / TVET</option>
                        </select>
                    </div>
                    <div class="field"><label for="institute_type">School type</label>
                        <select id="institute_type" name="institute_type">
                            <option>Pre-primary & Primary</option><option>Comprehensive (PP1 – Grade 9)</option><option>Junior School</option>
                            <option>Senior / Secondary School</option><option>International School</option><option>College / TVET</option>
                        </select>
                    </div>
                </div>
                <div class="legend">Administrator</div>
                <div class="row">
                    <div class="field"><label for="user_name">Your name</label><input id="user_name" name="user_name" required maxlength="100" autocomplete="name"></div>
                    <div class="field"><label for="user_phone">Your phone</label><input id="user_phone" name="user_phone" required maxlength="20" inputmode="tel" autocomplete="tel"></div>
                </div>
                <div class="field"><label for="user_email">Your email (for logging in)</label><input id="user_email" name="user_email" type="email" required autocomplete="email"></div>
                <div class="row">
                    <div class="field"><label for="password">Password</label><input id="password" name="password" type="password" required minlength="8" autocomplete="new-password"></div>
                    <div class="field"><label for="password_confirmation">Confirm password</label><input id="password_confirmation" name="password_confirmation" type="password" required minlength="8" autocomplete="new-password"></div>
                </div>
                <button class="btn btn-green" type="submit" id="submitBtn">Create my school account</button>
                <p class="fine">By signing up you agree to our terms and privacy policy.</p>
            </form>
        </div>
    </section>
</main>

<footer>
    <div class="wrap">
        <div class="foot">
            <div>
                <img src="{{ $asset('logo-reversed.png') }}" alt="{{ $app }}" width="160" height="49" loading="lazy">
                <p style="margin:0;max-width:320px">School management for Kenyan schools — CBC, M-Pesa fees, attendance and parent communication in one place.</p>
            </div>
            <div><h4>Product</h4><a href="#features">Features</a><a href="#curriculum">CBC & curricula</a><a href="#mpesa">M-Pesa fees</a><a href="#pricing">Pricing</a></div>
            <div><h4>Get started</h4><a href="#get-started">Free trial</a><a href="{{ $frontend }}/sign-in">Log in</a><a href="#faq">FAQ</a></div>
            <div><h4>Contact</h4>
                @if (! empty($contact['email']))<a href="mailto:{{ $contact['email'] }}">{{ $contact['email'] }}</a>@endif
                @if (! empty($contact['phone']))<a href="tel:{{ preg_replace('/\s+/', '', $contact['phone']) }}">{{ $contact['phone'] }}</a>@endif
                <span style="display:block;padding:3px 0">Nairobi, Kenya</span>
            </div>
        </div>
        <div class="copy"><span>&copy; {{ date('Y') }} {{ $app }}. All rights reserved.</span><span>Made in Kenya 🇰🇪</span></div>
    </div>
</footer>

@if (! empty($contact['whatsapp']))
    <a class="wa" href="https://wa.me/{{ preg_replace('/\D+/', '', $contact['whatsapp']) }}?text={{ rawurlencode('Hello, I would like to know more about '.$app) }}" target="_blank" rel="noopener" aria-label="Chat on WhatsApp">
        <svg class="ic" style="width:28px;height:28px"><use href="#i-message-square"/></svg>
    </a>
@endif

<script>
(function () {
    var nav = document.getElementById('nav');
    addEventListener('scroll', function () { nav.classList.toggle('scrolled', scrollY > 8); }, { passive: true });
    var menuBtn = document.getElementById('menuBtn');
    menuBtn.addEventListener('click', function () {
        var open = nav.classList.toggle('open');
        menuBtn.setAttribute('aria-expanded', open);
    });
    nav.querySelectorAll('.nav-links a').forEach(function (a) { a.addEventListener('click', function () { nav.classList.remove('open'); }); });

    // Reveal on scroll
    var io = 'IntersectionObserver' in window ? new IntersectionObserver(function (entries) {
        entries.forEach(function (e) { if (e.isIntersecting) { e.target.classList.add('in'); io.unobserve(e.target); } });
    }, { threshold: .12 }) : null;
    document.querySelectorAll('.reveal').forEach(function (el) { io ? io.observe(el) : el.classList.add('in'); });

    // Pricing: term / year toggle
    var period = 'term';
    document.querySelectorAll('.toggle button').forEach(function (b) {
        b.addEventListener('click', function () {
            period = b.dataset.period;
            document.querySelectorAll('.toggle button').forEach(function (x) { x.classList.toggle('on', x === b); x.setAttribute('aria-selected', x === b); });
            document.querySelectorAll('.price[data-term]').forEach(function (p) {
                var term = +p.dataset.term, value = period === 'year' ? Math.round(term * 3 * 0.9 / 50) * 50 : term;
                p.querySelector('.amt').textContent = value.toLocaleString('en-KE');
                p.querySelector('.per').textContent = period === 'year' ? ' / year' : ' / term';
            });
        });
    });

    // Plan finder
    var range = document.getElementById('learners'), out = document.getElementById('learnersOut');
    function recommend() {
        var n = +range.value; out.textContent = n >= 2500 ? '2,500+' : n.toLocaleString('en-KE');
        var chosen = null;
        document.querySelectorAll('.plan').forEach(function (p) { if (!chosen && n <= +p.dataset.max) chosen = p; });
        document.querySelectorAll('.plan').forEach(function (p) { p.classList.toggle('rec', p === chosen); });
    }
    range.addEventListener('input', recommend); recommend();

    // Screen tour tabs
    document.querySelectorAll('.tour-tabs button').forEach(function (b) {
        b.addEventListener('click', function () {
            document.querySelectorAll('.tour-tabs button').forEach(function (x) { x.setAttribute('aria-selected', x === b ? 'true' : 'false'); });
            document.querySelectorAll('.tour-panel').forEach(function (p) { p.classList.toggle('on', p.id === b.dataset.tab); });
        });
    });

    // Free-trial sign-up -> /api/frontend/onboarding
    var form = document.getElementById('signup'), msg = document.getElementById('formMsg'), btn = document.getElementById('submitBtn');
    function show(text, ok) { msg.className = 'msg ' + (ok ? 'ok' : 'err'); msg.innerHTML = text; msg.scrollIntoView({ behavior: 'smooth', block: 'center' }); }
    form.addEventListener('submit', function (e) {
        e.preventDefault();
        if (!form.checkValidity()) { form.reportValidity(); return; }
        var data = new FormData(form);
        if (data.get('password') !== data.get('password_confirmation')) { show('The two passwords do not match.'); return; }
        btn.disabled = true; btn.textContent = 'Creating your school…';
        fetch(@json(url('/api/frontend/onboarding')), { method: 'POST', headers: { 'Accept': 'application/json' }, body: data })
            .then(function (r) { return r.json().then(function (j) { return { ok: r.ok && j.status !== false, body: j }; }); })
            .then(function (res) {
                if (res.ok) {
                    form.reset();
                    var d = res.body.data || {}, login = d.login_url || @json($frontend.'/sign-in');
                    show('<strong>Your school is ready!</strong> Your 30-day free trial has started. <a href="' + login + '"><strong>Log in now</strong></a> with the email and password you just created.'
                        + (d.school_url ? '<br>Your school website: <a href="' + d.school_url + '">' + d.school_url.replace('https://', '') + '</a>' : ''), true);
                } else {
                    var errs = res.body.errors && typeof res.body.errors === 'object' ? Object.values(res.body.errors).flat().join('<br>') : '';
                    show(errs || res.body.message || 'Something went wrong. Please try again.');
                }
            })
            .catch(function () { show('We could not reach the server. Check your connection and try again.'); })
            .finally(function () { btn.disabled = false; btn.textContent = 'Create my school account'; });
    });
})();
</script>
</body>
</html>
