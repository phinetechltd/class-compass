<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Modules\Authentication\Models\Institute;
use Modules\Elearning\Models\Chapter;
use Modules\Elearning\Models\Course;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('lms_assignments', function (Blueprint $table) {
            $table->id();

            $table->foreignIdFor(Institute::class)->constrained('institutes')->cascadeOnDelete();
            $table->foreignIdFor(Course::class)->constrained('courses')->cascadeOnDelete();
            $table->foreignIdFor(Chapter::class)->constrained('chapters')->cascadeOnDelete();
            $table->unsignedInteger('priority')->default(1);

            $table->string('title');
            $table->longText('description')->nullable();
            $table->dateTime('due_date');
            $table->string('file_path')->nullable(); // Store the file path
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
        Schema::dropIfExists('lms_assignments');
    }
};
