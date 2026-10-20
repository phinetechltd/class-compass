<?php

namespace Modules\Hostel\Models;

use Illuminate\Database\Eloquent\Model;
use Modules\Academic\Models\Student;

class RoomMember extends Model
{
    protected $fillable = [
        'institute_id',
        'branch_id',
        'room_id',
        'student_id',
    ];

    /**
     * The student assigned to this room member.
     */
    public function student()
    {
        return $this->belongsTo(Student::class, 'student_id', 'id')
            ->with('user:id,name,email,phone'); // eager load user info
    }

    /**
     * The room this member belongs to.
     */
    public function room()
    {
        return $this->belongsTo(Room::class, 'room_id', 'id')
            ->with('hostelCategory:id,standard'); // eager load hostel category
    }
}
