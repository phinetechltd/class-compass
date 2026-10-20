<?php

namespace Modules\Academic\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Modules\Authentication\Models\User;

class UserDevice extends Model
{
    /**
     * The attributes that are mass assignable.
     */
    protected $fillable = ['user_id', 'device_name', 'mac_id', 'ip_address', 'device_info'];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}
