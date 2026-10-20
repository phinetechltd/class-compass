<?php

namespace Modules\Payroll\Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Modules\Academic\Models\Staff;
use Modules\Academic\Models\Teacher;
use Modules\Authentication\Models\User;
use Modules\Payroll\Models\SalaryHead;
use Modules\Payroll\Models\SalaryHeadUserPayroll;
use Modules\Payroll\Models\UserPayroll;
use Spatie\Permission\Models\Role;

class SalaryHeadSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Default salary_heads
        DB::table('salary_heads')->insert([
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Basic',
                'type' => 'Addition',
                'created_at' => now(),
                'updated_at' => now(),
            ],

            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Allowance',
                'type' => 'Addition',
                'created_at' => now(),
                'updated_at' => now(),
            ],

            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Early Leave Fine',
                'type' => 'Deduction',
                'created_at' => now(),
                'updated_at' => now(),
            ],

            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Festival Allowance',
                'type' => 'Addition',
                'created_at' => now(),
                'updated_at' => now(),
            ],

            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Welfare Fund',
                'type' => 'Deduction',
                'created_at' => now(),
                'updated_at' => now(),
            ],

            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Professional Tax',
                'type' => 'Deduction',
                'created_at' => now(),
                'updated_at' => now(),
            ],

            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Conveyance',
                'type' => 'Addition',
                'created_at' => now(),
                'updated_at' => now(),
            ],

            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Exam Hall Duty',
                'type' => 'Addition',
                'created_at' => now(),
                'updated_at' => now(),
            ],

            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Incentive',
                'type' => 'Addition',
                'created_at' => now(),
                'updated_at' => now(),
            ],

            [
                'institute_id' => 1,
                'branch_id' => 1,
                'name' => 'Medical',
                'type' => 'Addition',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);

        $this->createUser('Accountant', 'Accountant', 'accountant@gmail.com', '000000000004', '12345678', 'Accountant');
        $this->createUser('Librarian', 'Librarian', 'librarian@gmail.com', '000000000005', '12345678', 'Librarian');
        $this->createUser('Hostel', 'Hostel', 'hostel@gmail.com', '000000000006', '12345678', 'Hostel');
        $this->createUser('Transport', 'Transport', 'transport@gmail.com', '000000000007', '12345678', 'Transport');

        // Fetch all staff data
        $staffData = Staff::get();
        foreach ($staffData as $staff) {
            if ($staff) {
                // Create a new UserPayroll for the staff
                $userPayroll = new UserPayroll([
                    'institute_id' => 1,
                    'branch_id' => 1,
                    'user_id' => $staff->user_id,
                    'net_salary' => 1000,
                    'current_due' => 0,
                    'current_advance' => 0,
                ]);
                $userPayroll->save();

                // Fetch salary heads
                $salaryHeads = SalaryHead::get();

                // Link salary heads to the user payroll
                foreach ($salaryHeads as $salaryHead) {
                    $salaryHeadUserPayroll = new SalaryHeadUserPayroll([
                        'institute_id' => 1,
                        'branch_id' => 1,
                        'user_payroll_id' => $userPayroll->id,
                        'salary_head_id' => $salaryHead->id,
                        'amount' => 10,
                    ]);
                    $salaryHeadUserPayroll->save();
                }
            }
        }

        // Fetch all teacher data
        $teacherData = Teacher::get();
        foreach ($teacherData as $teacher) {
            if ($teacher) {
                // Create a new UserPayroll for the teacher
                $userPayroll = new UserPayroll([
                    'institute_id' => 1,
                    'branch_id' => 1,
                    'user_id' => $teacher->user_id,
                    'net_salary' => 1000,
                    'current_due' => 0,
                    'current_advance' => 0,
                ]);
                $userPayroll->save();

                // Fetch salary heads
                $salaryHeads = SalaryHead::get();

                // Link salary heads to the user payroll
                foreach ($salaryHeads as $salaryHead) {
                    $salaryHeadUserPayroll = new SalaryHeadUserPayroll([
                        'institute_id' => 1,
                        'branch_id' => 1,
                        'user_payroll_id' => $userPayroll->id,
                        'salary_head_id' => $salaryHead->id,
                        'amount' => 10,
                    ]);
                    $salaryHeadUserPayroll->save();
                }
            }
        }
    }

    public function createUser($role, string $name, string $email, string $phone, string $password, $type)
    {
        $role = Role::where('name', $role)->first();
        $user = User::factory([
            'institute_id' => 1,
            'branch_id' => 1,
            'name' => $name,
            'email' => $email,
            'password' => Hash::make($password),
            'phone' => $phone,
            'user_type' => $type,
            'role_id' => $role->id,
            'remember_token' => Str::random(10),
            'platform' => 'WEB',
            'email_verified_at' => Carbon::now(),
            'last_active_time' => Carbon::now(),
            'status' => 1,
            'user_status' => 1,
            'image' => '5.png',
        ])->create();

        /* Get all the permission and assign admin role */
        $user->assignRole([$role->id]);

        // If this user belongs to staff category, create Staff record
        $staffRoles = ['Accountant', 'Librarian', 'Hostel', 'Transport']; // staff-based roles

        if (in_array($type, $staffRoles)) {
            Staff::updateOrCreate(
                ['user_id' => $user->id],
                [
                    'institute_id' => 1,
                    'branch_id' => 1,
                    'department_id' => 1,
                    'name' => $user->name,
                    'phone' => $user->phone,
                    'designation' => $type,
                    'status' => 1,
                ]
            );
        }
    }
}
