<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Modules\Authentication\Models\Institute;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('lms_zoom_meetings', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(Institute::class)->constrained('institutes')->cascadeOnDelete();
            $table->foreignId('course_id')->constrained('courses')->cascadeOnDelete();
            $table->string('meeting_id');
            $table->text('topic');
            $table->text('agenda')->nullable();
            $table->string('start_time');
            $table->integer('duration')->nullable();
            $table->string('password')->nullable();
            $table->longText('join_url');
            $table->longText('start_url');
            $table->foreignId('created_by')->nullable()->constrained('users')->cascadeOnDelete();
            $table->timestamps();
            $table->softDeletes();

            // Combine unique constraint
            $table->unique(['institute_id', 'meeting_id'], 'unique_combination');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('lms_zoom_meetings');
    }
};
