<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('institute_image_s_a_a_s_settings', function (Blueprint $table) {
            $table->id();
            // logos & banners
            $table->string('header_logo_light_theme')->nullable();
            $table->string('header_logo_dark_theme')->nullable();
            $table->string('footer_logo_light_theme')->nullable();
            $table->string('footer_logo_dark_theme')->nullable();
            $table->string('banner_image')->nullable();
            $table->smallInteger('status')->default(1)->comment('1=Active, 0=InActive');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('institute_image_s_a_a_s_settings');
    }
};
