<?php

namespace Modules\Elearning\Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;
use Modules\Elearning\Models\Chapter;
use Modules\Elearning\Models\Course;

class ChapterFactory extends Factory
{
    protected $model = Chapter::class;

    public function definition(): array
    {
        $title = ucfirst(fake()->sentence(5));
        $slug = Str::slug($title);

        // Ensure slug uniqueness
        while (Chapter::where('slug', $slug)->exists()) {
            $slug = Str::slug($title.'-'.fake()->unique()->numberBetween(1, 1000));
        }

        return [
            'institute_id' => fake()->numberBetween(1, 2),
            'course_id' => Course::inRandomOrder()->first()->id ?? Course::factory(),
            'title' => $title,
            'slug' => $slug,
            'priority' => fake()->numberBetween(1, 20),
            'image' => fake()->optional()->randomElement([
                'https://i.ibb.co.com/XYZ/chapter1.png',
                'https://i.ibb.co.com/XYZ/chapter2.png',
                'https://i.ibb.co.com/XYZ/chapter3.png',
            ]),
            'description' => fake()->paragraphs(2, true),
            'meta_description' => fake()->sentence(10),
            'meta_keywords' => implode(', ', fake()->words(5)),
            'status' => fake()->randomElement(['active', 'inactive', 'draft']),
            'created_by' => 2,
        ];
    }
}
