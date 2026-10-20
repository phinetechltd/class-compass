<?php

namespace Modules\Academic\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;
use Modules\Academic\Models\Student;

class StudentUpdateRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, ValidationRule|array|string>
     */
    public function rules(): array
    {
        $instituteId = get_institute_id();
        $studentId = optional($this->route('student'))->id ?? (int) $this->route('student');
        $student = Student::with('user')->find($studentId);
        $userId = $student?->user_id;

        return [
            'first_name' => 'required|string|max:50',
            'last_name' => 'nullable|string|max:50',
            'father_name' => 'nullable|string|max:50',
            'mother_name' => 'nullable|string|max:50',

            'class_id' => 'required|exists:classes,id',
            'section_id' => 'required|exists:sections,id',
            'group' => 'nullable|exists:student_groups,id',

            // ✅ REGISTRATION NO (IGNORE CURRENT STUDENT)
            'registration_no' => [
                'nullable',
                Rule::unique('students', 'registration_no')
                    ->where(fn ($q) => $q->where('institute_id', $instituteId))
                    ->ignore($studentId),
            ],

            // ✅ ROLL UNIQUE (IGNORE CURRENT SESSION)
            'roll' => [
                'required',
                Rule::unique('student_sessions', 'roll')
                    ->where(function ($q) use ($instituteId) {
                        return $q->where('institute_id', $instituteId)
                            ->where('session_id', get_option('academic_year'))
                            ->where('class_id', request()->class_id)
                            ->where('section_id', request()->section_id);
                    })
                    ->ignore($studentId, 'student_id'), // important
            ],

            'blood_group' => 'nullable|string|max:4',
            'religion' => 'nullable|string|max:20',
            'gender' => 'required|string|max:10',
            'address' => 'nullable|string',

            // ✅ EMAIL (IGNORE CURRENT USER)
            'email' => [
                'required',
                'email',
                Rule::unique('users', 'email')
                    ->where(fn ($q) => $q->where('institute_id', $instituteId))
                    ->ignore($userId),
            ],

            // ✅ PHONE (IGNORE USER + STUDENT)
            'phone' => [
                'required',

                Rule::unique('users', 'phone')
                    ->where(fn ($q) => $q->where('institute_id', $instituteId))
                    ->ignore($userId),

                Rule::unique('students', 'phone')
                    ->where(fn ($q) => $q->where('institute_id', $instituteId))
                    ->ignore($studentId),
            ],

            'password' => 'nullable|string|min:6|confirmed',
            'image' => 'nullable|image|max:5120',
            'birthday' => 'nullable|date',

            'state' => 'nullable|string|max:50',
            'country' => 'nullable|string|max:100',
            'activities' => 'nullable|string|max:50',
            'remarks' => 'nullable|string|max:50',

            // ✅ PARENT VALIDATION
            'information_sent_to_name' => 'nullable|string|max:30|required_with:information_sent_to_email,information_sent_to_phone',
            'information_sent_to_email' => 'nullable|email|max:100|required_with:information_sent_to_name,information_sent_to_phone',
            'information_sent_to_phone' => 'nullable|string|max:30|required_with:information_sent_to_name,information_sent_to_email',
            'information_sent_to_relation' => 'nullable|string|max:30',
            'information_sent_to_address' => 'nullable|string|max:100',

            'branch_id' => 'nullable|exists:branches,id',
            'qr_code' => 'nullable|string|max:8',
        ];
    }

    public function messages(): array
    {
        return [
            'email.unique' => 'This email already exists in this institute.',
            'phone.unique' => 'This phone already exists.',
            'roll.unique' => 'This roll is already assigned in this class/section.',
            'registration_no.unique' => 'Registration number already exists.',
        ];
    }
}
