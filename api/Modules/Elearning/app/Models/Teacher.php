<?php

namespace Modules\Elearning\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Teacher extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'first_name',
        'last_name',
        'username',
        'email',
        'phone',
        'password',
        'otp_code',
        'isVerified',
        'email_verified_at',
        'address',
        'avatar',
        'status',
        'role_id',
        'institute_id',
        'user_type',
        'facebook',
        'twitter',
        'linkedin',
        'google_plus',
        'nid',
        'platform',
        'device_info',
        'last_active_time',
        'created_by',
        'nid_number',
        'evidence',
        'proof_docs',
        'created_at',
        'updated_at',
    ];

    public const TABLE_NAME = 'teachers';

    protected $table = self::TABLE_NAME;
}
