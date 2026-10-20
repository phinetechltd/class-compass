<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Modules\Authentication\Models\User;
use Modules\QuestionBank\Models\Quiz;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('quiz_attempts', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->foreignIdFor(Quiz::class)->constrained('quizzes')->cascadeOnDelete();
            $table->foreignIdFor(User::class)->constrained('users')->cascadeOnDelete();
            $table->json('answers')->nullable();
            $table->float('score')->default(0);
            $table->enum('status', ['started', 'submitted', 'reviewed'])->default('started'); // Attempt status
            $table->timestamp('started_at')->nullable(); // Start time of the attempt
            $table->timestamp('submitted_at')->nullable(); // Submission time
            $table->integer('time_taken')->nullable()->comment('Time taken in seconds');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('quiz_attempts');
    }
};
