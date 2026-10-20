<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Modules\Authentication\Models\Institute;
use Modules\Authentication\Models\User;
use Modules\Elearning\Models\Course;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('enrollments', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(Institute::class)->constrained('institutes')->cascadeOnDelete();
            $table->foreignIdFor(User::class)->constrained('users')->cascadeOnDelete();
            $table->foreignIdFor(Course::class)->constrained('courses')->cascadeOnDelete();
            $table->enum('enrollment_type', ['one_time', 'monthly_subscription'])->default('one_time'); // To distinguish between one-time and monthly subscription.
            $table->date('enrollment_date'); // Date of enrollment
            $table->timestamp('subscription_start')->nullable(); // For monthly subscription
            $table->timestamp('subscription_end')->nullable(); // For monthly subscription
            $table->decimal('amount_paid', 8, 2)->default(0); // The amount paid for the course
            // Status
            $table->enum('status', ['active', 'inactive', 'blocked'])
                ->default('inactive')
                ->comment('Enrollment status: active, inactive, blocked');
            $table->timestamps();
            $table->softDeletes();

            // Add the composite unique constraint
            $table->unique(['course_id', 'user_id']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('enrollments');
    }
};
