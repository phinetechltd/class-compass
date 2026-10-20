<?php

namespace Modules\Academic\Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\Hash;
use Modules\Academic\Models\Teacher;
use Modules\Authentication\Models\User;

class TeacherFactory extends Factory
{
    protected $model = Teacher::class;

    public function definition()
    {
        $faker = $this->faker;
        $name = $faker->name;
        $gender = $faker->randomElement(['men', 'women']);
        $genderLabel = $gender === 'men' ? 'Male' : 'Female';

        // ✅ Create User first
        $user = User::factory()->create([
            'name' => $name,
            'email' => $faker->unique()->safeEmail,
            'phone' => $faker->unique()->phoneNumber,
            'password' => Hash::make('12345678'),
            'role_id' => 6, // Teacher Role Assign
            'status' => 1,
            'user_type' => 'Teacher',
            'image' => $faker->numberBetween(1, 12).'.png',
        ]);

        // ✅ Assign Role properly
        $user->assignRole('Teacher'); // you can also use $role->id

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
            'address' => $faker->address(),
            'access_key' => '12345678',
            'joining_date' => $faker->date(),
            'status' => '1',
        ];
    }
}
