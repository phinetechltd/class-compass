<?php

namespace Modules\Academic\Database\Seeders;

use Illuminate\Database\Seeder;

class AcademicDatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $this->call([
            AcademicConfigurationSeeder::class,
            ShiftTableSeeder::class,
            PicklistSeeder::class,
            DepartmentSeeder::class,
            StudentCategoryTableSeeder::class,
            LeaveTypeSeeder::class,
        ]);
    }
}
