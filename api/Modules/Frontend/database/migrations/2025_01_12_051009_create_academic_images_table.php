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
        Schema::create('academic_images', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(Institute::class)->constrained('institutes')->cascadeOnDelete();
            $table->string('title')->nullable();
            $table->text('heading')->nullable();
            $table->longText('description')->nullable();
            $table->string('image')->nullable();
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
        Schema::dropIfExists('academic_images');
    }
};
