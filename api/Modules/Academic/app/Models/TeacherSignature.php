<?php

namespace Modules\Academic\Models;

use Illuminate\Database\Eloquent\Model;

class TeacherSignature extends Model
{
    protected $fillable = [
        'institute_id',
        'teacher_id',
        'signature_image',
        'status',
        'created_at',
        'updated_at',
        'deleted_at',
    ];

    public const TABLE_NAME = 'teacher_signatures';

    protected $table = self::TABLE_NAME;
}
