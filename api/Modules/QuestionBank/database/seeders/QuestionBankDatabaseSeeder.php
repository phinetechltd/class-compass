<?php

namespace Modules\QuestionBank\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class QuestionBankDatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // // Classes
        // $classes = [
        //     ['name' => 'Class 9', 'status' => 1],
        //     ['name' => 'Class 10', 'status' => 1],
        // ];
        // DB::table('question_bank_classes')->insert($classes);

        // // Groups
        // $groups = [
        //     ['name' => 'Science'],
        //     ['name' => 'Commerce'],
        // ];
        // DB::table('question_bank_groups')->insert($groups);

        // // Subjects
        // $subjects = [
        //     [
        //         'class_id' => 1,
        //         'group_id' => 1,
        //         'name' => 'Physics',
        //         'status' => 1,
        //     ],
        //     [
        //         'class_id' => 2,
        //         'group_id' => 1,
        //         'name' => 'Chemistry',
        //         'status' => 1,
        //     ],
        // ];
        // DB::table('question_bank_subjects')->insert($subjects);

        // // Chapters
        // $chapters = [
        //     ['subject_id' => 1, 'name' => 'Chapter 1'],
        //     ['subject_id' => 1, 'name' => 'Chapter B'],
        //     ['subject_id' => 2, 'name' => 'Chapter A'],
        //     ['subject_id' => 2, 'name' => 'Chapter B'],
        // ];
        // DB::table('question_bank_chapters')->insert($chapters);

        // // Topics
        // $topics = [
        //     ['question_bank_chapter_id' => 1, 'name' => 'Topic 1'],
        //     ['question_bank_chapter_id' => 2, 'name' => 'Topic A'],
        // ];
        // DB::table('question_bank_topics')->insert($topics);

        // // Levels
        // $levels = [
        //     ['level_name' => 'Level 1'],
        //     ['level_name' => 'Level A'],
        // ];
        // DB::table('question_bank_levels')->insert($levels);

        // // Types
        // $types = [
        //     ['type_name' => 'MCQ'],
        //     ['type_name' => 'Short Answer'],
        // ];
        // DB::table('question_bank_types')->insert($types);

        // // Difficulty Level
        // $difficultyLevels = [
        //     ['level_name' => 'Easy'],
        //     ['level_name' => 'Medium'],
        //     ['level_name' => 'Hard'],
        //     ['level_name' => 'Extra Hard'],
        // ];
        // DB::table('question_bank_difficulty_levels')->insert($difficultyLevels);

        // // QuestionBank Tests
        // $questionBankTests = [
        //     ['test_name' => 'Quick Test'],
        //     ['test_name' => 'Mock Test'],
        //     ['test_name' => 'Question Bank'],
        // ];
        // DB::table('question_bank_tests')->insert($questionBankTests);

        // // Sources
        // $sources = [
        //     ['source_name' => 'Textbook'],
        //     ['source_name' => 'Model Test'],
        // ];
        // DB::table('question_bank_sources')->insert($sources);

        // // Sub Sources
        // $subSources = [
        //     ['source_id' => 1, 'sub_source_name' => 'NCTB Book'],
        //     ['source_id' => 2, 'sub_source_name' => 'Coaching Model Test'],
        // ];
        // DB::table('question_bank_sub_sources')->insert($subSources);

        // // Years
        // $years = [
        //     ['year' => 2024],
        //     ['year' => 2025],
        //     ['year' => 2026],
        //     ['year' => 2027],
        // ];
        // DB::table('question_bank_years')->insert($years);

        // // Tags
        // $tags = [
        //     ['tag_name' => 'ACAS QB'],
        //     ['tag_name' => 'Agri QB'],
        //     ['tag_name' => 'BBS QB'],
        //     ['tag_name' => 'BBS 2022'],
        //     ['tag_name' => 'BBS 2023'],
        // ];
        // DB::table('question_bank_tags')->insert($tags);

        // // Sessions
        // $sessions = [
        //     ['name' => '2021 - 2022'],
        //     ['name' => '2022 - 2023'],
        //     ['name' => '2023 - 2024'],
        //     ['name' => '2024 - 2025'],
        // ];
        // DB::table('question_bank_sessions')->insert($sessions);

        // // Years
        // $boards = [
        //     ['short_name' => 'MSB', 'board' => 'Mymensingh Board'],
        //     ['short_name' => 'DSB', 'board' => 'Dhaka Board'],
        // ];
        // DB::table('question_bank_boards')->insert($boards);

        // $this->call([
        //     QuestionCategoryTableSeeder::class,
        //     QuestionTableSeeder::class,
        //     QuizTableSeeder::class,
        // ]);
    }
}
