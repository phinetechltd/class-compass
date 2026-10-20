<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Modules\Authentication\Models\Institute;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('lms_days', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(Institute::class)->constrained('institutes')->cascadeOnDelete();
            $table->string('name');
            $table->integer('serial')->default(0);
            $table->smallInteger('status')->default(1)->comment('1=Active, 2=InActive');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('lms_days');
    }
};
