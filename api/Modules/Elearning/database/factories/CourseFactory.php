<?php

namespace Modules\Elearning\Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;
use Modules\Elearning\Models\Course;
use Modules\Elearning\Models\CourseCategory;

class CourseFactory extends Factory
{
    protected $model = Course::class;

    public function definition(): array
    {
        $title = ucfirst(fake()->sentence(5));
        $startDate = fake()->dateTimeBetween('2025-03-01', '2025-10-31'); // Start between March and October 2025
        $endDate = fake()->dateTimeBetween($startDate, '2025-12-31'); // End after start but within 2025

        // Ensure the title and slug are unique
        $slug = Str::slug($title);

        // Handle potential slug duplicates by checking if it's already in the database
        while (Course::where('slug', $slug)->exists()) {
            $slug = Str::slug($title.'-'.fake()->unique()->numberBetween(1, 1000));
        }

        return [
            'institute_id' => fake()->numberBetween(1, 2),
            'title' => $title,
            'type' => 'single',
            'slug' => $slug,  // Use the unique slug
            'course_category_id' => CourseCategory::inRandomOrder()->first()?->id,
            'course_sub_category_id' => fake()->numberBetween(3, 5),
            'regular_price' => fake()->randomFloat(2, 50, 2000), // More realistic pricing
            'offer_price' => fake()->randomFloat(2, 30, 1500), // Offer price less than regular price
            'image' => fake()->randomElement([
                'https://i.ibb.co.com/KpFhYZdT/course3.png',
                'https://i.ibb.co.com/Df6RWzXr/course2.png',
                'https://i.ibb.co.com/5h8ggbCZ/course1.png',
            ]),
            'class_routine_image' => fake()->randomElement([
                'https://i.ibb.co.com/WWLRsbH2/Routin-1.png',
                'https://i.ibb.co.com/WWLRsbH2/Routin-1.png',
                'https://i.ibb.co.com/WWLRsbH2/Routin-1.png',
            ]),
            'description' => fake()->paragraphs(3, true),
            'meta_description' => fake()->sentence(10),
            'meta_keywords' => implode(', ', fake()->words(5)),
            'total_view' => fake()->numberBetween(100, 5000),
            'total_enrolled' => fake()->numberBetween(10, 500),
            'avg_rating' => fake()->randomFloat(1, 3, 5),
            'start_date' => $startDate->format('Y-m-d'),
            'end_date' => $endDate->format('Y-m-d'),
            'requirements' => fake()->sentences(2, true),
            'created_by' => 2,
            'status' => 'published',  // fake()->randomElement(['not_start', 'ongoing', 'completed'])
        ];
    }
}
