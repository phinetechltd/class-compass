<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('question_bank_sub_sources', function (Blueprint $table) {
            $table->id();
            $table->foreignId('source_id')->constrained('question_bank_sources')->onDelete('cascade');
            $table->string('sub_source_name');
            $table->smallInteger('status')->default(1)->comment('1=Active, 2=InActive');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('question_bank_sub_sources');
    }
};
