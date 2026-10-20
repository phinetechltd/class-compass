<?php

namespace App\Console\Commands;

use App\Services\CurriculumService;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

/**
 * Seeds a Kenyan demo into an existing institute: CBC classes, termly fees in KES,
 * a Grade 7 learner and a parent account (for trying M-Pesa / Paystack fee payments).
 *
 *   php artisan classcompass:kenya-demo --institute=1 --branch=1
 */
class KenyaDemoCommand extends Command
{
    protected $signature = 'classcompass:kenya-demo {--institute=1} {--branch=1} {--password= : Password for the demo parent and learner (random if empty)}';

    protected $description = 'Seed Kenyan demo data (CBC, KES fees, learner + parent) into an institute';

    public function handle(CurriculumService $curriculum): int
    {
        $instituteId = (int) $this->option('institute');
        $branchId = (int) $this->option('branch');
        $scope = ['institute_id' => $instituteId, 'branch_id' => $branchId];
        $now = now();
        $password = $this->option('password') ?: Str::password(12, symbols: false);

        $curriculum->apply($instituteId, $branchId, 'cbc');

        DB::transaction(function () use ($scope, $now, $password) {
            // Kenyan defaults for the school settings.
            foreach (['currency_symbol' => 'KSh', 'currency_code' => 'KES', 'timezone' => 'Africa/Nairobi'] as $name => $value) {
                DB::table('settings')->updateOrInsert($scope + ['name' => $name], ['value' => $value, 'type' => 'general', 'updated_at' => $now]);
            }

            $sessionId = (int) DB::table('settings')->where($scope + ['name' => 'academic_year'])->value('value') ?: 1;
            $classId = DB::table('classes')->where($scope + ['class_name' => 'Grade 7'])->value('id');
            $sectionId = DB::table('sections')->where($scope + ['class_id' => $classId])->value('id');
            $categoryId = DB::table('student_categories')->where($scope)->value('id')
                ?? DB::table('student_categories')->insertGetId($scope + ['name' => 'General', 'created_at' => $now, 'updated_at' => $now]);
            $fundId = DB::table('accounting_funds')->where($scope)->value('id');
            $ledgerId = DB::table('accounting_ledgers')->where($scope)->where('accounting_category_id', 5)->value('id');

            // Tuition fee head with one sub head per term.
            $feeHeadId = DB::table('fee_heads')->where($scope + ['name' => 'Tuition Fees'])->value('id')
                ?? DB::table('fee_heads')->insertGetId($scope + ['name' => 'Tuition Fees', 'serial' => 1, 'created_at' => $now, 'updated_at' => $now]);
            $feeMapId = DB::table('fee_maps')->where($scope + ['fee_head_id' => $feeHeadId])->value('id')
                ?? DB::table('fee_maps')->insertGetId($scope + ['fee_head_id' => $feeHeadId, 'ledger_id' => $ledgerId, 'fund' => $fundId, 'created_at' => $now, 'updated_at' => $now]);
            foreach (['Term 1', 'Term 2', 'Term 3'] as $i => $term) {
                $subHeadId = DB::table('fee_sub_heads')->where($scope + ['fee_head_id' => $feeHeadId, 'name' => $term])->value('id')
                    ?? DB::table('fee_sub_heads')->insertGetId($scope + ['fee_head_id' => $feeHeadId, 'name' => $term, 'serial' => $i + 1, 'created_at' => $now, 'updated_at' => $now]);
                DB::table('fee_map_fee_sub_head')->updateOrInsert(
                    ['fee_map_id' => $feeMapId, 'fee_head_id' => $feeHeadId, 'fee_sub_head_id' => $subHeadId],
                    ['created_at' => $now, 'updated_at' => $now]
                );
            }
            DB::table('fees')->updateOrInsert(
                $scope + ['session_id' => $sessionId, 'class_id' => $classId, 'section_id' => $sectionId, 'student_category_id' => $categoryId, 'fee_head_id' => $feeHeadId],
                ['fee_amount' => 15000, 'fine_amount' => 0, 'fund_id' => $fundId, 'created_at' => $now, 'updated_at' => $now]
            );

            // Learner
            $learnerUserId = DB::table('users')->whereIn('email', ['learner@classcompass.test', 'learner@demo.classcompass.co.ke'])->value('id')
                ?? DB::table('users')->insertGetId($scope + [
                    'name' => 'Wanjiku Kamau', 'email' => 'learner@classcompass.test', 'phone' => '254700000101',
                    'password' => Hash::make($password), 'role_id' => 7, 'user_type' => 'Student', 'status' => 1,
                    'email_verified_at' => $now, 'created_at' => $now, 'updated_at' => $now,
                ]);
            $studentId = DB::table('students')->where('user_id', $learnerUserId)->value('id')
                ?? DB::table('students')->insertGetId($scope + [
                    'user_id' => $learnerUserId, 'student_category_id' => $categoryId, 'first_name' => 'Wanjiku', 'last_name' => 'Kamau',
                    'phone' => '254700000101', 'registration_no' => 2026001, 'roll_no' => '1', 'gender' => 'Female',
                    'father_name' => 'Peter Kamau', 'mother_name' => 'Grace Kamau', 'country' => 'Kenya', 'nationality' => 'Kenyan',
                    'status' => 1, 'date_of_admission' => $now->toDateString(), 'created_at' => $now, 'updated_at' => $now,
                ]);
            DB::table('student_sessions')->updateOrInsert(
                $scope + ['student_id' => $studentId, 'session_id' => $sessionId],
                ['class_id' => $classId, 'section_id' => $sectionId, 'roll' => 1, 'created_at' => $now, 'updated_at' => $now]
            );

            // Parent
            $parentUserId = DB::table('users')->whereIn('email', ['parent@classcompass.test', 'parent@demo.classcompass.co.ke'])->value('id')
                ?? DB::table('users')->insertGetId($scope + [
                    'name' => 'Peter Kamau', 'email' => 'parent@classcompass.test', 'phone' => '254700000102',
                    'password' => Hash::make($password), 'role_id' => 8, 'user_type' => 'Parent', 'status' => 1,
                    'email_verified_at' => $now, 'created_at' => $now, 'updated_at' => $now,
                ]);
            DB::table('parent_models')->updateOrInsert(
                $scope + ['user_id' => $parentUserId, 'student_id' => $studentId],
                ['parent_name' => 'Peter Kamau', 'parent_phone' => '254700000102', 'status' => 1, 'created_at' => $now, 'updated_at' => $now]
            );
            $parentModelId = DB::table('parent_models')->where('user_id', $parentUserId)->value('id');
            DB::table('students')->where('id', $studentId)->update(['parent_id' => $parentModelId]);
            DB::table('users')->whereIn('id', [$learnerUserId, $parentUserId])->update(['password' => Hash::make($password)]);

            foreach ([[$learnerUserId, 'Student'], [$parentUserId, 'Parent']] as [$userId, $roleName]) {
                $roleId = DB::table('roles')->where('name', $roleName)->value('id');
                DB::table('model_has_roles')->updateOrInsert(['role_id' => $roleId, 'model_type' => 'Modules\\Authentication\\Models\\User', 'model_id' => $userId]);
            }
        });

        $this->seedActivity($scope);

        $this->info('Kenya demo ready: CBC classes, Tuition Fees KSh 15,000 per term for Grade 7.');
        $this->line('Parent:  parent@classcompass.test');
        $this->line('Learner: learner@classcompass.test');
        $this->line("Password: {$password}");

        return self::SUCCESS;
    }

    /**
     * Gives the demo learner some history so the parent portal has something to show:
     * six weeks of attendance (a few absences) and a Term 1 fee payment by M-Pesa.
     */
    private function seedActivity(array $scope): void
    {
        $studentId = DB::table('students')->where('user_id', DB::table('users')->whereIn('email', ['learner@classcompass.test', 'learner@demo.classcompass.co.ke'])->value('id'))->value('id');
        $session = DB::table('student_sessions')->where('student_id', $studentId)->first();
        $periodId = DB::table('periods')->where($scope)->orderBy('serial_no')->value('id');
        if (! $studentId || ! $session || ! $periodId) {
            return;
        }

        $absent = [4, 13, 22];
        $day = now()->subWeeks(6)->startOfDay();
        for ($i = 0; $day->lt(now()->startOfDay()); $day->addDay()) {
            if ($day->isWeekend()) {
                continue;
            }
            // Attendance percentages are read from period 1 (see ParentModuleController).
            DB::table('student_attendances')->updateOrInsert(
                $scope + ['student_id' => $studentId, 'period_id' => 1, 'date' => $day->toDateString()],
                ['class_id' => $session->class_id, 'section_id' => $session->section_id,
                    'attendance' => in_array($i++, $absent, true) ? 2 : 1, 'created_at' => now(), 'updated_at' => now()]);
        }

        if (DB::table('student_collections')->where('student_id', $studentId)->exists()) {
            return;
        }
        $parent = \Modules\Authentication\Models\User::whereIn('email', ['parent@classcompass.test', 'parent@demo.classcompass.co.ke'])->first();
        $service = app(\Modules\Gateways\Services\OnlineFeePaymentService::class);
        $payment = \Modules\Gateways\Models\PaymentRequest::create([
            'institute_id' => $scope['institute_id'],
            'branch_id' => $scope['branch_id'],
            'payment_amount' => 15000,
            'currency_code' => 'KES',
            'payment_method' => 'mpesa',
            'payment_type' => \Modules\Gateways\Services\OnlineFeePaymentService::TYPE,
            'attribute_id' => (string) $studentId,
            'attribute' => 'student',
            'payment_platform' => 'web',
            'payer_information' => ['name' => $parent->name, 'email' => $parent->email, 'phone' => '254712345678'],
            'additional_data' => json_encode(['status' => 'pending', 'payer_user_id' => $parent->id, 'fee_heads' => $service->unpaidFeeHeads($studentId)]),
        ]);
        $service->confirm($payment->id, 15000, 'DEMO'.strtoupper(Str::random(6)), ['phone' => '254712345678']);
    }
}
