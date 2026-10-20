<?php

namespace Modules\Authentication\Http\Requests\ClientLicense;

use Illuminate\Foundation\Http\FormRequest;

class ClientLicenseStoreRequest extends FormRequest
{
    /**
     * Get the validation rules that apply to the request.
     */
    public function rules(): array
    {
        return [
            'institute_id' => ['required', 'exists:institutes,id'],
            'plan_id' => ['nullable', 'exists:plans,id'],
            'license_key' => ['nullable', 'string', 'max:191', 'unique:client_licenses,license_key'],
            'status' => ['nullable', 'in:active,expired,suspended,revoked'],
            'issued_at' => ['nullable', 'date'],
            'expires_at' => ['nullable', 'date', 'after_or_equal:issued_at'],
            'student_limit' => ['nullable', 'integer', 'min:0'],
            'branch_limit' => ['nullable', 'integer', 'min:0'],
            'notes' => ['nullable', 'string', 'max:2000'],
        ];
    }

    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }
}
