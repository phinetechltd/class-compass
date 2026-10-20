<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\URL;
use Modules\Academic\Models\Student;

/**
 * Issues short-lived signed links to the public print pages
 * (ID card lists and student vital / result card).
 *
 * The institute and branch always come from the logged-in user, never from
 * the client, and the public routes reject any URL whose signature does not
 * match (see the `signed` middleware in routes/web.php).
 */
class PrintLinkController extends Controller
{
    private const LINK_TTL_MINUTES = 30;

    private const ROUTES = [
        'student_id_card' => 'studentIdCardList',
        'teacher_id_card' => 'teacherIdCardList',
        'staff_id_card' => 'staffIdCardList',
        'student_vital' => 'student-vital',
    ];

    public function generate(Request $request)
    {
        $validated = $request->validate([
            'type' => 'required|string|in:'.implode(',', array_keys(self::ROUTES)),
            'class_id' => 'nullable|integer|min:1',
            'section_id' => 'nullable|integer|min:1',
            'group_id' => 'nullable|integer|min:1',
            'validity' => 'nullable|string|max:50',
            'student_id' => 'nullable|integer|min:1',
        ]);

        $user = auth()->user();
        $instituteId = (int) get_institute_id();
        $branchId = (int) get_branch_id();

        if ($instituteId < 1 || $branchId < 1) {
            return $this->responseError([], _lang('You are not authorized to access this feature!'), 403);
        }

        $type = $validated['type'];
        $payload = ['institute_id' => $instituteId, 'branch_id' => $branchId];

        if ($type === 'student_vital') {
            if (empty($validated['student_id'])) {
                return $this->responseError(['student_id' => ['The student id field is required.']], 'Invalid data.', 422);
            }

            $query = Student::where('id', $validated['student_id'])
                ->where('institute_id', $instituteId)
                ->where('branch_id', $branchId);

            // Students may only open their own card, parents only their children's.
            if ($user->user_type === 'Student') {
                $query->where('user_id', $user->id);
            } elseif ($user->user_type === 'Parent') {
                $query->whereIn('parent_id', function ($q) use ($user) {
                    $q->select('id')->from('parent_models')->where('user_id', $user->id);
                });
            }

            if (! $query->exists()) {
                return $this->responseError([], _lang('You are not authorized to access this feature!'), 403);
            }

            $payload['student_id'] = (int) $validated['student_id'];
        } else {
            // ID card lists expose a whole branch's people: staff-side users only.
            if (in_array($user->user_type, ['Student', 'Parent'], true)) {
                return $this->responseError([], _lang('You are not authorized to access this feature!'), 403);
            }

            if ($type === 'student_id_card') {
                if (empty($validated['class_id'])) {
                    return $this->responseError(['class_id' => ['The class id field is required.']], 'Invalid data.', 422);
                }
                $payload['class_id'] = (int) $validated['class_id'];
                $payload['section_id'] = (int) ($validated['section_id'] ?? 0);
                $payload['group_id'] = (int) ($validated['group_id'] ?? 0);
                $payload['validity'] = $validated['validity'] ?? null;
            }
        }

        $url = URL::temporarySignedRoute(
            self::ROUTES[$type],
            now()->addMinutes(self::LINK_TTL_MINUTES),
            ['encodedData' => strtr(base64_encode(json_encode($payload)), '+/', '-_')]
        );

        return $this->responseSuccess(['url' => $url]);
    }
}
