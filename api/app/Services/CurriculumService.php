<?php

namespace App\Services;

use Illuminate\Support\Facades\DB;
use InvalidArgumentException;

/**
 * Curriculum presets for Kenyan schools. Applying a preset creates the classes, a default
 * stream, subjects per class and the grading scales. It is additive and idempotent: existing
 * classes/subjects with the same name are kept, so it is safe to run again.
 *
 * A level may name its own grading scale ('grades' => key in 'scales'); otherwise it uses the
 * preset's default 'grades'. For CBC this gives PP1 – Grade 6 the 4-level rubric and Grade 7 – 12
 * the KNEC 8-level scale; for the British preset it gives A-Level its own A* – E scale.
 */
class CurriculumService
{
    public function presets(): array
    {
        return [
            'cbc' => [
                'name' => 'CBC (Competency Based Curriculum)',
                'description' => 'Kenya CBC/CBE: Pre-Primary (PP1–PP2) and Primary (Grade 1–6) graded on the 4-level rubric (EE, ME, AE, BE); Junior School (Grade 7–9) and Senior School (Grade 10–12) on the KNEC 8-level scale (EE1–BE2). Senior School has core subjects plus electives in the STEM, Social Sciences and Arts & Sports Science pathways.',
                'levels' => [
                    'Pre-Primary' => [
                        'classes' => ['PP1', 'PP2'],
                        'subjects' => ['Language Activities', 'Mathematical Activities', 'Environmental Activities', 'Psychomotor & Creative Activities', 'Religious Education Activities'],
                        'grades' => 'rubric4',
                    ],
                    'Lower Primary' => [
                        'classes' => ['Grade 1', 'Grade 2', 'Grade 3'],
                        'subjects' => ['English', 'Kiswahili', 'Mathematics', 'Environmental Activities', 'Creative Activities', 'Religious Education', 'Indigenous Language'],
                        'grades' => 'rubric4',
                    ],
                    'Upper Primary' => [
                        'classes' => ['Grade 4', 'Grade 5', 'Grade 6'],
                        'subjects' => ['English', 'Kiswahili', 'Mathematics', 'Science & Technology', 'Social Studies', 'Agriculture & Nutrition', 'Creative Arts', 'Religious Education'],
                        'grades' => 'rubric4',
                    ],
                    'Junior School' => [
                        'classes' => ['Grade 7', 'Grade 8', 'Grade 9'],
                        'subjects' => ['English', 'Kiswahili', 'Mathematics', 'Integrated Science', 'Social Studies', 'Pre-Technical Studies', 'Agriculture & Nutrition', 'Creative Arts & Sports', 'Religious Education'],
                    ],
                    'Senior School' => [
                        'classes' => ['Grade 10', 'Grade 11', 'Grade 12'],
                        // Core subjects, then the electives of all three pathways (learners take three electives).
                        'subjects' => ['English', 'Kiswahili', 'Core Mathematics', 'Essential Mathematics', 'Community Service Learning', 'Physical Education',
                            'Biology', 'Chemistry', 'Physics', 'General Science', 'Agriculture', 'Computer Studies', 'Home Science',
                            'Building & Construction', 'Electricity', 'Metalwork', 'Woodwork', 'Power Mechanics', 'Aviation', 'Media Technology', 'Marine & Fisheries',
                            'History & Citizenship', 'Geography', 'Christian Religious Education', 'Islamic Religious Education', 'Hindu Religious Education', 'Business Studies',
                            'Literature in English', 'Fasihi ya Kiswahili', 'Kenyan Sign Language', 'French', 'German', 'Arabic', 'Mandarin Chinese', 'Indigenous Language',
                            'Music & Dance', 'Theatre & Film', 'Fine Arts', 'Sports & Recreation'],
                        'pathways' => [
                            'Core' => ['English', 'Kiswahili', 'Core Mathematics or Essential Mathematics', 'Community Service Learning', 'Physical Education'],
                            'STEM' => ['Biology', 'Chemistry', 'Physics', 'General Science', 'Agriculture', 'Computer Studies', 'Home Science', 'Building & Construction',
                                'Electricity', 'Metalwork', 'Woodwork', 'Power Mechanics', 'Aviation', 'Media Technology', 'Marine & Fisheries'],
                            'Social Sciences' => ['History & Citizenship', 'Geography', 'CRE / IRE / HRE', 'Business Studies', 'Literature in English', 'Fasihi ya Kiswahili',
                                'Kenyan Sign Language', 'French', 'German', 'Arabic', 'Mandarin Chinese', 'Indigenous Language'],
                            'Arts & Sports Science' => ['Music & Dance', 'Theatre & Film', 'Fine Arts', 'Sports & Recreation'],
                        ],
                    ],
                ],
                'scales' => [
                    // Primary-level rubric (PP1 – Grade 6).
                    'rubric4' => [
                        ['EE', 75, 100, 4, 'Exceeding Expectations'],
                        ['ME', 50, 74.99, 3, 'Meeting Expectations'],
                        ['AE', 25, 49.99, 2, 'Approaching Expectations'],
                        ['BE', 0, 24.99, 1, 'Below Expectations'],
                    ],
                ],
                // Junior and Senior School: KNEC 8-level scale.
                'grades' => [
                    ['EE1', 90, 100, 8, 'Exceeding Expectations'],
                    ['EE2', 75, 89.99, 7, 'Exceeding Expectations'],
                    ['ME1', 58, 74.99, 6, 'Meeting Expectations'],
                    ['ME2', 41, 57.99, 5, 'Meeting Expectations'],
                    ['AE1', 31, 40.99, 4, 'Approaching Expectations'],
                    ['AE2', 21, 30.99, 3, 'Approaching Expectations'],
                    ['BE1', 11, 20.99, 2, 'Below Expectations'],
                    ['BE2', 0, 10.99, 1, 'Below Expectations'],
                ],
            ],
            '844' => [
                'name' => '8-4-4 (KCSE)',
                'description' => 'For secondary schools still running the last 8-4-4 cohorts (Form 3–4) with the KCSE 12-point A to E scale.',
                'levels' => [
                    'Secondary' => [
                        'classes' => ['Form 3', 'Form 4'],
                        'subjects' => ['English', 'Kiswahili', 'Mathematics', 'Biology', 'Chemistry', 'Physics', 'Geography', 'History & Government', 'CRE', 'IRE', 'HRE',
                            'Business Studies', 'Agriculture', 'Computer Studies', 'Home Science', 'Art & Design', 'Music', 'French', 'German', 'Arabic'],
                    ],
                ],
                'grades' => [
                    ['A', 80, 100, 12, 'Excellent'], ['A-', 75, 79.99, 11, 'Very good'], ['B+', 70, 74.99, 10, 'Very good'],
                    ['B', 65, 69.99, 9, 'Good'], ['B-', 60, 64.99, 8, 'Good'], ['C+', 55, 59.99, 7, 'Fair'],
                    ['C', 50, 54.99, 6, 'Fair'], ['C-', 45, 49.99, 5, 'Fair'], ['D+', 40, 44.99, 4, 'Weak'],
                    ['D', 35, 39.99, 3, 'Weak'], ['D-', 30, 34.99, 2, 'Poor'], ['E', 0, 29.99, 1, 'Poor'],
                ],
            ],
            'british' => [
                'name' => 'British (Cambridge / Edexcel)',
                'description' => 'British/International schools: Nursery and Reception, Primary (Year 1–6), Key Stage 3 (Year 7–9), IGCSE (Year 10–11, A* to G) and A-Level (Year 12–13, A* to E).',
                'levels' => [
                    'Early Years' => [
                        'classes' => ['Nursery', 'Reception'],
                        'subjects' => ['Communication & Language', 'Literacy', 'Mathematics', 'Understanding the World', 'Expressive Arts & Design', 'Physical Development', 'Personal, Social & Emotional Development'],
                    ],
                    'Primary' => [
                        'classes' => ['Year 1', 'Year 2', 'Year 3', 'Year 4', 'Year 5', 'Year 6'],
                        'subjects' => ['English', 'Mathematics', 'Science', 'Computing', 'Geography', 'History', 'Art & Design', 'Music', 'Physical Education', 'Religious Education', 'PSHE', 'Kiswahili', 'French'],
                    ],
                    'Key Stage 3' => [
                        'classes' => ['Year 7', 'Year 8', 'Year 9'],
                        'subjects' => ['English', 'Mathematics', 'Science', 'Computing', 'Geography', 'History', 'French', 'Spanish', 'Kiswahili', 'Art & Design',
                            'Design & Technology', 'Music', 'Religious Education', 'Physical Education'],
                    ],
                    'IGCSE' => [
                        'classes' => ['Year 10', 'Year 11'],
                        'subjects' => ['English Language', 'English Literature', 'Mathematics', 'Additional Mathematics', 'Biology', 'Chemistry', 'Physics', 'Combined Science',
                            'Computer Science', 'ICT', 'Geography', 'History', 'Business Studies', 'Economics', 'Accounting', 'French', 'Spanish', 'Kiswahili', 'Art & Design', 'Physical Education'],
                    ],
                    'A-Level' => [
                        'classes' => ['Year 12', 'Year 13'],
                        'subjects' => ['Mathematics', 'Further Mathematics', 'Biology', 'Chemistry', 'Physics', 'Economics', 'Business', 'Accounting', 'Computer Science',
                            'English Literature', 'Geography', 'History', 'Psychology', 'Sociology', 'Art & Design'],
                        'grades' => 'alevel',
                    ],
                ],
                'scales' => [
                    'alevel' => [
                        ['A*', 90, 100, 6, 'Outstanding'], ['A', 80, 89.99, 5, 'Excellent'], ['B', 70, 79.99, 4, 'Very good'],
                        ['C', 60, 69.99, 3, 'Good'], ['D', 50, 59.99, 2, 'Satisfactory'], ['E', 40, 49.99, 1, 'Pass'], ['U', 0, 39.99, 0, 'Ungraded'],
                    ],
                ],
                // Early Years, Primary, KS3 and IGCSE (Cambridge A* to G).
                'grades' => [
                    ['A*', 90, 100, 9, 'Outstanding'], ['A', 80, 89.99, 8, 'Excellent'], ['B', 70, 79.99, 7, 'Very good'],
                    ['C', 60, 69.99, 6, 'Good'], ['D', 50, 59.99, 5, 'Satisfactory'], ['E', 40, 49.99, 4, 'Pass'],
                    ['F', 30, 39.99, 3, 'Weak'], ['G', 20, 29.99, 2, 'Poor'], ['U', 0, 19.99, 0, 'Ungraded'],
                ],
            ],
            'college' => [
                'name' => 'College / TVET',
                'description' => 'Colleges and TVET institutions (KNEC / TVET CDACC): Artisan (KNQF level 4), Certificate (level 5) and Diploma (level 6) years with common units, graded Distinction, Credit, Pass, Fail. Add your own courses and units after applying.',
                'levels' => [
                    'Artisan' => [
                        'classes' => ['Artisan Yr 1'],
                        'subjects' => ['Communication Skills', 'Entrepreneurship Education', 'Digital Literacy', 'Life Skills', 'Occupational Safety & Health', 'Workshop Technology'],
                    ],
                    'Certificate' => [
                        'classes' => ['Certificate Yr 1', 'Certificate Yr 2'],
                        'subjects' => ['Communication Skills', 'Entrepreneurship Education', 'Digital Literacy', 'Life Skills', 'Mathematics', 'Occupational Safety & Health'],
                    ],
                    'Diploma' => [
                        'classes' => ['Diploma Yr 1', 'Diploma Yr 2', 'Diploma Yr 3'],
                        'subjects' => ['Communication Skills', 'Entrepreneurship Education', 'Digital Literacy', 'Business Mathematics', 'Research Methods', 'Industrial Attachment'],
                    ],
                ],
                'grades' => [
                    ['Distinction', 75, 100, 4, 'Distinction'],
                    ['Credit', 60, 74.99, 3, 'Credit'],
                    ['Pass', 50, 59.99, 2, 'Pass'],
                    ['Fail', 0, 49.99, 0, 'Fail'],
                ],
            ],
        ];
    }

    public function summary(): array
    {
        return collect($this->presets())->map(fn ($p, $key) => [
            'key' => $key,
            'name' => $p['name'],
            'description' => $p['description'],
            'levels' => collect($p['levels'])->map(fn ($l, $name) => array_filter([
                'name' => $name,
                'classes' => $l['classes'],
                'subjects' => $l['subjects'],
                'pathways' => $l['pathways'] ?? null,
                'grading' => collect($this->scaleFor($p, $l))->pluck(0)->implode(', '),
            ], fn ($v) => $v !== null))->values(),
            'grades' => collect($p['grades'])->map(fn ($g) => ['grade' => $g[0], 'from' => $g[1], 'to' => $g[2], 'points' => $g[3], 'remark' => $g[4]]),
        ])->values()->all();
    }

    public function current(int $instituteId): ?string
    {
        return DB::table('settings')->where(['institute_id' => $instituteId, 'name' => 'curriculum'])->value('value');
    }

    /**
     * @return array{classes_created:int, subjects_created:int, grades_created:int}
     */
    public function apply(int $instituteId, int $branchId, string $key, bool $classes = true, bool $subjects = true, bool $grades = true): array
    {
        $preset = $this->presets()[$key] ?? throw new InvalidArgumentException("Unknown curriculum: {$key}");
        $now = now();
        $stats = ['classes_created' => 0, 'subjects_created' => 0, 'grades_created' => 0];

        DB::transaction(function () use ($preset, $key, $instituteId, $branchId, $classes, $subjects, $grades, $now, &$stats) {
            $scope = ['institute_id' => $instituteId, 'branch_id' => $branchId];
            $sessionId = DB::table('settings')->where(['institute_id' => $instituteId, 'name' => 'academic_year'])->value('value');

            if ($classes || $subjects) {
                foreach ($preset['levels'] as $level) {
                    foreach ($level['classes'] as $className) {
                        $classId = DB::table('classes')->where($scope)->where('class_name', $className)->value('id');
                        if (! $classId && $classes) {
                            $classId = DB::table('classes')->insertGetId($scope + ['class_name' => $className, 'status' => 1, 'created_at' => $now, 'updated_at' => $now]);
                            DB::table('sections')->insert($scope + ['class_id' => $classId, 'section_name' => 'A', 'status' => 1, 'created_at' => $now, 'updated_at' => $now]);
                            $stats['classes_created']++;
                        }

                        if ($subjects && $classId) {
                            foreach ($level['subjects'] as $i => $subjectName) {
                                $exists = DB::table('subjects')->where($scope)->where('class_id', $classId)->where('subject_name', $subjectName)->whereNull('deleted_at')->exists();
                                if ($exists) {
                                    continue;
                                }
                                DB::table('subjects')->insert($scope + [
                                    'class_id' => $classId,
                                    'subject_name' => $subjectName,
                                    'subject_code' => $this->subjectCode($subjectName, $className),
                                    'subject_short_form' => $this->shortForm($subjectName),
                                    'sl_no' => $i + 1,
                                    'full_mark' => 100,
                                    'pass_mark' => $key === 'college' ? 50 : 40,
                                    'created_at' => $now,
                                    'updated_at' => $now,
                                ]);
                                $stats['subjects_created']++;
                            }
                        }
                    }
                }
            }

            if ($grades) {
                // Each class gets its level's scale. Only this preset's classes are re-graded, so a school
                // running two curricula (e.g. CBC and the last 8-4-4 cohorts) keeps both gradings.
                $classScale = [];
                foreach ($preset['levels'] as $level) {
                    foreach ($level['classes'] as $className) {
                        $classScale[$className] = $level['grades'] ?? 'default';
                    }
                }
                $presetClasses = DB::table('classes')->where($scope)->whereIn('class_name', array_keys($classScale))->get(['id', 'class_name']);
                DB::table('exam_grades')->where($scope)->whereIn('class_model_id', $presetClasses->pluck('id'))->delete();
                DB::table('grades')->where($scope)->whereNotIn('id', DB::table('exam_grades')->where($scope)->select('grade_id'))->delete();
                $scales = ['default' => $preset['grades']] + ($preset['scales'] ?? []);
                $gradeIds = [];
                $priority = (int) DB::table('grades')->where($scope)->max(DB::raw('CAST(priority AS UNSIGNED)'));
                foreach ($scales as $scaleKey => $rows) {
                    foreach ($rows as [$name, $low, $high, $points]) {
                        $grade = [
                            'grade_name' => $name,
                            'grade_number' => $low,
                            'grade_point' => $points,
                            'grade_range' => floor($low).'-'.floor($high),
                            'number_high' => $high,
                            'number_low' => $low,
                            'point_high' => $points,
                            'point_low' => $points,
                            'priority' => (string) (++$priority),
                        ];
                        $gradeIds[$scaleKey][] = [DB::table('grades')->insertGetId($scope + $grade + ['created_at' => $now, 'updated_at' => $now]), $grade];
                        $stats['grades_created']++;
                    }
                }

                // Class-wise grading used by the result processing.
                foreach ($presetClasses as $class) {
                    foreach ($gradeIds[$classScale[$class->class_name]] as [$gradeId, $grade]) {
                        DB::table('exam_grades')->insert($scope + $grade + [
                            'class_model_id' => $class->id,
                            'grade_id' => $gradeId,
                            'session_id' => $sessionId,
                            'created_at' => $now,
                            'updated_at' => $now,
                        ]);
                    }
                }
            }

            DB::table('settings')->updateOrInsert(
                ['institute_id' => $instituteId, 'branch_id' => $branchId, 'name' => 'curriculum'],
                ['value' => $key, 'type' => 'general', 'updated_at' => $now]
            );
        });

        return $stats;
    }

    private function scaleFor(array $preset, array $level): array
    {
        return isset($level['grades']) ? ($preset['scales'][$level['grades']] ?? $preset['grades']) : $preset['grades'];
    }

    private function shortForm(string $subject): string
    {
        $words = preg_split('/[\s&\/,-]+/', $subject, -1, PREG_SPLIT_NO_EMPTY);
        $short = count($words) > 1 ? implode('', array_map(fn ($w) => mb_substr($w, 0, 1), $words)) : mb_substr($subject, 0, 3);

        return mb_strtoupper(mb_substr($short, 0, 6));
    }

    private function subjectCode(string $subject, string $className): string
    {
        $classPart = preg_replace('/[^A-Z0-9]/', '', mb_strtoupper(preg_replace('/^(Grade|Year|Form)\s*/i', '', $className)));

        return mb_substr($this->shortForm($subject).'-'.$classPart, 0, 20);
    }
}
