<?php

namespace App\Http\Controllers;

use App\Services\CurriculumService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class CurriculumController extends Controller
{
    public function __construct(private readonly CurriculumService $curriculum) {}

    public function index(Request $request): JsonResponse
    {
        return $this->responseSuccess([
            'current' => $this->curriculum->current((int) $request->user()->institute_id),
            'presets' => $this->curriculum->summary(),
        ], 'Curricula fetched successfully.');
    }

    public function apply(Request $request): JsonResponse
    {
        $user = $request->user();
        abort_if(in_array($user->user_type, ['Parent', 'Student', 'Teacher'], true), 403, 'Only school administrators can change the curriculum.');

        $data = $request->validate([
            'curriculum' => ['required', Rule::in(array_keys($this->curriculum->presets()))],
            'classes' => 'boolean',
            'subjects' => 'boolean',
            'grades' => 'boolean',
        ]);

        $stats = $this->curriculum->apply(
            (int) $user->institute_id,
            (int) $user->branch_id,
            $data['curriculum'],
            $data['classes'] ?? true,
            $data['subjects'] ?? true,
            $data['grades'] ?? true,
        );

        return $this->responseSuccess($stats + ['current' => $data['curriculum']], 'Curriculum applied successfully.');
    }
}
