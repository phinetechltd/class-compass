<?php

namespace Modules\QuestionBank\Database\Seeders;

use Faker\Factory as Faker;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class QuestionTableSeeder extends Seeder
{
    public function run()
    {
        $faker = Faker::create();

        // Get all subjects
        $subjects = DB::table('question_bank_subjects')->get();

        foreach ($subjects as $subject) {
            // Get all chapters for this subject
            $chapters = DB::table('question_bank_chapters')
                ->where('subject_id', $subject->id)
                ->get();

            foreach ($chapters as $chapter) {
                // Count existing questions for this chapter
                $existingCount = DB::table('questions')
                    ->where('question_bank_subject_id', $subject->id)
                    ->where('question_bank_chapter_id', $chapter->id)
                    ->count();

                $needed = 10 - $existingCount;

                if ($needed > 0) {
                    $questions = [];
                    for ($i = 0; $i < $needed; $i++) {
                        $questions[] = [
                            'question' => $faker->sentence(6),
                            'question_bank_subject_id' => $subject->id,
                            'question_bank_chapter_id' => $chapter->id,
                            'type' => 'multiple_choice', // adjust type as needed
                            'options' => json_encode([
                                $faker->word,
                                $faker->word,
                                $faker->word,
                                $faker->word,
                            ]),
                            'correct_answer' => json_encode([2]), // always 3rd option for demo
                            'status' => 1,
                            'created_at' => now(),
                            'updated_at' => now(),
                        ];
                    }

                    DB::table('questions')->insert($questions);
                }
            }
        }

        $this->command->info('Subjects and chapters now have at least 10 questions each.');
    }
}
