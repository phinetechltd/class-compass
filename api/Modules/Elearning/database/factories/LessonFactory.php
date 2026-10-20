<?php

namespace Modules\Elearning\Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;
use Modules\Elearning\Models\Chapter;
use Modules\Elearning\Models\Course;
use Modules\Elearning\Models\Lesson;

class LessonFactory extends Factory
{
    protected $model = Lesson::class;

    public function definition(): array
    {
        $title = ucfirst(fake()->sentence(5));
        $slug = Str::slug($title);

        // Ensure slug uniqueness
        while (Lesson::where('slug', $slug)->exists()) {
            $slug = Str::slug($title.'-'.fake()->unique()->numberBetween(1, 1000));
        }

        return [
            'institute_id' => fake()->numberBetween(1, 2),
            'course_id' => Course::inRandomOrder()->first()->id ?? Course::factory(),
            'chapter_id' => Chapter::inRandomOrder()->first()->id ?? Chapter::factory(),
            'title' => $title,
            'slug' => $slug,
            'priority' => fake()->numberBetween(1, 20),
            'description' => fake()->paragraphs(2, true),
            'video_url' => fake()->optional(0.4)->url(),
            'embedded_url' => fake()->optional(0.3)->url(),
            'status' => 'active',
            'created_by' => 2,
        ];
    }
}
