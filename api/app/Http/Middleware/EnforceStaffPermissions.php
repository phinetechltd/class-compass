<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * Staff RBAC: every school-module API requires a permission from the same group the Flutter
 * sidebar checks (fees_management.*, payroll.*, library_management.*, master_configuration.*...).
 * Without this a Librarian or Accountant token could call payroll, accounting or settings endpoints
 * directly. Parents/learners are handled by RestrictPortalUsers; the admin roles keep full access.
 *
 * Each rule: [path regex, permission prefixes for any method, extra prefixes allowed for GET].
 * A user passes when they hold at least one permission starting with one of the prefixes; '*' in
 * the GET list means any staff member may read. Paths no rule matches (profile, lookups such as
 * get-classes, teacher/*, login...) are left to the controllers.
 */
class EnforceStaffPermissions
{
    private const FULL_ACCESS = ['Super Admin', 'System Admin', 'SAAS Admin'];

    /** Read access to the student list for screens outside Student Information that pick students. */
    private const STUDENT_READERS = ['fees_management.', 'student_attendance.', 'exam_module.', 'sms_notifications.',
        'library_management.', 'hostel_panel', 'transport_panel', 'teacher_panel', 'layouts_certificates.'];

    private const RULES = [
        // Dashboard
        ['#^api/(dashboard-data|student-attendance-summery|at-a-glance)$#', ['dashboard'], []],

        // Payroll
        ['#^api/(payroll-|salary-|staff-salary-config|user-salary-assign|advance-salary-payment|due-salary-payment|return-salary-payment|payment-info$)#', ['payroll.'], []],

        // Accounting and accounting reports (the dashboard chart reads the monthly fee collection report)
        ['#^api/report/get-monthly-fee-collections$#', ['accounting_report.', 'fees_management.', 'dashboard'], []],
        ['#^api/(account-|accounting-|chart-of-accounts|ledger-account-balance)#', ['accounting_management.', 'accounting_report.'], []],
        ['#^api/report/#', ['accounting_report.'], []],

        // Fees
        ['#^api/(absent-fines|fee-|fees(-mapping)?(/|$)|waivers|waiver-config|quick-collection|get-(attendance|lab|quiz)-fine-amount|get-tc-amount|paid-reports|unpaid-reports|student-collection-|class-wise-payment-summary|head-wise-|monthly-paid-info|paid-invoice|payment-fee-info|payment-ratio-info|unpaid-fee-info|unpaid-summery|online-fee-payments)#', ['fees_management.'], []],

        // Library
        ['#^api/(book-categories|books|get-books$|get-library-members$)#', ['library_management.'], []],

        // Student information
        ['#^api/(students|student-migration|migrated-list|student-branch-migration|parents(/|$)|custom-field-values)#', ['student_information.'], self::STUDENT_READERS],

        // Attendance
        ['#^api/(student-attendance|student-absent-attendance|reports-student-|student-qr-code-attendance)#', ['student_attendance.', 'teacher_panel'], []],

        // Staff
        ['#^api/(staffs-attendance|reports-staffs-attendance)#', ['staff_information.staff_attendance', 'staff_information.staffs_report'], []],
        ['#^api/(staffs|teachers)(/|$)#', ['staff_information.'], ['payroll.', 'administrator.', 'routine_management.']],

        // Academic configuration: lists are dropdowns everywhere, changes need the permission
        ['#^api/(sessions|shifts|class|sections|groups|periods|subjects|student-categories|departments|picklists|signatures|teacher-signatures|exams|custom-fields)(/|$)#', ['academic_configuration.'], ['*']],

        // Administrator
        ['#^api/(assign-classes|assign-shifts|assign-subjects)(/|$)#', ['administrator.'], ['*']],
        ['#^api/(notices|events)(/|$)#', ['administrator.notice', 'administrator.event'], ['*']],
        // Every staff member reads their own activity (the controller limits non-admins to themselves).
        ['#^api/user-logs#', ['administrator.user_activities'], ['*']],

        // Routine, assignments, syllabus
        ['#^api/(class-routines|exam-routines|assignments|syllabus)(/|$)#', ['routine_management.', 'teacher_panel'], ['*']],

        // Examination
        ['#^api/(exam-|grades|general-exam-store|grand-final-|mark-|merit-process-type|remarks-config|result-cards|semester-exam-settings-|short-code|class-exam)#', ['exam_module.', 'academic_configuration.exams', 'teacher_panel'], []],

        // Certificates
        ['#^api/layout-certificates#', ['layouts_certificates.', 'student_information.student_migration'], []],

        // SMS
        ['#^api/(phone-book|sms-|send-sms-report)#', ['sms_notifications.'], []],

        // Teacher-module content
        ['#^api/(behaviors|classlessons|gamifications|resources|prayers)(/|$)#', ['teacher_panel', 'administrator.'], ['*']],
        ['#^api/(zooms|course-zooms)(/|$)#', ['zoom-', 'teacher_panel'], ['*']],

        // Question bank / quizzes
        ['#^api/(question-|questions|quizzes|quiz-test)#', ['quiz.', 'teacher_panel'], []],

        // Hostel and transport
        ['#^api/(hostels|hostel-|meals|meal-|rooms|room-members)#', ['hostel_panel'], []],
        ['#^api/(buses|bus-|drivers|transport-members)#', ['transport_panel'], []],

        // Master configuration
        ['#^api/(roles|permissions)(/|$)#', ['master_configuration.roles', 'role-'], []],
        ['#^api/users(/|$)#', ['master_configuration.users', 'user-'], []],
        // The branch switcher in the header lists the school's branches for every staff member.
        ['#^api/branches(/|$)#', ['master_configuration.branches'], ['*']],
        ['#^api/client-licenses#', ['master_configuration.client_licenses'], []],
        ['#^api/(administration-backup-database|drop-database)#', ['master_configuration.database_backup'], []],
        ['#^api/(administration-upload-logo|institute-image-settings|curriculum)#', ['master_configuration.system_settings'], []],
        ['#^api/digital-payment#', ['payment_gateway.', 'master_configuration.system_settings'], []],
        ['#^api/(about-us|banners|faqs|gallery-images|mobile-app-sections|policies|ready-to-join-us|testimonials|why-choose-us)(/|$)#', ['master_configuration.cms_control'], ['*']],

        // Platform (SaaS) management
        ['#^api/(institutes|onboardings-|subscription(/|$)|saas-|institute-image-saas-settings)#', ['master_configuration.institutes'], []],
        ['#^api/plans(/|$)#', ['master_configuration.plans'], []],
    ];

    public function handle(Request $request, Closure $next): Response
    {
        $user = $request->user('api');
        if (! $user || in_array($user->user_type, ['Parent', 'Student'], true)
            || in_array($user->user_type, self::FULL_ACCESS, true)) {
            return $next($request);
        }

        $rule = $this->ruleFor(ltrim($request->path(), '/'));
        if ($rule === null) {
            return $next($request);
        }

        [, $prefixes, $readPrefixes] = $rule;
        if ($request->isMethod('GET') || $request->isMethod('HEAD')) {
            if (in_array('*', $readPrefixes, true)) {
                return $next($request);
            }
            $prefixes = array_merge($prefixes, $readPrefixes);
        }

        if ($this->holdsAny($user, $prefixes)) {
            return $next($request);
        }

        return response()->json([
            'status' => false,
            'message' => 'You do not have permission to access this resource.',
            'data' => null,
        ], 403);
    }

    private function ruleFor(string $path): ?array
    {
        foreach (self::RULES as $rule) {
            if (preg_match($rule[0], $path)) {
                return $rule;
            }
        }

        return null;
    }

    private function holdsAny($user, array $prefixes): bool
    {
        try {
            $names = $user->getAllPermissions()->pluck('name');
        } catch (\Throwable) {
            return false;
        }

        foreach ($names as $name) {
            foreach ($prefixes as $prefix) {
                if ($name === $prefix || str_starts_with($name, $prefix)) {
                    return true;
                }
            }
        }

        return false;
    }
}
