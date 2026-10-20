<?php

namespace Modules\Academic\Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\Hash;
use Modules\Academic\Models\Staff;
use Modules\Authentication\Models\User;

class StaffFactory extends Factory
{
    protected $model = Staff::class;

    public function definition(): array
    {
        $faker = $this->faker;
        $name = $faker->name;
        $genderSlug = $faker->randomElement(['men', 'women']);
        $genderLabel = $genderSlug === 'men' ? 'Male' : 'Female';

        // ✅ Create User first
        $user = User::factory()->create([
            'name' => $name,
            'email' => $faker->unique()->safeEmail,
            'phone' => $faker->unique()->phoneNumber,
            'password' => Hash::make('12345678'),
            'role_id' => 3, // Staff role id (or adjust dynamically)
            'status' => 1,
            'user_type' => 'Staff',
            'image' => $faker->numberBetween(1, 12).'.png',
        ]);

        // ✅ Assign Role properly
        $user->assignRole('System Admin'); // you can also use $role->id

        // ✅ Return staff attributes
        return [
            'user_id' => $user->id,
            'institute_id' => 1,
            'branch_id' => 1,
            'department_id' => $faker->numberBetween(1, 10),
            'name' => $name,
            'designation' => $faker->jobTitle(),
            'birthday' => $faker->date('Y-m-d', '2000-01-01'),
            'gender' => $genderLabel,
            'religion' => $faker->randomElement(['Islam', 'Christianity', 'Hinduism', 'Other']),
            'phone' => $faker->unique()->phoneNumber(),
            'blood' => $faker->randomElement(['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']),
            'sl' => $faker->numberBetween(1, 100),
            'address' => $faker->address(),
            'joining_date' => $faker->date(),
            'access_key' => '12345678',
            'status' => 1,
        ];
    }
}
