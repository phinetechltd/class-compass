<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('custom_fields', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('institute_id')->index();
            $table->unsignedBigInteger('branch_id')->index();
            $table->string('module')->default('student')->comment('student, teacher, employee');
            $table->string('field_name')->index()->comment('database key e.g blood_group');
            $table->string('label')->comment('Display label');
            $table->string('field_type')->default('text')->comment('text, number, select, date, checkbox');
            $table->json('options')->nullable()->comment('For select, checkbox options');
            $table->boolean('is_required')->default(false);
            $table->boolean('show_in_form')->default(true);
            $table->boolean('show_in_list')->default(false);
            $table->boolean('show_in_profile')->default(true);
            $table->integer('serial')->default(0);
            $table->smallInteger('status')->default(1)->comment('1=Active, 2=Inactive');

            $table->timestamps();
            $table->softDeletes();

            $table->index(['institute_id', 'branch_id', 'module']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('custom_fields');
    }
};
