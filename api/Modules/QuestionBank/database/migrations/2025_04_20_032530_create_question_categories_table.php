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
        Schema::create('question_categories', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->string('name');
            $table->string('slug')->nullable();
            $table->string('color_code')->nullable()->comment('Color code for the bg category');
            $table->unsignedInteger('priority')->default(1);
            $table->longText('description')->nullable();
            $table->string('icon')->nullable(); // Image for the category
            $table->string('image')->nullable(); // Image for the category

            // Status
            $table->smallInteger('status')->default(1)->comment('1=Active, 2=InActive');
            $table->foreignId('created_by')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('question_categories');
    }
};
