<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Modules\QuestionBank\Models\QuestionCategory;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('question_bank_subjects', function (Blueprint $table) {
            $table->id();
            $table->foreignId('class_id')->nullable()->constrained('question_bank_classes')->onDelete('cascade');
            $table->foreignId('group_id')->nullable()->constrained('question_bank_groups')->onDelete('set null');
            $table->foreignIdFor(QuestionCategory::class)->nullable()->constrained('question_categories')->cascadeOnDelete();
            $table->string('name');

            $table->string('code')->nullable();
            $table->string('type')->nullable();

            $table->string('slug')->nullable();
            $table->string('color_code')->nullable()->comment('Color code for the bg category');
            $table->unsignedInteger('priority')->default(1);
            $table->longText('description')->nullable();
            $table->string('icon')->nullable(); // Image for the category
            $table->string('image')->nullable(); // Image for the category

            $table->smallInteger('status')->default(1)->comment('1=Active, 2=InActive');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('question_bank_subjects');
    }
};
