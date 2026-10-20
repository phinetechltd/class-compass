<?php

namespace App\Support;

use Illuminate\Validation\DatabasePresenceVerifier;

/**
 * "exists:students,id" and "unique:..." rules only look at the logged-in user's school,
 * so a school cannot reference (or be blocked by) another school's records.
 */
class TenantPresenceVerifier extends DatabasePresenceVerifier
{
    protected function table($table)
    {
        $query = parent::table($table);
        $id = Tenancy::instituteId();
        if ($id !== null && Tenancy::isTenantTable($table)) {
            $query->where('institute_id', $id);
        }

        return $query;
    }
}
