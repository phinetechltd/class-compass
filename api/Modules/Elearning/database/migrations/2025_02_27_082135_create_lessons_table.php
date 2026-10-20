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
        Schema::create('lessons', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(Institute::class)->constrained('institutes')->cascadeOnDelete();
            $table->foreignIdFor(Course::class)->constrained('courses')->cascadeOnDelete();
            $table->foreignIdFor(Chapter::class)->constrained('chapters')->cascadeOnDelete();
            $table->string('title');
            $table->string('slug')->nullable();
            $table->longText('description')->nullable();
            $table->string('thumbnail_image')->nullable();
            $table->string('video_type')->nullable();
            $table->longText('video_url')->nullable();            // For YouTube/Vimeo/external URLs
            $table->longText('embedded_url')->nullable();         // For iframe embed URLs
            $table->string('uploaded_video_path')->nullable();  // For self-uploaded video file paths
            $table->string('document_file')->nullable();  // For self-uploaded video file paths
            $table->json('attachments')->nullable(); // store uploaded files
            $table->unsignedInteger('priority')->default(1);
            // Video playback timing
            $table->integer('playback_hours')->default(0);
            $table->integer('playback_minutes')->default(0);
            $table->integer('playback_seconds')->default(0);
            // Scheduling
            $table->boolean('is_scheduled')->default(false);
            $table->timestamp('scheduled_at')->nullable();
            // Visibility & access
            $table->enum('visibility', ['none', 'password', 'public'])->default('none');
            $table->string('password')->nullable(); // Store hashed password ideally
            // Status
            $table->enum('status', ['active', 'inactive', 'draft'])
                ->default('active')
                ->comment('Lesson status: active, inactive, draft');

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
        Schema::dropIfExists('lessons');
    }
};
