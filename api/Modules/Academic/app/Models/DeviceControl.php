<?php

namespace Modules\Academic\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Modules\Authentication\Models\User;

class DeviceControl extends Model
{
    /**
     * The attributes that are mass assignable.
     */
    protected $fillable = ['user_id', 'device_access_type', 'device_limit', 'is_active'];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}
