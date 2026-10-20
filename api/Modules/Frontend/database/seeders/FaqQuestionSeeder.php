<?php

namespace Modules\Frontend\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\Frontend\Models\FaqQuestion;

class FaqQuestionSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        FaqQuestion::insert([
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'question' => 'What is an academic program?',
                'answer' => 'The academic program is a one stop solution for students. Where every student has the opportunity to ensure A+ preparation for  board exams through interactive live classes, homework, live tests and progress analysis by the best mentors in each subject throughout the year. Once a student starts this program, he will not have to go to any coaching or private tutor after school/college.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'question' => 'What is an academic program?',
                'answer' => 'The academic program is a one stop solution for students. Where every student has the opportunity to ensure A+ preparation for  board exams through interactive live classes, homework, live tests and progress analysis by the best mentors in each subject throughout the year. Once a student starts this program, he will not have to go to any coaching or private tutor after school/college.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'question' => 'What is an academic program?',
                'answer' => 'The academic program is a one stop solution for students. Where every student has the opportunity to ensure A+ preparation for  board exams through interactive live classes, homework, live tests and progress analysis by the best mentors in each subject throughout the year. Once a student starts this program, he will not have to go to any coaching or private tutor after school/college.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
