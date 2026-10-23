<?php

namespace App\Services;

use Modules\Academic\Models\Assignment;
use Modules\Academic\Models\ExamSchedule;
use Modules\Academic\Models\StudentAttendance;
use Modules\Academic\Models\StudentSession;

/**
 * Dashboard figures for one learner: attendance (this month and overall, from the daily
 * register in period 1), homework set for the class and upcoming exams. Shown to the learner
 * and to their parent, so both see the same numbers.
 */
class LearnerOverview
{
    public static function for(int $studentId): ?array
    {
        $session = StudentSession::where('student_id', $studentId)->orderByDesc('id')->first();
        if (! $session) {
            return null;
        }

        $register = fn () => StudentAttendance::where('student_id', $studentId)->where('period_id', 1);
        $percent = function ($query) {
            $total = (clone $query)->count();

            return $total > 0 ? round((clone $query)->where('attendance', 1)->count() / $total * 100, 2) : 0;
        };

        return [
            'attendance' => [
                'monthly_percentage' => $percent($register()->whereBetween('date', [now()->startOfMonth()->toDateString(), now()->endOfMonth()->toDateString()])),
                'overall_percentage' => $percent($register()),
            ],
            'tasks' => Assignment::where('class_id', $session->class_id)->count(),
            'upcoming_exams' => ExamSchedule::where('class_id', $session->class_id)->where('date', '>=', now()->toDateString())->count(),
        ];
    }
}
