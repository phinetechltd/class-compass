<?php

namespace Modules\Elearning\Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;
use Modules\Academic\Models\Student;
use Modules\Authentication\Models\Institute;
use Modules\Authentication\Models\User;

class StudentFactory extends Factory
{
    protected $model = Student::class;

    /**
     * Define the model's default state.
     */
    public function definition(): array
    {
        // Create user data
        $userData = [
            'institute_id' => Institute::first()->id,
            'first_name' => $this->faker->firstName,
            'last_name' => $this->faker->lastName,
            'phone' => $this->faker->phoneNumber,
            'email' => $this->faker->unique()->safeEmail,
            'avatar' => 'https://i.ibb.co.com/WvvdDbkp/profile-picture-male-female-face-silhouettes-icons-serving-as-avatars-profile-icon-vector-1059745-43.jpg',
            'role_id' => 3,
            'password' => bcrypt('123456'),
            'user_type' => 'Student',
        ];

        // Create the user and associate it with the student
        $user = User::create($userData);

        return [
            'institute_id' => Institute::first()->id,
            'first_name' => $this->faker->firstName,
            'last_name' => $this->faker->lastName,
            'gender' => $this->faker->randomElement(['Male', 'Female', 'Other']),
            'date_of_birth' => $this->faker->date(),
            'religion' => 'Islam',
            'caste' => 'General',
            'blood_group' => $this->faker->randomElement(['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']),
            'address' => $this->faker->address,
            'phone' => $this->faker->phoneNumber,
            'email' => $this->faker->unique()->safeEmail,
            'admission_date' => $this->faker->date(),
            'admission_number' => Str::random(10),
            'image' => 'https://i.ibb.co.com/WvvdDbkp/profile-picture-male-female-face-silhouettes-icons-serving-as-avatars-profile-icon-vector-1059745-43.jpg',
            'father_name' => $this->faker->firstName,
            'father_phone' => $this->faker->phoneNumber,
            'father_occupation' => 'Business',
            'mother_name' => $this->faker->firstName,
            'mother_phone' => $this->faker->phoneNumber,
            'mother_occupation' => 'Housewife',
            'parent_id_proof' => null,
            'disallow_login' => false,
            'user_status' => 'New User',
            'status' => true,
            'user_id' => $user->id, // Assign the user ID
        ];
    }
}
