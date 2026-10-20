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
        Schema::create('student_devices', function (Blueprint $table) {
            $table->id();
            $table->foreignId('student_id')->constrained()->cascadeOnDelete();
            $table->string('device_name')->nullable(); // Optional, like "Alpha - 242"
            $table->string('mac_id')->nullable(); // MAC address or unique device ID
            $table->string('ip_address')->nullable();
            $table->json('device_info')->nullable(); // Device information in JSON format
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('student_devices');
    }
};
