<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Modules\QuestionBank\Models\Quiz;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('quiz_results', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->foreignIdFor(Quiz::class)->constrained('quizzes')->cascadeOnDelete();
            $table->foreignId('quiz_attempt_id')->constrained('quiz_attempts')->cascadeOnDelete();
            $table->float('score')->default(0); // Total score obtained in the quiz
            $table->float('negative_marks')->default(0);
            $table->integer('position')->nullable();
            $table->integer('question_count')->nullable();
            $table->integer('correct_count')->default(0);
            $table->integer('incorrect_count')->default(0);
            $table->integer('skipped_count')->default(0);
            $table->json('detailed_results')->nullable();
            $table->string('is_passed')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('quiz_results');
    }
};
