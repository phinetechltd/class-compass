<?php

namespace Modules\Academic\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class AcademicConfigurationSeeder extends Seeder
{
    public function run(): void
    {
        $instituteId = 1;
        $branchId = 1;

        /*
        |--------------------------------------------------------------------------
        | Student Groups
        |--------------------------------------------------------------------------
        */
        $scienceGroupId = DB::table('student_groups')->insertGetId([
            'institute_id' => $instituteId,
            'branch_id' => $branchId,
            'group_name' => 'Science',
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        $artsGroupId = DB::table('student_groups')->insertGetId([
            'institute_id' => $instituteId,
            'branch_id' => $branchId,
            'group_name' => 'Arts',
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        /*
        |--------------------------------------------------------------------------
        | Classes
        |--------------------------------------------------------------------------
        */
        $classOneId = DB::table('classes')->insertGetId([
            'institute_id' => $instituteId,
            'branch_id' => $branchId,
            'class_name' => 'Class 1',
            'status' => 1,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        $classTwoId = DB::table('classes')->insertGetId([
            'institute_id' => $instituteId,
            'branch_id' => $branchId,
            'class_name' => 'Class 2',
            'status' => 1,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        /*
        |--------------------------------------------------------------------------
        | Sections
        |--------------------------------------------------------------------------
        */
        DB::table('sections')->insert([
            [
                'institute_id' => $instituteId,
                'branch_id' => $branchId,
                'class_id' => $classOneId,
                'student_group_id' => $scienceGroupId,
                'section_name' => 'A',
                'room_no' => '101',
                'status' => 1,
                'capacity' => 40,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => $instituteId,
                'branch_id' => $branchId,
                'class_id' => $classTwoId,
                'student_group_id' => $artsGroupId,
                'section_name' => 'B',
                'room_no' => '102',
                'status' => 1,
                'capacity' => 35,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);

        /*
        |--------------------------------------------------------------------------
        | Subjects
        |--------------------------------------------------------------------------
        */
        DB::table('subjects')->insert([
            [
                'institute_id' => $instituteId,
                'branch_id' => $branchId,
                'subject_name' => 'Bangla',
                'subject_code' => 'BAN101',
                'subject_short_form' => 'BAN',
                'class_id' => $classOneId,
                'group_id' => null,
                'full_mark' => 100,
                'pass_mark' => 33,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => $instituteId,
                'branch_id' => $branchId,
                'subject_name' => 'English',
                'subject_code' => 'ENG101',
                'subject_short_form' => 'ENG',
                'class_id' => $classOneId,
                'group_id' => null,
                'full_mark' => 100,
                'pass_mark' => 33,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);

        /*
        |--------------------------------------------------------------------------
        | Periods (Unique Per Institute + Branch)
        |--------------------------------------------------------------------------
        */
        DB::table('periods')->insert([
            [
                'institute_id' => $instituteId,
                'branch_id' => $branchId,
                'serial_no' => 1,
                'period' => '1st Period',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'institute_id' => $instituteId,
                'branch_id' => $branchId,
                'serial_no' => 2,
                'period' => '2nd Period',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
