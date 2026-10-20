<?php

namespace Modules\Elearning\Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Modules\Authentication\Models\Institute;
use Modules\Elearning\Models\Course;
use Modules\Elearning\Models\CourseFaq;

class CourseFaqFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     */
    protected $model = CourseFaq::class;

    /**
     * Define the model's default state.
     */
    public function definition(): array
    {
        return [
            'institute_id' => Institute::inRandomOrder()->first()?->id,
            'course_id' => Course::inRandomOrder()->first()?->id,
            'question' => fake()->sentence(10),
            'answer' => fake()->paragraphs(2, true),
            'status' => fake()->randomElement([1, 2]),
        ];
    }
}
