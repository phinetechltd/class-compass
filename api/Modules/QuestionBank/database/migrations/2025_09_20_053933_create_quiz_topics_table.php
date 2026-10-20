<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Modules\QuestionBank\Models\QuestionBankChapter;
use Modules\QuestionBank\Models\QuestionBankSubject;
use Modules\QuestionBank\Models\QuestionCategory;
use Modules\QuestionBank\Models\Quiz;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('quiz_topics', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained('institutes')->cascadeOnDelete();
            $table->foreignIdFor(Quiz::class)->constrained()->cascadeOnDelete();
            $table->foreignIdFor(QuestionBankSubject::class)->nullable()->constrained()->cascadeOnDelete();
            $table->foreignIdFor(QuestionBankChapter::class)->nullable()->constrained()->cascadeOnDelete();
            $table->foreignIdFor(QuestionCategory::class)->nullable()->constrained()->cascadeOnDelete();
            $table->integer('question_limit')->default(10); // how many random questions

            $table->smallInteger('status')->default(1)->comment('1=Active, 2=InActive');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('quiz_topics');
    }
};
