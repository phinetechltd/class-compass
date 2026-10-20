<?php

namespace Modules\Authentication\Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class InstituteTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('institutes')->insert([
            [
                // 'owner_id' => 1,
                // 'assigned_to' => 1,
                'name' => 'Demo Institute',
                'address' => '123 Main Street, City',
                'institute_type' => 'School',
                'phone' => '1234567890',
                'domain' => 'institute1.com',
                'platform' => 'WEB',
                'status' => 1,
                'created_at' => Carbon::now(),
                'updated_at' => Carbon::now(),
            ],
        ]);

        DB::table('branches')->insert([
            [
                'institute_id' => 1,
                'name' => 'Demo school',
                'status' => 1,
                'created_at' => Carbon::now(),
                'updated_at' => Carbon::now(),
            ],
            [
                'institute_id' => 1,
                'name' => 'Demo institute',
                'status' => 1,
                'created_at' => Carbon::now(),
                'updated_at' => Carbon::now(),
            ],
        ]);
    }
}
