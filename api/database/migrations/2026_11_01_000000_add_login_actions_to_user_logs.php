<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

/** Audit trail records sign-ins and sign-outs as well as changes. */
return new class extends Migration
{
    public function up(): void
    {
        DB::statement("ALTER TABLE user_logs MODIFY action ENUM('create','update','view','delete','fee_collect','payment','receipt','login','logout') NOT NULL DEFAULT 'create'");
    }

    public function down(): void
    {
        DB::table('user_logs')->whereIn('action', ['login', 'logout'])->delete();
        DB::statement("ALTER TABLE user_logs MODIFY action ENUM('create','update','view','delete','fee_collect','payment','receipt') NOT NULL DEFAULT 'create'");
    }
};
