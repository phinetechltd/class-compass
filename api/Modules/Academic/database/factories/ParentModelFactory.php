<?php

namespace Modules\Academic\Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\Hash;
use Modules\Authentication\Models\User;
use Modules\ParentModule\Models\ParentModel;

class ParentModelFactory extends Factory
{
    protected $model = ParentModel::class;

    public function definition(): array
    {
        $faker = $this->faker;
        $name = $faker->name;

        // ✅ Create User first
        $user = User::factory()->create([
            'name' => $name,
            'email' => $faker->unique()->safeEmail,
            'phone' => $faker->unique()->phoneNumber,
            'password' => Hash::make('12345678'),
            'status' => 1,
            'user_type' => 'Parent',
            'role_id' => 8, // optional DB field
            'image' => $faker->numberBetween(1, 12).'.png',
        ]);

        // ✅ Assign Parent role properly
        $user->assignRole('Parent');

        // ✅ Return ParentModel attributes
        return [
            'user_id' => $user->id,
            'institute_id' => 1,
            'branch_id' => 1,
            'parent_name' => $name,
            'parent_profession' => $faker->jobTitle(),
            'parent_phone' => $faker->unique()->phoneNumber(),
            'present_address' => $faker->address(),
            'permanent_address' => $faker->address(),
            'access_key' => '12345678',
        ];
    }
}
