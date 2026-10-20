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
        Schema::create('course_categories', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(Institute::class)->constrained('institutes')->cascadeOnDelete();
            $table->string('name');
            $table->string('slug');
            $table->string('image')->nullable();
            $table->string('bg_color', 7)->nullable();
            $table->unsignedInteger('priority')->default(1);
            $table->boolean('enable_homepage')->default(true);
            $table->longText('description')->nullable();
            // Parent Category Relation (Self-reference)
            $table->foreignId('parent_id')->nullable()->constrained('course_categories')->nullOnDelete();
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
        Schema::dropIfExists('course_categories');
    }
};
