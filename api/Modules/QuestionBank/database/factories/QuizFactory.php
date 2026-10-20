<?php

namespace Modules\QuestionBank\Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Modules\Authentication\Models\Branch;
use Modules\Authentication\Models\Institute;
use Modules\Authentication\Models\User;
use Modules\QuestionBank\Models\Question;
use Modules\QuestionBank\Models\Quiz;

class QuizFactory extends Factory
{
    protected $model = Quiz::class;

    public function definition(): array
    {
        $hasTimeLimit = $this->faker->boolean(70);
        $timeUnits = ['seconds', 'minutes', 'hours', 'days', 'weeks'];
        $accessTypes = ['none', 'password', 'public'];
        $quizTypes = ['practice', 'exam'];
        $resultVisibilities = ['immediate', 'after_review', 'never'];
        $onExpiryOptions = ['auto_submit', 'prevent_submit', 'grace_time'];
        $statuses = ['active', 'inactive', 'draft'];

        return [
            // Relations
            'institute_id' => Institute::inRandomOrder()->first()->id ?? Institute::factory(),
            'branch_id' => Branch::inRandomOrder()->first()->id ?? Branch::factory(),
            'created_by' => User::inRandomOrder()->first()->id ?? User::factory(),

            // General Info
            'title' => $this->faker->sentence(6),
            'description' => $this->faker->paragraph(),
            'guidelines' => $this->faker->optional()->paragraph(),
            'show_description_on_course_page' => $this->faker->boolean(),
            'type' => $this->faker->randomElement($quizTypes),

            // Questions
            'question_ids' => Question::inRandomOrder()->limit(5)->pluck('id')->toArray(),

            // Timing
            'start_time' => now()->addDays($this->faker->numberBetween(1, 3)),
            'end_time' => now()->addDays($this->faker->numberBetween(4, 10)),
            'has_time_limit' => $hasTimeLimit,
            'time_limit_value' => $hasTimeLimit ? $this->faker->numberBetween(5, 120) : null,
            'time_limit_unit' => $hasTimeLimit ? $this->faker->randomElement($timeUnits) : null,
            'on_expiry' => $this->faker->randomElement($onExpiryOptions),

            // Grading
            'marks_per_question' => $this->faker->randomFloat(2, 0.5, 5),
            'negative_marks_per_wrong_answer' => $this->faker->randomFloat(2, 0.0, 2),
            'pass_mark' => $this->faker->randomFloat(2, 10, 100),
            'attempts_allowed' => $this->faker->optional()->numberBetween(1, 5),
            'result_visibility' => $this->faker->randomElement($resultVisibilities),

            // Layout
            'layout_pages' => $this->faker->optional()->numberBetween(1, 5),
            'shuffle_questions' => $this->faker->boolean(),
            'shuffle_options' => $this->faker->boolean(),

            // Security
            'access_type' => $this->faker->randomElement($accessTypes),
            'access_password' => $this->faker->optional()->password(6),

            // Status
            'status' => $this->faker->randomElement($statuses),
        ];
    }
}
