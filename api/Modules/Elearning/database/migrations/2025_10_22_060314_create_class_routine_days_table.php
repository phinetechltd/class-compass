<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('lms_class_routine_days', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('routine_id');
            $table->unsignedBigInteger('day_id');
            $table->timestamps();

            $table->foreign('routine_id')->references('id')->on('lms_class_routines')->onDelete('cascade');
            $table->foreign('day_id')->references('id')->on('lms_days')->onDelete('cascade');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('lms_class_routine_days');
    }
};
