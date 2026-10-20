<?php

namespace Modules\QuestionBank\Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class QuestionCategoryTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $categories = [
            ['name' => 'Mathematics', 'description' => 'Math-related questions'],
            ['name' => 'Science', 'description' => 'Physics, Chemistry, and Biology'],
            ['name' => 'History', 'description' => 'Historical events and figures'],
            ['name' => 'Geography', 'description' => 'World geography and locations'],
            ['name' => 'English Grammar', 'description' => 'Grammar and literature questions'],
            ['name' => 'Programming', 'description' => 'Coding and software development'],
            ['name' => 'General Knowledge', 'description' => 'Miscellaneous knowledge-based questions'],
        ];

        foreach ($categories as $category) {
            DB::table('question_categories')->insert([
                'institute_id' => 1,
                'name' => $category['name'],
                'description' => $category['description'],
                'created_at' => Carbon::now(),
                'updated_at' => Carbon::now(),
            ]);
        }
    }
}
