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
        Schema::create('client_licenses', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained()->onDelete('cascade');
            $table->foreignId('plan_id')->nullable()->constrained()->nullOnDelete();
            $table->string('license_key')->unique();
            $table->enum('status', ['active', 'expired', 'suspended', 'revoked'])->default('active');
            $table->date('issued_at')->nullable();
            $table->date('expires_at')->nullable();
            $table->integer('student_limit')->default(0);
            $table->integer('branch_limit')->default(0);
            $table->text('notes')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('client_licenses');
    }
};
