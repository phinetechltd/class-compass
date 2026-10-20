<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Modules\Authentication\Models\Institute;
use Modules\Elearning\Models\Chapter;
use Modules\Elearning\Models\Course;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('content_visibility', function (Blueprint $table) {
            $table->id();

            // Relationships
            $table->foreignIdFor(Institute::class)->constrained('institutes')->cascadeOnDelete();
            $table->foreignIdFor(Course::class)->constrained('courses')->cascadeOnDelete();
            $table->foreignIdFor(Chapter::class)->constrained('chapters')->cascadeOnDelete();
            $table->unsignedBigInteger('content_id'); // can map to lessons/quiz/etc.

            // Visibility
            $table->boolean('is_enabled')->default(true);

            $table->foreignId('created_by')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('content_visibility');
    }
};
