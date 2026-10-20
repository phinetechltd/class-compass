<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Modules\Authentication\Models\Institute;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('contents', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(Institute::class)->constrained('institutes')->cascadeOnDelete();

            $table->unsignedBigInteger('chapter_id'); // Course chapter association
            $table->foreign('chapter_id')->references('id')->on('chapters')->onDelete('cascade');

            // ENUM type - limited to known types
            $table->enum('type', ['lesson', 'quiz', 'assignment', 'pdf', 'offline']);

            // Polymorphic relationship
            $table->unsignedBigInteger('type_id');

            // Order for drag-and-drop sorting
            $table->unsignedInteger('serial')->default(0);

            $table->timestamps();
            $table->softDeletes();

            // Optional: composite unique to avoid duplicate type_id/type in a chapter
            $table->unique(['chapter_id', 'type', 'type_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('contents');
    }
};
