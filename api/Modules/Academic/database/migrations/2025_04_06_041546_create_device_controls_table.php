<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('device_controls', function (Blueprint $table) {
            $table->id();
            $table->foreignId('student_id')->constrained()->cascadeOnDelete();
            $table->enum('device_access_type', ['single', 'multiple', 'unlimited'])->default('single');
            $table->unsignedInteger('device_limit')->nullable()->comment('Applicable only for multiple');
            $table->boolean('is_active')->default(true); // Enable/Disable toggle
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('device_controls');
    }
};
