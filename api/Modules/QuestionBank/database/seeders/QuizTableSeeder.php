<?php

namespace Modules\QuestionBank\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\QuestionBank\Models\Quiz;

class QuizTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Quiz::factory()->count(10)->create();
    }
}
