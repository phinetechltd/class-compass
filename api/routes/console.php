<?php

use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Schedule;

// Put the public demo logins back every night (see classcompass:demo-accounts).
Schedule::command('classcompass:demo-accounts --refresh')->dailyAt('02:00');

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote')->hourly();
