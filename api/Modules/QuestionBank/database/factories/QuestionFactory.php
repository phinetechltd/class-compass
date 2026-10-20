<?php

namespace Modules\QuestionBank\Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Modules\Authentication\Models\User;
use Modules\QuestionBank\Models\Question;

class QuestionFactory extends Factory
{
    protected $model = Question::class;

    public function definition(): array
    {
        $type = $this->faker->randomElement(['true_false', 'multiple_choice', 'multiple_true_false']);

        // Generate options
        $options = match ($type) {
            'true_false' => ['true', 'false'],
            default => [
                'option1' => $this->faker->word,
                'option2' => $this->faker->word,
                'option3' => $this->faker->word,
                'option4' => $this->faker->word,
                'option5' => $this->faker->optional()->word,
                'option6' => $this->faker->optional()->word,
            ]
        };

        // Filter out null/empty optional options
        $filteredOptions = array_filter($options);

        // Generate correct answers
        $correct_answer = match ($type) {
            'true_false' => [$this->faker->randomElement(['true', 'false'])],
            default => $this->faker->randomElements(array_values($filteredOptions), rand(1, count($filteredOptions)))
        };

        // Question year JSON
        $question_year = [
            'board' => $this->faker->randomElement(['MSB', 'DSB', 'RSB']),
            'desc' => $this->faker->words(3, true),
            'year' => $this->faker->year(),
        ];

        return [
            'type' => $type,
            'question_name' => $this->faker->optional()->sentence(3),
            'question' => $this->faker->paragraph,
            'options' => array_values($filteredOptions),
            'correct_answer' => $correct_answer,
            'explanation' => $this->faker->optional()->paragraph,
            'marks' => $this->faker->numberBetween(1, 10),
            'negative_marks' => $this->faker->randomElement([0, 1, 2]),
            'negative_marks_type' => $this->faker->randomElement(['fixed', 'percentage']),
            'price' => 0.50,
            'question_year' => $question_year,
            'language' => $this->faker->randomElement(['bn', 'en']),
            'status' => $this->faker->randomElement(['active', 'inactive', 'draft']),
            'created_by' => User::inRandomOrder()->first()->id ?? 1,
        ];
    }
}
