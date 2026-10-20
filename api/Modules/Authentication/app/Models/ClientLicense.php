<?php

namespace Modules\Authentication\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class ClientLicense extends Model
{
    use SoftDeletes;

    public const TABLE_NAME = 'client_licenses';

    protected $fillable = [
        'institute_id',
        'plan_id',
        'license_key',
        'status',
        'issued_at',
        'expires_at',
        'student_limit',
        'branch_limit',
        'notes',
    ];

    protected $casts = [
        'institute_id' => 'integer',
        'plan_id' => 'integer',
        'issued_at' => 'date',
        'expires_at' => 'date',
        'student_limit' => 'integer',
        'branch_limit' => 'integer',
    ];

    public function institute(): BelongsTo
    {
        return $this->belongsTo(Institute::class);
    }

    public function plan(): BelongsTo
    {
        return $this->belongsTo(Plan::class);
    }

    public function isActive(): bool
    {
        return $this->status === 'active'
            && ($this->expires_at === null || now()->lte($this->expires_at));
    }
}
