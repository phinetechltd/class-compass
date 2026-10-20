<?php

namespace Modules\Frontend\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\Frontend\Models\OurHistory;

class OurHistorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        OurHistory::insert([
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'year' => 1972,
                'title' => 'Mere tranquil existence',
                'descriptions' => 'Possession of my entire soul, like these sweet mornings of spring which I enjoy with my whole heart am alone',
            ],
        ]);
    }
}
