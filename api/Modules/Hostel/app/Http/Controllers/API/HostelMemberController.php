<?php

namespace Modules\Hostel\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Modules\Academic\Models\Student;
use Modules\Hostel\Models\HostelCategory;
use Modules\Hostel\Models\HostelMember;

class HostelMemberController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $query = Student::query()

            ->join('users', 'users.id', '=', 'students.user_id')
            ->join('student_sessions', function ($join) {
                $join->on('students.id', '=', 'student_sessions.student_id')
                    ->where('student_sessions.session_id', get_option('academic_year'));
            })
            ->join('classes', 'classes.id', '=', 'student_sessions.class_id')
            ->join('sections', 'sections.id', '=', 'student_sessions.section_id')

            // 🔴 INNER JOIN (important)
            ->join('hostel_members', 'hostel_members.student_id', '=', 'students.id')
            ->join('hostel_categories', 'hostel_categories.id', '=', 'hostel_members.hostel_category_id')
            ->join('hostels', 'hostels.id', '=', 'hostel_categories.hostel_id')

            ->where('users.user_type', 'Student')

            ->select([
                'students.id',
                'users.name',
                'users.email',
                'users.phone',
                'users.image',
                'student_sessions.roll',
                'classes.class_name',
                'sections.section_name',
                'hostel_members.id as member_id',
                'hostels.id as hostel_id',
                'hostels.hostel_name',
                'hostels.type as hostel_type',
                'hostels.address as hostel_address',
                'hostel_categories.id as category_id',
                'hostel_categories.standard',
                'hostel_categories.hostel_fee',
            ])

            ->orderByDesc('students.id');

        $students = $query->paginate(20);

        return $this->responseSuccess($students, 'Hostel members fetched successfully.');
    }

    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'student_id' => 'required|exists:students,id',
            'hostel_category_id' => 'required|exists:hostel_categories,id',
        ]);

        $member = new HostelMember;
        $member->institute_id = get_institute_id();
        $member->branch_id = get_branch_id();
        $member->student_id = $request->student_id;
        $member->hostel_category_id = $request->hostel_category_id;
        $member->save();

        return $this->responseSuccess($member, 'Hostel member fetch successfully.');
    }

    public function show($id): JsonResponse
    {
        $student = Student::join('users', 'users.id', '=', 'students.user_id')
            ->join('student_sessions', 'students.id', '=', 'student_sessions.student_id')
            ->join('classes', 'classes.id', '=', 'student_sessions.class_id')
            ->join('sections', 'sections.id', '=', 'student_sessions.section_id')
            ->where('student_sessions.session_id', get_option('academic_year'))
            ->where('students.id', $id)->first();

        return $this->responseSuccess($student, 'Hostel member fetch successfully.');
    }

    public function update(Request $request, int $id): JsonResponse
    {
        $request->validate([
            'student_id' => 'nullable|exists:students,id',
            'hostel_category_id' => 'required|exists:hostel_categories,id',
        ]);

        $member = HostelMember::find($id);
        if (! $member) {
            return $this->responseError([], _lang('Something went wrong. Member can not be found.'));
        }

        if ($request->student_id) {
            $member->student_id = $request->student_id;
        }
        $member->hostel_category_id = $request->hostel_category_id;
        $member->save();

        return $this->responseSuccess($member, 'Hostel member fetch successfully.');
    }

    public function destroy(int $id): JsonResponse
    {
        $member = HostelMember::find($id);
        if (! $member) {
            return $this->responseError([], _lang('Something went wrong. Member can not be found.'));
        }
        $member->delete();

        return $this->responseSuccess([], 'Hostel member fetch successfully.');
    }

    public function get_hostel_fee(Request $request): JsonResponse
    {
        $request->validate([
            'hostel_category_id' => 'required|exists:hostel_categories,id',
        ]);

        $categoryId = (int) $request->hostel_category_id;
        $category = HostelCategory::find($categoryId)->first();
        if (! $category) {
            return $this->responseError([], _lang('Something went wrong. Category can not be found.'));
        }

        $hostel_fee = $category->hostel_fee;

        return $this->responseSuccess($hostel_fee, 'Hostel fee fetch successfully.');
    }
}
