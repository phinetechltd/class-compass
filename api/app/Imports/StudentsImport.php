<?php

namespace App\Imports;

use Illuminate\Support\Collection;
use Maatwebsite\Excel\Concerns\ToCollection;
use Maatwebsite\Excel\Concerns\WithHeadingRow;

class StudentsImport implements ToCollection, WithHeadingRow
{
    public $data = [];

    public function collection(Collection $rows)
    {
        foreach ($rows as $row) {
            // Skip rows missing required fields
            if (empty($row['roll_no']) || empty($row['name'])) {
                continue;
            }

            // Normalize and map fields
            $this->data[] = [
                'roll_no' => trim($row['roll_no']),
                'name' => trim($row['name']),
                'registration_no' => $row['registration_no'] ?? null,
                'gender' => $row['gender'] ?? null,
                'religion' => $row['religion'] ?? null,
                'fathers_name' => $row['fathers_name'] ?? null,
                'mothers_name' => $row['mothers_name'] ?? null,
                'guardian_name' => $row['guardian_name'] ?? null,
                'guardian_number' => $row['guardian_number'] ?? null,
                'address' => $row['address'] ?? null,
                'mobile_no' => $row['mobile_no'] ?? null,
            ];
        }
    }
}
