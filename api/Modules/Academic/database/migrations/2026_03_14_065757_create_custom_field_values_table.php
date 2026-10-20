<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('custom_field_values', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('institute_id')->index();
            $table->unsignedBigInteger('branch_id')->index();
            $table->unsignedBigInteger('custom_field_id')->index();
            $table->morphs('model');
            $table->text('value')->nullable();
            $table->smallInteger('status')->default(1)->comment('1=Active, 2=Inactive');
            $table->timestamps();
            $table->softDeletes();
            $table->foreign('custom_field_id')->references('id')->on('custom_fields')->cascadeOnDelete();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('custom_field_values');
    }
};
