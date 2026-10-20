<?php

namespace Modules\Student\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;
use Modules\QuestionBank\Models\Question;
use Modules\QuestionBank\Models\Quiz;

/**
 * Learner quiz list for the student app, built on the QuestionBank quizzes.
 * (The original code used a "Quiz" module that no longer exists and crashed.)
 * Correct answers are never sent to learners; marking happens in the QuizAttempt flow.
 */
class StudentQuizController extends Controller
{
    public function quizPage(): JsonResponse
    {
        $quizzes = $this->availableQuizzes()->get();

        return $this->responseSuccess([
            'topics' => $quizzes->map(fn (Quiz $q) => $this->topic($q))->values(),
            'questions' => $quizzes->flatMap(fn (Quiz $q) => $this->questions($q))->values(),
        ], 'Student Quiz Page fetch successfully.');
    }

    public function quizStart(int $id): JsonResponse
    {
        $quiz = $this->availableQuizzes()->find($id);
        if (! $quiz) {
            return $this->responseError([], _lang('Quiz not found.'), 404);
        }

        return $this->responseSuccess([
            'topic' => $this->topic($quiz),
            'questions' => $this->questions($quiz),
        ], 'Student Quiz Start fetch successfully.');
    }

    public function quizFinish(int $id): JsonResponse
    {
        return $this->responseError([], _lang('Submit answers with the quiz-submit endpoint.'), 410);
    }

    private function availableQuizzes()
    {
        $user = Auth::user();

        return Quiz::where('institute_id', $user->institute_id)
            ->where(fn ($q) => $q->whereNull('status')->orWhere('status', 1)->orWhere('status', 'active'))
            ->where(fn ($q) => $q->whereNull('end_time')->orWhere('end_time', '>=', now()))
            ->orderByDesc('id');
    }

    private function topic(Quiz $quiz): array
    {
        return [
            'id' => $quiz->id,
            'title' => $quiz->title,
            'description' => strip_tags((string) $quiz->description),
            'per_q_mark' => $quiz->marks_per_question,
            'timer' => $quiz->has_time_limit ? $quiz->time_limit_value : 0,
            'show_ans' => 0,
            'amount' => 0,
        ];
    }

    private function questions(Quiz $quiz): array
    {
        $ids = array_filter((array) $quiz->question_ids);
        if (! $ids) {
            return [];
        }

        return Question::whereIn('id', $ids)->get()->map(function (Question $question) use ($quiz) {
            $options = array_values(array_map(
                fn ($o) => is_array($o) ? ($o['option'] ?? $o['text'] ?? $o['value'] ?? reset($o)) : $o,
                (array) $question->options
            ));

            return [
                'id' => $question->id,
                'topic_id' => $quiz->id,
                'question' => strip_tags((string) $question->question),
                'a' => $options[0] ?? null,
                'b' => $options[1] ?? null,
                'c' => $options[2] ?? null,
                'd' => $options[3] ?? null,
                'answer' => null,
                'code_snippet' => null,
                'answer_exp' => null,
            ];
        })->all();
    }
}
