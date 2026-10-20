<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Modules\Authentication\Models\Branch;
use Modules\Authentication\Models\Institute;
use Modules\Elearning\Models\CourseCategory;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('courses', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(Institute::class)->constrained('institutes')->cascadeOnDelete();
            $table->foreignIdFor(Branch::class)->constrained('branches')->cascadeOnDelete();
            $table->foreignIdFor(CourseCategory::class)->constrained('course_categories')->cascadeOnDelete();
            // sub-category
            $table->unsignedBigInteger('course_sub_category_id')->nullable();
            $table->foreign('course_sub_category_id')->references('id')->on('course_categories')->onDelete('cascade');
            $table->string('title');
            $table->string('slug');
            $table->string('image')->nullable();
            // Video Handling
            $table->string('video_type')->nullable();
            $table->longText('video_url')->nullable();
            $table->longText('embedded_url')->nullable();         // For iframe embed URLs
            $table->string('uploaded_video_path')->nullable();  // For self-uploaded video file paths

            // Status
            $table->enum('status', ['draft', 'schedule', 'published', 'private'])
                ->default('draft')
                ->comment('Course status: draft, schedule, published, private');
            $table->date('publish_date')->nullable();

            // Course type
            $table->enum('type', ['single', 'bundle'])
                ->default('single')
                ->comment('Course type: single, bundle');

            $table->enum('payment_type', ['free', 'recurring_payment', 'one_time'])->default('free');
            $table->string('invoice_title')->nullable();
            $table->integer('fake_enrolled_students')->default(0);
            $table->integer('total_classes')->default(0);
            $table->integer('total_notes')->default(0);
            $table->integer('total_exams')->default(0);

            $table->decimal('regular_price', 10, 2)->default(0);
            $table->decimal('offer_price', 10, 2)->default(0);
            $table->integer('repeat_count')->default(0);
            $table->string('payment_duration')->nullable();
            $table->integer('total_cycles')->nullable();
            $table->boolean('is_infinity')->default(false);
            $table->boolean('is_auto_generate_invoice')->default(false);

            $table->string('class_routine_image')->nullable();
            $table->longText('description')->nullable();

            $table->text('meta_description')->nullable();
            $table->text('meta_keywords')->nullable();
            $table->unsignedInteger('total_view')->default(0);
            $table->unsignedInteger('total_enrolled')->default(0);
            $table->decimal('avg_rating', 10, 2)->default(0);

            $table->date('start_date')->nullable();
            $table->date('end_date')->nullable();
            $table->text('requirements')->nullable();

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
        Schema::dropIfExists('courses');
    }
};
