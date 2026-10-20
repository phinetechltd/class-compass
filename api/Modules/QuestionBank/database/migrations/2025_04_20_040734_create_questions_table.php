<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Modules\QuestionBank\Models\QuestionBankChapter;
use Modules\QuestionBank\Models\QuestionBankClass;
use Modules\QuestionBank\Models\QuestionBankDifficultyLevel;
use Modules\QuestionBank\Models\QuestionBankGroup;
use Modules\QuestionBank\Models\QuestionBankSubject;
use Modules\QuestionBank\Models\QuestionCategory;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('questions', function (Blueprint $table) {
            $table->id();

            $table->foreignIdFor(QuestionBankClass::class)->nullable()->constrained('question_bank_classes')->cascadeOnDelete();
            $table->foreignIdFor(QuestionBankGroup::class)->nullable()->constrained('question_bank_groups')->cascadeOnDelete();
            $table->foreignIdFor(QuestionCategory::class)->nullable()->constrained('question_categories')->cascadeOnDelete();
            $table->foreignIdFor(QuestionBankSubject::class)->nullable()->constrained('question_bank_subjects')->cascadeOnDelete();
            $table->foreignIdFor(QuestionBankChapter::class)->nullable()->constrained('question_bank_chapters')->cascadeOnDelete();
            $table->foreignIdFor(QuestionBankDifficultyLevel::class)->nullable()->constrained('question_bank_difficulty_levels')->cascadeOnDelete();

            $table->enum('type', ['true_false', 'multiple_choice', 'multiple_true_false']);
            $table->text('question_name')->nullable();
            $table->longText('question');
            $table->longText('options');
            $table->json('correct_answer');
            $table->longText('explanation')->nullable();

            // Percentage / Fixed Dynamically Markings table and seeder.
            $table->integer('marks')->default(1); // Marks for correct answer
            $table->integer('negative_marks')->default(0);
            $table->enum('negative_marks_type', ['fixed', 'percentage'])->default('fixed');

            // New Fields (based on your content)
            $table->string('image_file')->nullable();
            $table->decimal('price', 8, 4)->nullable();
            $table->json('question_year')->nullable();
            $table->string('language')->default('bn');

            // Status
            $table->enum('status', ['active', 'inactive', 'draft'])
                ->default('inactive')
                ->comment('Lesson status: active, inactive, draft');

            $table->foreignId('institute_id')->nullable()->constrained('institutes')->nullOnDelete();
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
        Schema::dropIfExists('questions');
    }
};
