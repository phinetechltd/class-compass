<?php

namespace Modules\Finance\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class WaiverTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('waivers')->insert([
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'serial' => 1,
                'waiver' => 'Class Waiver',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'serial' => 2,
                'waiver' => 'Girl Waiver',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'serial' => 3,
                'waiver' => 'Merit Waiver',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'serial' => 3,
                'waiver' => 'Poor Waiver',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'serial' => 4,
                'waiver' => 'Scout Waiver',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'serial' => 5,
                'waiver' => 'BNCC Waiver',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'serial' => 6,
                'waiver' => 'Special Waiver',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'serial' => 7,
                'waiver' => 'Govt. Waiver',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'serial' => 8,
                'waiver' => 'Invention Waiver',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'serial' => 9,
                'waiver' => 'Creative Waiver',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'serial' => 10,
                'waiver' => 'Other Waiver',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
