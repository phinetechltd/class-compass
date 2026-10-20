<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('result_cards', function (Blueprint $table) {
            $table->id();

            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();

            $table->string('name', 100); // Result card title
            $table->string('qr_code')->nullable();

            // Teacher signatures (2 teachers)
            $table->foreignId('signature_id')->nullable()->constrained('signatures')->nullOnDelete();
            $table->foreignId('teacher_signature_id')->nullable()->constrained('signatures')->nullOnDelete();

            // Images & design
            $table->string('background_image')->nullable();
            $table->string('header_logo')->nullable();
            $table->string('stamp_image')->nullable();
            $table->string('border_design')->nullable();
            $table->string('watermark')->nullable();

            $table->smallInteger('status')->default(1)->comment('1=Active, 2=Inactive');

            $table->timestamps();
            $table->softDeletes();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('result_cards');
    }
};
