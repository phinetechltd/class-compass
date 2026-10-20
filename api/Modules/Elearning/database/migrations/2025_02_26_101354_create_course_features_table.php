<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Modules\Authentication\Models\Institute;
use Modules\Elearning\Models\Course;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('course_features', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(Institute::class)->constrained('institutes')->cascadeOnDelete();
            $table->foreignIdFor(Course::class)->constrained('courses')->cascadeOnDelete();
            $table->string('name', 255);
            $table->longText('priority')->nullable();

            // Status
            $table->smallInteger('status')->default(1)->comment('1=Active, 2=InActive');
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
        Schema::dropIfExists('course_features');
    }
};
