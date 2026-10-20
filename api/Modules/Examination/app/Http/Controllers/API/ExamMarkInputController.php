<?php

namespace Modules\Examination\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Modules\Academic\Models\StudentSession;
use Modules\Academic\Models\Subject;
use Modules\Academic\Services\StudentService;
use Modules\Examination\Http\Requests\ExamAssignRequest;
use Modules\Examination\Models\ClassExam;
use Modules\Examination\Models\ExamCode;
use Modules\Examination\Models\ExamMark;
use Modules\Examination\Models\Grade;
use Modules\Examination\Models\GrandFinalClassExam;
use Modules\Examination\Models\MarkConfig;
use Modules\Examination\Models\MarkConfigExamCode;

class ExamMarkInputController extends Controller
{
    public function __construct(
        private readonly StudentService $studentService
    ) {}

    public function markConfig(Request $request): JsonResponse
    {
        $classId = (int) $request->class_id;
        $groupId = (int) $request->group_id;
        $data = [];

        // Initialize variables for subjects and class exams
        $subjects = collect();
        $classExams = collect();
        $examCodes = collect();
        $markConfig = collect();

        // If classId is provided, fetch subjects and class exams
        if ($classId) {
            $subjects = Subject::where('class_id', $classId)
                ->where('group_id', $groupId)
                ->select('id', 'class_id', 'subject_name', 'subject_code')
                ->get();

            $classExams = ClassExam::where('class_id', $classId)->with('exam', 'class', 'meritType')->get();
            $examCodes = ExamCode::where('class_model_id', $classId)->with('class', 'shortCode')->get();
            // Fetch MarkConfig based on class_id and group_id
            if ($request->type == 'mark_config_view') {
                $examId = (int) $request->exam_id;
                $markConfig = MarkConfig::with(['class', 'group', 'subject', 'exam', 'mark_config_exam_codes'])
                    ->where('class_id', $classId)
                    ->where('group_id', $groupId)
                    ->where('exam_id', $examId)
                    ->get();
            }
        }

        $data['classId'] = $classId;
        $data['groupId'] = $groupId;
        $data['subjects'] = $subjects;
        $data['classExams'] = $classExams;
        $data['examCodes'] = $examCodes;
        $data['markConfig'] = $markConfig;

        return $this->responseSuccess(
            $data,
            'Exam codes updated successfully.'
        );
    }

    public function grandFinalMarkPercentage($class_id)
    {
        try {
            // fetch existing grand final data
            $grandFinalExams = GrandFinalClassExam::with('exam:id,name')
                ->where('class_id', $class_id)
                ->get();

            if ($grandFinalExams->isNotEmpty()) {
                $data = $grandFinalExams->map(function ($item) {
                    return [
                        'exam_id' => $item->exam_id,
                        'exam_name' => $item->exam->name ?? 'Unknown',
                        'percentage' => (float) $item->percentage,
                        'serial_no' => (int) $item->serial_no,
                    ];
                });
            } else {
                // fallback to class_exams if not yet configured
                $classExams = ClassExam::with('exam:id,name')
                    ->where('class_id', $class_id)
                    ->get();

                $data = $classExams->map(function ($item) {
                    return [
                        'exam_id' => $item->exam_id,
                        'exam_name' => $item->exam->name ?? 'Unknown',
                        'percentage' => 0,
                        'serial_no' => 1,
                    ];
                });
            }

            return $this->responseSuccess(
                [
                    'status' => true,
                    'class_id' => $class_id,
                    'data' => $data,
                ],
                _lang('Grand Final Mark class wise percentage')
            );
        } catch (Exception $e) {
            return $this->responseError([
                'status' => false,
                'message' => $e->getMessage(),
            ]);
        }
    }

    public function generalExamStore(Request $request): JsonResponse
    {
        $request->validate([
            'class_id' => 'required|exists:classes,id',
            'group_id' => 'required|exists:student_groups,id',

            'selected_subjects' => 'required|array|min:1',
            'selected_subjects.*' => 'exists:subjects,id',

            'selected_exams' => 'required|array|min:1',
            'selected_exams.*' => 'exists:exams,id',

            'exam_codes' => 'required|array|min:1',
            'exam_codes.*.title' => 'required|string|max:50',
            'exam_codes.*.total_marks' => 'required|numeric|min:0',
            'exam_codes.*.pass_mark' => 'required|numeric|min:0',
            'exam_codes.*.acceptance' => 'nullable|numeric|min:0|max:100',
        ]);

        DB::beginTransaction();

        try {

            $classId = (int) $request->class_id;
            $groupId = (int) $request->group_id;

            $subjects = array_map('intval', $request->selected_subjects);
            $exams = array_map('intval', $request->selected_exams);
            $codes = $request->exam_codes;

            foreach ($subjects as $subjectId) {
                foreach ($exams as $examId) {
                    foreach ($codes as $code) {

                        $examCode = MarkConfigExamCode::updateOrCreate(
                            [
                                'institute_id' => get_institute_id(),
                                'branch_id' => get_branch_id(),
                                'session_id' => get_option('academic_year'),
                                'title' => $code['title'],
                                'subject_id' => $subjectId,
                            ],
                            [
                                'total_marks' => $code['total_marks'],
                                'pass_mark' => $code['pass_mark'],
                                'acceptance' => $code['acceptance'] ?? 0,
                            ]
                        );

                        MarkConfig::updateOrCreate(
                            [
                                'institute_id' => get_institute_id(),
                                'branch_id' => get_branch_id(),
                                'session_id' => get_option('academic_year'),
                                'class_id' => $classId,
                                'group_id' => $groupId,
                                'subject_id' => $subjectId,
                                'exam_id' => $examId,
                                'mark_config_exam_code_id' => $examCode->id,
                            ],
                            [
                                'updated_at' => now(),
                            ]
                        );
                    }
                }
            }

            DB::commit();

            return $this->responseSuccess([], _lang('Mark Config saved successfully.'));
        } catch (Exception $e) {

            DB::rollBack();

            return $this->responseError([], $e->getMessage(), 500);
        }
    }

    public function grandFinalExamStore(Request $request): JsonResponse
    {
        $request->validate([
            'class_id' => 'required|exists:classes,id',
            'percentages' => 'required|array',
            'serial_no' => 'required|array',
        ]);

        foreach ($request->percentages as $exam) {
            $examId = $exam['exam_id'];
            $percentage = $exam['percentage'];
            $serialNo = collect($request->serial_no)->where('exam_id', $examId)->first()['serial_no'];

            GrandFinalClassExam::updateOrCreate(
                [
                    'institute_id' => get_institute_id(),
                    'branch_id' => get_branch_id(),
                    'session_id' => get_option('academic_year'),
                    'class_id' => intval($request->class_id),
                    'exam_id' => intval($examId),
                ],
                [
                    'percentage' => floatval($percentage),
                    'serial_no' => intval($serialNo),
                ]
            );
        }

        return $this->responseSuccess(
            [],
            _lang('Grand Final Percentage Created successfully.')
        );
    }

    public function markInputSectionWiseClass(Request $request, int $classId): JsonResponse
    {
        $examId = (int) $request->exam_id ?? null;
        $groupId = (int) $request->group_id ?? null;
        $subjectId = (int) $request->subject_id ?? null;
        $sectionId = (int) $request->section_id ?? null;
        $markConfig = collect();
        $students = collect();

        $data = [];
        if ($examId && $groupId && $subjectId) {
            $examId = (int) $request->exam_id;
            $markConfig = MarkConfig::with(['class', 'group', 'subject', 'exam', 'mark_config_exam_code'])
                ->where('class_id', $classId)
                ->where('group_id', $groupId)
                ->where('exam_id', $examId)
                ->where('subject_id', $subjectId)
                ->get();

            $students = $this->studentService->getStudentsByClassSectionGroup($classId, $sectionId, $groupId, null, get_institute_id(), get_branch_id());
        }

        $data['markConfig'] = $markConfig;
        $data['students'] = $students;

        return $this->responseSuccess(
            $data,
            'Mark Input Section wise students get successfully.'
        );
    }

    public function markStoreSectionWise(Request $request): JsonResponse
    {
        // Validate input
        $validated = $request->validate([
            'class_id' => 'required|exists:classes,id',
            'group_id' => 'required|exists:student_groups,id',
            'subject_id' => 'required|exists:subjects,id',
            'exam_id' => 'required|exists:exams,id',
            'marks' => 'required|array|min:1',
            'marks.*.student_id' => 'required|exists:students,id',
            'marks.*.mark_1' => 'nullable|numeric|min:0',
            'marks.*.mark_2' => 'nullable|numeric|min:0',
            'marks.*.mark_3' => 'nullable|numeric|min:0',
            'marks.*.mark_4' => 'nullable|numeric|min:0',
            'marks.*.mark_5' => 'nullable|numeric|min:0',
            'marks.*.mark_6' => 'nullable|numeric|min:0',
        ]);

        $classId = (int) $validated['class_id'];
        $groupId = (int) $validated['group_id'];
        $subjectId = (int) $validated['subject_id'];
        $examId = (int) $validated['exam_id'];
        $marks = $validated['marks'];

        $instituteId = get_institute_id();
        $branchId = get_branch_id();
        $sessionId = get_option('academic_year');

        $responseData = [];
        try {
            DB::beginTransaction();

            foreach ($marks as $studentMarks) {
                $studentId = (int) $studentMarks['student_id'];
                $marksData = [];
                $totalMarks = 0;

                foreach ($studentMarks as $key => $mark) {
                    if ($key === 'student_id') {
                        continue;
                    }

                    // Extract number from keys like mark_1 => 1
                    $questionNumber = (int) filter_var($key, FILTER_SANITIZE_NUMBER_INT);

                    // Must match DB column name like mark1, mark2, ...
                    $column = 'mark'.$questionNumber;
                    $markValue = (float) ($mark ?? 0);
                    $questionId = str_replace('mark_', '', $key); // Extract question ID
                    $marksData["mark{$questionId}"] = $markValue;
                    $marksData[$column] = $markValue;
                    $totalMarks += $markValue;
                }

                if ($totalMarks > 100) {
                    throw new Exception(
                        "Total marks must not exceed 100. Student ID {$studentId} has {$totalMarks}"
                    );
                }

                $grade = Grade::where('number_low', '<=', $totalMarks)
                    ->where('number_high', '>=', $totalMarks)
                    ->first();

                $gradeLetter = $grade->grade_name ?? 'F';
                $gradePoint = $grade->grade_point ?? 0;

                $identifiers = [
                    'institute_id' => $instituteId,
                    'branch_id' => $branchId,
                    'session_id' => $sessionId,
                    'student_id' => $studentId,
                    'class_id' => $classId,
                    'group_id' => $groupId,
                    'subject_id' => $subjectId,
                    'exam_id' => $examId,
                ];

                $data = array_merge($marksData, [
                    'total_marks' => $totalMarks,
                    'grade' => $gradeLetter,
                    'grade_point' => $gradePoint,
                ]);

                ExamMark::updateOrCreate($identifiers, $data);

                $responseData[] = [
                    'student_id' => $studentId,
                    'total_marks' => $totalMarks,
                    'grade' => $gradeLetter,
                    'grade_point' => $gradePoint,
                    'status' => 'stored',
                ];
            }

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Marks stored section-wise successfully.',
                'data' => $responseData,
            ]);
        } catch (Exception $e) {
            DB::rollBack();

            return response()->json([
                'success' => false,
                'message' => 'Failed to store marks.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function examResult(Request $request): JsonResponse
    {
        $request->validate([
            'class_id' => 'required|exists:classes,id',
            'section_id' => 'nullable|exists:sections,id',
            'group_id' => 'nullable|exists:student_groups,id',
            'exam_id' => 'required|exists:exams,id',
            'search' => 'nullable|string',
        ]);

        try {
            $query = StudentSession::with([
                'student',
                'examMarks' => function ($q) use ($request) {
                    $q->where('exam_id', $request->exam_id)
                        ->with('subject');
                },
            ])
                ->where('class_id', $request->class_id);

            // ✅ Only filter section if provided
            if (! empty($request->section_id)) {
                $query->where('section_id', $request->section_id);
            }

            // ✅ Group filter (student table)
            if (! empty($request->group_id)) {
                $query->whereHas('student', function ($q) use ($request) {
                    $q->where('group', $request->group_id); // Assuming students.group column
                });
            }

            // 🔍 Search by roll or student first name
            if (! empty($request->search)) {
                $query->where(function ($q) use ($request) {
                    $q->where('roll', 'like', '%'.$request->search.'%')
                        ->orWhereHas('student', function ($qs) use ($request) {
                            $qs->where('first_name', 'like', '%'.$request->search.'%');
                        });
                });
            }

            // Get all results (no pagination)
            $sessions = $query->orderBy('roll', 'asc')->get();

            $passCount = 0;
            $failCount = 0;

            $data = $sessions->map(function ($session) use (&$passCount, &$failCount) {

                $subjects = [];
                $totalMarks = 0;
                $totalPoints = 0;
                $subjectCount = 0;
                $hasFail = false;

                foreach ($session->examMarks as $mark) {
                    $subjects[] = [
                        'subject_id' => $mark->subject_id,
                        'subject_name' => $mark->subject?->subject_name,
                        'total_marks' => $mark->total_marks,
                        'percentage' => $mark->percentage ?? 0,
                        'grade' => $mark->grade,
                        'grade_point' => $mark->grade_point,
                    ];

                    $totalMarks += $mark->total_marks;
                    $totalPoints += $mark->grade_point;
                    $subjectCount++;

                    if ($mark->grade === 'F') {
                        $hasFail = true;
                    }
                }

                if ($subjectCount === 0) {
                    $status = 'Not Published';
                    $gpa = 'N/A';
                    $gradeName = 'N/A';
                } else {
                    $gpa = round($totalPoints / $subjectCount, 2);

                    $finalGrade = Grade::where('point_low', '<=', $gpa)
                        ->where('point_high', '>=', $gpa)
                        ->first();

                    $gradeName = $finalGrade->grade_name ?? 'F';
                    $status = $hasFail ? 'Fail' : 'Pass';

                    $status === 'Pass' ? $passCount++ : $failCount++;
                }

                return [
                    'student_id' => $session->student_id,
                    'student_name' => $session->student
                        ? trim($session->student->first_name.' '.$session->student->last_name)
                        : null,
                    'student_image' => $session->student?->user?->image,
                    'roll' => $session->roll,
                    'total_marks' => $totalMarks,
                    'gpa' => $gpa,
                    'grade' => $gradeName,
                    'status' => $status,
                    'subjects' => $subjects,
                ];
            });

            return response()->json([
                'success' => true,
                'message' => 'Exam results fetched successfully.',
                'summary' => [
                    'total_students' => $passCount + $failCount,
                    'passed' => $passCount,
                    'failed' => $failCount,
                ],
                'data' => $data,
            ]);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch results.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function examAssignStore(ExamAssignRequest $request): JsonResponse
    {
        DB::beginTransaction();
        try {
            $classId = (int) $request->class_id;
            $meritProcessTypeId = (int) $request->merit_process_type_id;

            // Check for existing assignments in a single query
            $existingExams = ClassExam::where('class_id', $classId)
                ->where('merit_process_type_id', $meritProcessTypeId)
                ->whereIn('exam_id', $request->exam_ids)
                ->pluck('exam_id')
                ->toArray();

            // Filter out existing exams
            $newExams = array_diff($request->exam_ids, $existingExams);
            if (empty($newExams)) {
                return $this->responseError([], _lang('All selected exams for this class and merit process type already exist.'), 422);
            }

            // Prepare bulk insert data
            $insertData = [];
            foreach ($newExams as $examId) {
                $insertData[] = [
                    'institute_id' => get_institute_id(),
                    'branch_id' => get_branch_id(),
                    'class_id' => $classId,
                    'exam_id' => $examId,
                    'merit_process_type_id' => $meritProcessTypeId,
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
            }

            // Insert all new records in one query
            ClassExam::insert($insertData);

            DB::commit();

            return $this->responseSuccess(
                [],
                _lang('Exam merit assignments created successfully.')
            );
        } catch (Exception $e) {
            DB::rollBack();

            return $this->responseError([], $e->getMessage(), 500);
        }
    }
}
