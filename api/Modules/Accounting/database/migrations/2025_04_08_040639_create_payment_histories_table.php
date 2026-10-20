<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Modules\Authentication\Models\Institute;
use Modules\Authentication\Models\User;
use Modules\Elearning\Models\Course;
use Modules\Payroll\Models\PaymentMethod;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('payment_histories', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(Institute::class)->constrained('institutes')->cascadeOnDelete();
            $table->foreignIdFor(User::class)->constrained('users')->cascadeOnDelete();
            $table->foreignIdFor(Course::class)->constrained('courses')->cascadeOnDelete();
            $table->foreignIdFor(PaymentMethod::class)->constrained('payment_methods')->cascadeOnDelete();
            $table->string('invoice_number', 32)->unique();
            $table->string('invoice_title')->default('Monthly fee');
            $table->decimal('payable', 10, 2)->default(0);
            $table->decimal('paid', 10, 2)->default(0);
            $table->decimal('due', 10, 2)->default(0);
            $table->decimal('discount', 10, 2)->default(0);
            $table->enum('status', ['Paid', 'Unpaid', 'Partial'])->default('Unpaid');
            $table->date('date_issued')->nullable();
            $table->date('due_date')->nullable();
            $table->string('provider_transaction_id')->nullable();
            $table->string('mobile_payment_provider')->nullable();
            $table->enum('confirmation_status', ['Pending', 'Confirmed', 'Failed'])->default('Pending');
            $table->string('attachments')->nullable();
            $table->longText('internal_notes')->nullable();
            $table->boolean('send_sms')->default(false);
            $table->boolean('send_email')->default(false);
            $table->timestamps();
            $table->softDeletes();

            $table->unique(['user_id', 'course_id', 'date_issued']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('payment_histories');
    }
};
