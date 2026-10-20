<?php

namespace Modules\Academic\Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\Hash;
use Modules\Academic\Models\Student;
use Modules\Authentication\Models\User;

class StudentFactory extends Factory
{
    protected $model = Student::class;

    public function definition()
    {
        $faker = $this->faker;
        $name = $faker->name;
        $gender = $faker->randomElement(['men', 'women']);

        // ✅ Create user first
        $user = User::factory()->create([
            'name' => $name,
            'email' => $faker->unique()->safeEmail,
            'phone' => $faker->unique()->phoneNumber,
            'password' => Hash::make('12345678'),
            'role_id' => 7, // Optional: for your DB column
            'status' => 1,
            'user_type' => 'Student',
            'email_verified_at' => now(),
            'image' => $faker->numberBetween(1, 12).'.png',
        ]);

        // ✅ Assign Student role properly via spatie/laravel-permission
        $user->assignRole('Student');

        return [
            'user_id' => $user->id,

            // Foreign keys
            'institute_id' => 1,
            'branch_id' => 1,
            'parent_id' => $faker->numberBetween(1, 10),

            // Basic info
            'first_name' => $faker->firstName,
            'last_name' => $faker->lastName,
            'phone' => $faker->unique()->phoneNumber,
            'gender' => $gender === 'men' ? 'Male' : 'Female',
            'birthday' => $faker->date('Y-m-d', '-18 years'),
            'blood_group' => $faker->randomElement(['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']),
            'religion' => $faker->randomElement(['Islam', 'Christianity', 'Hinduism', 'Buddhism', 'Other']),
            'birth_certificate_no' => $faker->unique()->numerify('BC#######'),
            'nid_no' => $faker->unique()->numerify('NID#########'),
            'application_number' => $faker->unique()->numerify('APP#####'),
            'date_of_admission' => $faker->date('Y-m-d', 'now'),
            'admission_place' => $faker->city,
            'serial_no' => $faker->unique()->numberBetween(1000, 9999),
            'roll_no' => $faker->numberBetween(1, 200),
            'registration_no' => $faker->unique()->numberBetween(1000, 9999),
            'class_id' => $faker->numberBetween(1, 12),
            'session_id' => '2023-2024',
            'group' => $faker->randomElement(['Science', 'Commerce', 'Arts']),
            'section_id' => $faker->randomLetter,
            'student_category_id' => $faker->numberBetween(1, 5),
            'address' => $faker->address,

            // General Info
            'state' => $faker->state,
            'country' => 'Bangladesh',
            'activities' => $faker->word,
            'access_key' => '12345678',
            'nationality' => 'Bangladeshi',
            'tc_date' => $faker->optional()->date(),

            // Status
            'status' => '1',

            'created_at' => now(),
            'updated_at' => now(),
            'deleted_at' => null,
        ];
    }
}
