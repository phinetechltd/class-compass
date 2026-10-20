<?php

namespace Modules\Academic\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class StudentCreateRequest extends FormRequest
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

        return [
            'first_name' => 'required|string|max:50',
            'last_name' => 'nullable|string|max:50',
            'father_name' => 'nullable|string|max:50',
            'mother_name' => 'nullable|string|max:50',
            'class_id' => 'required|exists:classes,id',
            'section_id' => 'required|exists:sections,id',
            'group' => 'nullable|exists:student_groups,id',
            // REGISTRATION NO UNIQUE
            'registration_no' => [
                'nullable',
                Rule::unique('students', 'registration_no')->where(function ($query) use ($instituteId) {
                    return $query->where('institute_id', $instituteId);
                }),
            ],
            // ROLL UNIQUE (student_sessions OR students table based on your structure)
            'roll' => [
                'required',
                Rule::unique('student_sessions', 'roll')->where(function ($query) use ($instituteId) {
                    return $query->where('institute_id', $instituteId)
                        ->where('session_id', get_option('academic_year'))
                        ->where('class_id', request()->class_id)
                        ->where('section_id', request()->section_id);
                }),
            ],
            'blood_group' => 'nullable|string|max:4',
            'religion' => 'nullable|string|max:20',
            'gender' => 'nullable|string|max:10',
            'address' => 'nullable|string',
            // EMAIL VALIDATION (users table)
            // Login is by email across all schools, so it must be unique system-wide.
            'email' => ['required', 'email', Rule::unique('users', 'email')],
            // PHONE VALIDATION (users table + students table)
            'phone' => [
                'required',
                Rule::unique('users', 'phone')->where(function ($query) use ($instituteId) {
                    return $query->where('institute_id', $instituteId);
                }),
                Rule::unique('students', 'phone')->where(function ($query) use ($instituteId) {
                    return $query->where('institute_id', $instituteId);
                }),
            ],

            'password' => 'required|string|min:6|confirmed',
            'image' => 'nullable|image|max:5120',
            'birthday' => 'nullable|date',
            'state' => 'nullable|string|max:50',
            'country' => 'nullable|string|max:100',
            'activities' => 'nullable|string|max:50',
            'remarks' => 'nullable|string|max:50',
            'information_sent_to_name' => 'nullable|string|max:30|required_with:information_sent_to_email,information_sent_to_phone',
            'information_sent_to_email' => 'nullable|string|email|max:100|required_with:information_sent_to_name,information_sent_to_phone',
            'information_sent_to_phone' => 'nullable|string|max:30|required_with:information_sent_to_name,information_sent_to_email',
            'information_sent_to_relation' => 'nullable|string|max:30',
            'information_sent_to_address' => 'nullable|string|max:100',
            'qr_code' => 'nullable|string|max:8',
        ];
    }
}
