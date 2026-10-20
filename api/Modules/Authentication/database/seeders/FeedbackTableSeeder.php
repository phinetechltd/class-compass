<?php

namespace Modules\Authentication\Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Modules\Authentication\Models\Feedback;

class FeedbackTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Feedback::create([
            'user_id' => 1,
            'description' => 'I love learning here! The teachers are supportive, and the activities are fun.',
            'status' => 1,
            'created_at' => Carbon::now(),
            'updated_at' => Carbon::now(),
        ]);

        Feedback::create([
            'user_id' => 2,
            'description' => 'A great place to teach! The school values both students and educators.',
            'status' => 1,
            'created_at' => Carbon::now(),
            'updated_at' => Carbon::now(),
        ]);

        Feedback::create([
            'user_id' => 3,
            'description' => 'The best decision for my child! Excellent education and communication.',
            'status' => 1,
            'created_at' => Carbon::now(),
            'updated_at' => Carbon::now(),
        ]);
    }
}
