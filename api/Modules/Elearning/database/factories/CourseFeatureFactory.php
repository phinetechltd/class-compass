<?php

namespace Modules\Elearning\Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Modules\Authentication\Models\Institute;
use Modules\Elearning\Models\Course;
use Modules\Elearning\Models\CourseFeature;

class CourseFeatureFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     */
    protected $model = CourseFeature::class;

    /**
     * Define the model's default state.
     */
    public function definition(): array
    {
        return [
            'institute_id' => Institute::inRandomOrder()->first()?->id,
            'course_id' => Course::inRandomOrder()->first()?->id,
            'name' => fake()->sentence(10),
            'priority' => fake()->numberBetween(10, 100),
            'status' => fake()->randomElement([1, 2]),
        ];
    }
}
