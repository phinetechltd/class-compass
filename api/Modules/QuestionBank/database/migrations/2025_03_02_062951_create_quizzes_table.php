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
        Schema::create('quizzes', function (Blueprint $table) {
            $table->id();

            // Relations
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->foreignId('created_by')->nullable()->constrained('users')->nullOnDelete();
            $table->unsignedInteger('priority')->default(1);

            // General
            $table->string('title');
            $table->longText('description')->nullable();
            $table->longText('guidelines')->nullable();
            $table->boolean('show_description_on_course_page')->default(false);
            $table->enum('type', ['practice', 'mock', 'quick_test', 'exam'])->default('practice');

            // Questions
            $table->json('question_ids')->nullable();

            // Timing
            $table->dateTime('start_time')->nullable();
            $table->dateTime('end_time')->nullable();
            $table->boolean('has_time_limit')->default(false);  // Toggle for time limit
            $table->integer('time_limit_value')->nullable();    // Time value
            $table->enum('time_limit_unit', ['seconds', 'minutes', 'hours', 'days', 'weeks'])->nullable(); // Time unit
            $table->enum('on_expiry', ['auto_submit', 'prevent_submit', 'grace_time'])->default('auto_submit');

            // Grading
            $table->decimal('marks_per_question', 5, 2)->default(1);
            $table->decimal('negative_marks_per_wrong_answer', 5, 2)->default(0);
            $table->decimal('pass_mark', 5, 2)->default(0);
            $table->integer('attempts_allowed')->nullable(); // null = unlimited
            $table->boolean('enable_negative_marking')->default(false);
            $table->enum('result_visibility', ['immediate', 'after_review', 'never'])->default('immediate');

            // Layout
            $table->integer('layout_pages')->nullable(); // questions per page or sections
            $table->boolean('shuffle_questions')->default(false);
            $table->boolean('shuffle_options')->default(false);

            // Security
            $table->enum('access_type', ['none', 'password', 'public'])->default('none');
            $table->string('access_password')->nullable();

            // Status
            $table->enum('status', ['active', 'inactive', 'draft'])
                ->default('active')
                ->comment('Lesson status: active, inactive, draft');

            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('quizzes');
    }
};
