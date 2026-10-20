<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Modules\Authentication\Models\User;
use Modules\Gateways\Models\PaymentRequest;
use Modules\Gateways\Services\OnlineFeePaymentService;

/**
 * Fills the demo school with a realistic picture of a Kenyan CBC school, so visitors trying
 * the live demo (and the screenshots on the website) see real-looking numbers:
 * learners in every class from PP1 to Grade 9, teachers, six weeks of attendance,
 * termly fees and M-Pesa payments. Safe to run again: it only tops up what is missing.
 *
 *   php artisan classcompass:demo-school --institute=1 --branch=1
 */
class DemoSchoolCommand extends Command
{
    protected $signature = 'classcompass:demo-school {--institute=1} {--branch=1} {--per-class=18 : Learners per class}';

    protected $description = 'Fill the demo school with learners, teachers, attendance and fee payments';

    /** Seeded learners are "l<admission no>@demo..." (users.email is 40 characters). */
    private const DOMAIN = 'demo.classcompass.co.ke';

    /** Class => termly tuition (KES). */
    private const CLASSES = [
        'PP1' => 12000, 'PP2' => 12000,
        'Grade 1' => 15000, 'Grade 2' => 15000, 'Grade 3' => 15000,
        'Grade 4' => 18000, 'Grade 5' => 18000, 'Grade 6' => 18000,
        'Grade 7' => 15000, 'Grade 8' => 22000, 'Grade 9' => 22000,
    ];

    private const GIRLS = ['Wanjiru', 'Akinyi', 'Njeri', 'Achieng', 'Wambui', 'Atieno', 'Nyambura', 'Chebet', 'Mwende', 'Nafula', 'Wairimu', 'Adhiambo',
        'Kemunto', 'Jepkosgei', 'Muthoni', 'Nekesa', 'Zawadi', 'Imani', 'Neema', 'Faith', 'Mercy', 'Joy', 'Grace', 'Esther', 'Purity', 'Sharon', 'Abigail', 'Michelle'];

    private const BOYS = ['Kamau', 'Otieno', 'Kipchoge', 'Mwangi', 'Odhiambo', 'Kiprono', 'Njoroge', 'Ochieng', 'Mutua', 'Wafula', 'Kariuki', 'Omondi',
        'Kibet', 'Maina', 'Barasa', 'Nyamweya', 'Baraka', 'Brian', 'Kevin', 'Dennis', 'Victor', 'Collins', 'Emmanuel', 'Ian', 'Ryan', 'Jayden', 'Elvis', 'Tony'];

    private const SURNAMES = ['Kamau', 'Otieno', 'Wanjiku', 'Mwangi', 'Ochieng', 'Kiprotich', 'Njoroge', 'Odhiambo', 'Mutua', 'Wafula', 'Kariuki', 'Omondi',
        'Chepkoech', 'Maina', 'Barasa', 'Nyaga', 'Muriuki', 'Onyango', 'Kirui', 'Ndungu', 'Owino', 'Gitau', 'Langat', 'Okoth', 'Macharia', 'Simiyu', 'Ruto', 'Kimani'];

    private const TEACHERS = [
        ['Mary Wanjiku', 'Female', 'Head Teacher'], ['John Otieno', 'Male', 'Deputy Head Teacher'], ['Grace Achieng', 'Female', 'Senior Teacher – Junior School'],
        ['Peter Kiprono', 'Male', 'Mathematics Teacher'], ['Lucy Njeri', 'Female', 'English & Literature Teacher'], ['Samuel Mutua', 'Male', 'Integrated Science Teacher'],
        ['Faith Chebet', 'Female', 'Kiswahili Teacher'], ['David Ochieng', 'Male', 'Pre-Technical Studies Teacher'], ['Ann Wambui', 'Female', 'Pre-Primary Teacher'],
        ['James Mwangi', 'Male', 'Social Studies & CRE Teacher'], ['Esther Nafula', 'Female', 'Creative Arts & Music Teacher'], ['Brian Kibet', 'Male', 'Physical Education & Games'],
    ];

    public function handle(OnlineFeePaymentService $payments): int
    {
        $scope = ['institute_id' => (int) $this->option('institute'), 'branch_id' => (int) $this->option('branch')];
        $perClass = max(1, (int) $this->option('per-class'));
        $now = now();
        mt_srand(2026);

        $sessionId = (int) DB::table('settings')->where($scope + ['name' => 'academic_year'])->value('value') ?: 1;
        $categoryId = DB::table('student_categories')->where($scope)->value('id');
        $fundId = DB::table('accounting_funds')->where($scope)->value('id');
        $feeHeadId = DB::table('fee_heads')->where($scope + ['name' => 'Tuition Fees'])->value('id');
        $periodId = DB::table('periods')->where($scope)->orderBy('serial_no')->value('id');
        if (! $categoryId || ! $feeHeadId || ! $periodId) {
            $this->error('Run classcompass:kenya-demo first (it sets up CBC classes and the tuition fee head).');

            return self::FAILURE;
        }
        $role = fn (string $name) => DB::table('roles')->where('name', $name)->where('institute_id', $scope['institute_id'])->value('id')
            ?? DB::table('roles')->where('name', $name)->value('id');
        $studentRole = $role('Student');
        $teacherRole = $role('Teacher');
        $unusable = Hash::make(Str::random(40)); // demo learners and teachers do not log in

        // Teachers
        foreach (self::TEACHERS as $i => [$name, $gender, $designation]) {
            $email = Str::slug($name, '.').'@'.self::DOMAIN;
            if (DB::table('users')->where('email', $email)->exists()) {
                continue;
            }
            $phone = '2547'.str_pad((string) (11000000 + $i * 7919), 8, '0', STR_PAD_LEFT);
            $userId = DB::table('users')->insertGetId($scope + [
                'name' => $name, 'email' => $email, 'phone' => $phone, 'password' => $unusable, 'role_id' => $teacherRole,
                'user_type' => 'Teacher', 'status' => 1, 'user_status' => 1, 'platform' => 'WEB', 'email_verified_at' => $now,
                'created_at' => $now, 'updated_at' => $now,
            ]);
            DB::table('model_has_roles')->insertOrIgnore(['role_id' => $teacherRole, 'model_type' => User::class, 'model_id' => $userId]);
            DB::table('teachers')->insert($scope + [
                'user_id' => $userId, 'name' => $name, 'designation' => $designation, 'gender' => $gender, 'phone' => $phone,
                'nationality' => 'Kenyan', 'joining_date' => $now->copy()->subMonths(mt_rand(6, 60))->toDateString(),
                'status' => 1, 'is_visible_website' => 1, 'created_at' => $now, 'updated_at' => $now,
            ]);
        }

        // Learners, class by class
        $created = 0;
        $reg = (int) DB::table('students')->where($scope)->max('registration_no') ?: 2026000;
        foreach (self::CLASSES as $className => $fee) {
            $classId = DB::table('classes')->where($scope + ['class_name' => $className])->value('id');
            $sectionId = DB::table('sections')->where($scope + ['class_id' => $classId])->value('id');
            if (! $classId || ! $sectionId) {
                continue;
            }
            DB::table('fees')->updateOrInsert(
                $scope + ['session_id' => $sessionId, 'class_id' => $classId, 'section_id' => $sectionId, 'student_category_id' => $categoryId, 'fee_head_id' => $feeHeadId],
                ['fee_amount' => $fee, 'fine_amount' => 0, 'fund_id' => $fundId, 'created_at' => $now, 'updated_at' => $now]
            );
            $have = DB::table('student_sessions')->join('students', 'students.id', '=', 'student_sessions.student_id')->whereNull('students.deleted_at')
                ->where('student_sessions.institute_id', $scope['institute_id'])->where('student_sessions.class_id', $classId)->where('student_sessions.session_id', $sessionId)->count();
            for ($n = $have; $n < $perClass; $n++) {
                $girl = mt_rand(0, 1) === 1;
                $first = $girl ? self::GIRLS[array_rand(self::GIRLS)] : self::BOYS[array_rand(self::BOYS)];
                $last = self::SURNAMES[array_rand(self::SURNAMES)];
                $reg++;
                $email = "l{$reg}@".self::DOMAIN;
                $phone = '2547'.str_pad((string) (20000000 + $reg), 8, '0', STR_PAD_LEFT);
                $userId = DB::table('users')->insertGetId($scope + [
                    'name' => "$first $last", 'email' => $email, 'phone' => $phone, 'password' => $unusable, 'role_id' => $studentRole,
                    'user_type' => 'Student', 'status' => 1, 'user_status' => 1, 'platform' => 'WEB', 'email_verified_at' => $now,
                    'created_at' => $now, 'updated_at' => $now,
                ]);
                DB::table('model_has_roles')->insertOrIgnore(['role_id' => $studentRole, 'model_type' => User::class, 'model_id' => $userId]);
                $studentId = DB::table('students')->insertGetId($scope + [
                    'user_id' => $userId, 'student_category_id' => $categoryId, 'first_name' => $first, 'last_name' => $last,
                    'phone' => $phone, 'registration_no' => $reg, 'roll_no' => (string) ($n + 1), 'gender' => $girl ? 'Female' : 'Male',
                    'father_name' => (mt_rand(0, 1) ? self::BOYS[array_rand(self::BOYS)] : 'Mr.').' '.$last, 'mother_name' => self::GIRLS[array_rand(self::GIRLS)].' '.$last,
                    'country' => 'Kenya', 'nationality' => 'Kenyan', 'status' => 1,
                    'date_of_admission' => $now->copy()->subMonths(mt_rand(1, 40))->toDateString(), 'created_at' => $now, 'updated_at' => $now,
                ]);
                DB::table('student_sessions')->insert($scope + [
                    'student_id' => $studentId, 'session_id' => $sessionId, 'class_id' => $classId, 'section_id' => $sectionId,
                    'roll' => $n + 1, 'created_at' => $now, 'updated_at' => $now,
                ]);
                $created++;
            }
        }
        $this->info("Teachers: ".count(self::TEACHERS).", new learners: {$created}.");

        // Six weeks of attendance (period 1 is the daily register) — about 94% present.
        $learners = DB::table('student_sessions')->join('students', 'students.id', '=', 'student_sessions.student_id')
            ->where('student_sessions.institute_id', $scope['institute_id'])->where('student_sessions.branch_id', $scope['branch_id'])
            ->where('student_sessions.session_id', $sessionId)->whereNull('students.deleted_at')
            ->get(['student_sessions.student_id', 'student_sessions.class_id', 'student_sessions.section_id']);
        $rows = [];
        for ($day = now()->subWeeks(6)->startOfDay(); $day->lte(now()->startOfDay()); $day->addDay()) {
            if ($day->isWeekend()) {
                continue;
            }
            $date = $day->toDateString();
            $done = DB::table('student_attendances')->where($scope + ['period_id' => 1, 'date' => $date])->pluck('student_id')->flip();
            foreach ($learners as $l) {
                if (! isset($done[$l->student_id])) {
                    $rows[] = $scope + ['student_id' => $l->student_id, 'class_id' => $l->class_id, 'section_id' => $l->section_id, 'period_id' => 1,
                        'date' => $date, 'attendance' => mt_rand(1, 100) <= 94 ? 1 : 2, 'created_at' => $now, 'updated_at' => $now];
                }
            }
        }
        foreach (array_chunk($rows, 1000) as $chunk) {
            DB::table('student_attendances')->insert($chunk);
        }
        $this->info('Attendance rows added: '.count($rows).'.');

        // Term 1 fees: most families paid by M-Pesa, some part-paid, a few not yet.
        $payer = User::where('institute_id', $scope['institute_id'])->where('user_type', 'Super Admin')->first();
        $paid = 0;
        foreach (DB::table('students')->where('students.institute_id', $scope['institute_id'])->where('students.branch_id', $scope['branch_id'])->where('users.email', 'like', 'l%@'.self::DOMAIN)
            ->join('users', 'users.id', '=', 'students.user_id')->whereNotExists(fn ($q) => $q->from('student_collections')->whereColumn('student_collections.student_id', 'students.id'))
            ->select('students.id', 'students.first_name', 'students.last_name', 'students.phone')->get() as $s) {
            $roll = mt_rand(1, 100);
            if ($roll > 88) {
                continue; // not paid yet
            }
            $heads = $payments->unpaidFeeHeads($s->id);
            $termFee = isset($heads[0]) ? $heads[0]['fee_and_fine_payable'] / 3 : 0;
            if ($termFee <= 0 || ! $payer) {
                continue;
            }
            $amount = $roll <= 70 ? $termFee : round($termFee * mt_rand(3, 8) / 10, -2);
            $payment = PaymentRequest::create([
                'institute_id' => $scope['institute_id'], 'branch_id' => $scope['branch_id'], 'payment_amount' => $amount, 'currency_code' => 'KES',
                'payment_method' => 'mpesa', 'payment_type' => OnlineFeePaymentService::TYPE, 'attribute_id' => (string) $s->id, 'attribute' => 'student',
                'payment_platform' => 'web', 'payer_information' => ['name' => "{$s->first_name} {$s->last_name}", 'phone' => $s->phone],
                'additional_data' => json_encode(['status' => 'pending', 'payer_user_id' => $payer->id, 'fee_heads' => $heads]),
            ]);
            $payments->confirm($payment->id, $amount, strtoupper(Str::random(2)).mt_rand(10, 99).strtoupper(Str::random(6)), ['phone' => $s->phone]);
            $paid++;
        }
        $this->info("Fee payments posted: {$paid}.");

        return self::SUCCESS;
    }
}
