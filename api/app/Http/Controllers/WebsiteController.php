<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Modules\Academic\Models\Event;
use Modules\Academic\Models\Notice;
use Modules\Academic\Models\Signature;
use Modules\Academic\Models\Staff;
use Modules\Academic\Models\Student;
use Modules\Academic\Models\Subject;
use Modules\Academic\Models\Teacher;
use Modules\Academic\Services\StudentService;
use Modules\Authentication\Models\Institute;
use Modules\Elearning\Models\Course;
use Modules\Examination\Models\ClassExam;
use Modules\Frontend\Models\AboutUs;
use Modules\Frontend\Models\AcademicImage;
use Modules\Frontend\Models\Banner;
use Modules\Frontend\Models\FaqQuestion;
use Modules\Frontend\Models\MobileAppSection;
use Modules\Frontend\Models\OurHistory;
use Modules\Frontend\Models\ReadyToJoinUs;
use Modules\Frontend\Models\Testimonial;
use Modules\Frontend\Models\WhyChooseUs;
use Modules\SystemConfiguration\Models\Setting;

class WebsiteController extends Controller
{
    public function __construct(
        private readonly StudentService $studentService,
    ) {}

    public function saasLandingPage(Request $request)
    {
        return view('saas-landing-page');
    }

    public function index(Request $request)
    {
        /*
        ============================================
        1. Detect Host / Domain
        ============================================
        */

        $host = $request->getHost();
        // example: school1.com

        /*
        ============================================
        2. Find Institute by Domain
        ============================================
        */

        $institute = Institute::where('domain', $host)
            ->where('status', 1)
            ->first();

        if (! $institute) {
            // Not a school's own domain: show the Class Compass product site.
            return response()->view('saas-landing-page');
        }

        try {
            $instituteId = $institute->id;

            /*
        ============================================
        3. Load Settings (Theme + Info)
        ============================================
        */

            $allowedKeys = [
                'school_name',
                'site_title',
                'phone',
                'email',
                'address',
                'logo',
                'copyright_text',
                'facebook_link',
                'youtube_link',
                'whats_app_link',
                'primary_color',
                'secondary_color',
                'text_color',
            ];

            $settings = DB::table('settings')
                ->whereIn('name', $allowedKeys)
                ->where('institute_id', $instituteId)
                ->pluck('value', 'name');

            /*
        ============================================
        4. Fetch Homepage Data
        ============================================
        */

            $data = [];

            $data['banners'] = Banner::where('institute_id', $instituteId)
                ->whereNull('deleted_at')
                ->get();

            $data['about'] = AboutUs::where('institute_id', $instituteId)
                ->where('status', 1)
                ->first();

            $data['academicImages'] = AcademicImage::where(
                'institute_id',
                $instituteId
            )->get();

            $data['whyChooseUs'] = WhyChooseUs::where(
                'institute_id',
                $instituteId
            )->get();

            $data['readyToJoinUs'] = ReadyToJoinUs::where(
                'institute_id',
                $instituteId
            )->get();

            $data['teachers'] = Teacher::with('user')
                ->where('institute_id', $instituteId)
                ->where('status', 1)
                ->limit(8)
                ->get();

            $data['events'] = Event::where(
                'institute_id',
                $instituteId
            )
                ->latest()
                ->limit(5)
                ->get();

            $data['notices'] = Notice::where(
                'institute_id',
                $instituteId
            )
                ->latest()
                ->limit(5)
                ->get();

            $data['faqs'] = FaqQuestion::where(
                'institute_id',
                $instituteId
            )->get();

            $data['history'] = OurHistory::where(
                'institute_id',
                $instituteId
            )->first();

            $data['testimonials'] = Testimonial::with('user')
                ->where('institute_id', $instituteId)
                ->get();

            $data['mobileAppSections'] = MobileAppSection::where(
                'institute_id',
                $instituteId
            )->get();

            $data['courses'] = Course::where(
                'institute_id',
                $instituteId
            )
                ->where('status', 1)
                ->limit(6)
                ->get();

            /*
        ============================================
        5. Pass to Blade
        ============================================
        */

            if ($institute->theme_id == 1) {
                return view('theme-01', [
                    'institute' => $institute,
                    'settings' => $settings,
                    'data' => $data,
                ]);
            } else {
                return view('welcome', [
                    'institute' => $institute,
                    'settings' => $settings,
                    'data' => $data,
                ]);
            }
        } catch (\Exception $e) {

            abort(500, $e->getMessage());
        }
    }

    public function vital(string $encodedData)
    {
        try {
            // The route is behind the `signed` middleware, so this payload was issued by PrintLinkController.
            $data = $this->decodePrintPayload($encodedData);

            // Validate structure
            if (
                ! is_array($data) ||
                ! isset($data['institute_id'], $data['branch_id'], $data['student_id']) ||
                ! ctype_digit((string) $data['institute_id']) ||
                ! ctype_digit((string) $data['branch_id']) ||
                ! ctype_digit((string) $data['student_id'])
            ) {
                return abort(404, 'Invalid data format.');
            }

            $instituteId = (int) $data['institute_id'];
            $branchId = (int) $data['branch_id'];
            $studentId = (int) $data['student_id'];

            // Lookup student, scoped to the institute + branch the link was issued for
            $student = Student::where('id', $studentId)
                ->where('institute_id', $instituteId)
                ->where('branch_id', $branchId)
                ->first();

            if (! $student) {
                return abort(404, 'Student not found.');
            }

            $exams = ClassExam::with('exam')
                ->where('class_id', $student->studentSession?->class_id)
                ->get()
                ->pluck('exam');

            $subjects = Subject::where('class_id', $student->studentSession?->class_id)->get();

            return view('vital.index', compact('student', 'exams', 'subjects', 'studentId', 'instituteId', 'branchId'));
        } catch (\Throwable $e) {
            return abort(404, 'Something went wrong.');
        }
    }

    public function studentIdCardList(string $encodedData)
    {
        try {
            // The route is behind the `signed` middleware, so this payload was issued by PrintLinkController.
            $data = $this->decodePrintPayload($encodedData);

            if (! is_array($data)) {
                return abort(404, 'Invalid data format.');
            }

            // Extract with defaults
            $class_id = (int) ($data['class_id'] ?? 0);
            $section_id = (int) ($data['section_id'] ?? 0);
            $group_id = (int) ($data['group_id'] ?? 0);
            $validity_date = $data['validity'] ?? null;
            $instituteId = (int) ($data['institute_id'] ?? 0);
            $branchId = (int) ($data['branch_id'] ?? 0);

            if ($instituteId < 1 || $branchId < 1) {
                return abort(404, 'Invalid data format.');
            }

            // Fetch students
            $students = $this->studentService->getStudentsByClassSectionGroup(
                $class_id,
                $section_id,
                $group_id,
                200,
                $instituteId,
                $branchId
            );

            // Fetch settings
            $settings = Setting::where('institute_id', $instituteId)
                ->where('branch_id', $branchId)
                ->pluck('value', 'name')
                ->toArray();

            $principalSignature = Signature::first();

            return view('backend.students.id-card.card-list', compact(
                'students',
                'validity_date',
                'principalSignature',
                'instituteId',
                'branchId',
                'settings'
            ));
        } catch (\Throwable $e) {
            return abort(404, 'Something went wrong.');
        }
    }

    public function teacherIdCardList(string $encodedData)
    {
        try {
            // The route is behind the `signed` middleware, so this payload was issued by PrintLinkController.
            $data = $this->decodePrintPayload($encodedData);

            if (! is_array($data)) {
                return abort(404, 'Invalid data format.');
            }

            // Extract IDs
            $instituteId = (int) ($data['institute_id'] ?? 0);
            $branchId = (int) ($data['branch_id'] ?? 0);

            if ($instituteId < 1 || $branchId < 1) {
                return abort(404, 'Invalid data format.');
            }

            // Fetch teachers
            $teachers = Teacher::select(
                '*',
                'teachers.id AS id',
                'teachers.status AS teacher_status',
            )
                ->where('teachers.institute_id', $instituteId)
                ->where('teachers.branch_id', $branchId)
                ->join('users', 'users.id', '=', 'teachers.user_id')
                ->orderBy('teachers.id', 'DESC')
                ->get();

            // Settings & signature
            $principalSignature = Signature::first();
            $settings = Setting::where('institute_id', $instituteId)
                ->where('branch_id', $branchId)
                ->pluck('value', 'name')
                ->toArray();

            return view('backend.teachers.id-card.card-list', compact(
                'teachers',
                'principalSignature',
                'instituteId',
                'branchId',
                'settings'
            ));
        } catch (\Throwable $e) {
            Log::error('Teacher ID Card List error: '.$e->getMessage());

            return abort(404, 'Something went wrong.');
        }
    }

    public function staffIdCardList(string $encodedData)
    {
        try {
            // The route is behind the `signed` middleware, so this payload was issued by PrintLinkController.
            $data = $this->decodePrintPayload($encodedData);

            if (! is_array($data)) {
                return abort(404, 'Invalid data format.');
            }

            // Extract IDs
            $instituteId = (int) ($data['institute_id'] ?? 0);
            $branchId = (int) ($data['branch_id'] ?? 0);

            if ($instituteId < 1 || $branchId < 1) {
                return abort(404, 'Invalid data format.');
            }

            // Fetch staffs
            $staffs = Staff::select(
                '*',
                'staffs.id AS id',
            )
                ->where('staffs.institute_id', $instituteId)
                ->where('staffs.branch_id', $branchId)
                ->join('users', 'users.id', '=', 'staffs.user_id')
                ->get();

            // Settings & signature
            $principalSignature = Signature::first();
            $settings = Setting::where('institute_id', $instituteId)
                ->where('branch_id', $branchId)
                ->pluck('value', 'name')
                ->toArray();

            return view('backend.staffs.id-card.card-list', compact(
                'staffs',
                'principalSignature',
                'instituteId',
                'branchId',
                'settings'
            ));
        } catch (\Throwable $e) {
            Log::error('Staff ID Card List error: '.$e->getMessage());

            return abort(404, 'Something went wrong.');
        }
    }

    /**
     * Decode the URL-safe base64 JSON payload of a print link. Returns null when malformed.
     */
    private function decodePrintPayload(string $encodedData): ?array
    {
        $decoded = base64_decode(strtr($encodedData, '-_', '+/'), true);

        if ($decoded === false) {
            return null;
        }

        $data = json_decode($decoded, true);

        return is_array($data) ? $data : null;
    }
}
