<?php

namespace App\Services;

use Illuminate\Support\Facades\DB;

/**
 * Roles (Super Admin, Teacher, Student, Parent...) are stored per institute and branch.
 * New schools and new branches got none, so admitting learners or adding staff failed.
 * This copies the standard roles and their permissions from a template branch.
 */
class RoleProvisioner
{
    /** Roles that belong to a school (the platform "SAAS Admin" role is never copied). */
    private const EXCLUDE = ['SAAS Admin'];

    public function ensure(int $instituteId, int $branchId): int
    {
        $existing = DB::table('roles')->where(['institute_id' => $instituteId, 'branch_id' => $branchId])->pluck('name')->all();

        // Template: another branch of the same school, otherwise the demo/default school.
        $templateBranch = DB::table('roles')->where('institute_id', $instituteId)->where('branch_id', '!=', $branchId)->value('branch_id');
        $template = $templateBranch
            ? ['institute_id' => $instituteId, 'branch_id' => $templateBranch]
            : DB::table('roles')->select('institute_id', 'branch_id')->orderBy('id')->first();
        if (! $template) {
            return 0;
        }
        $template = (array) $template;

        $created = 0;
        $now = now();
        $roles = DB::table('roles')->where($template)->whereNotIn('name', array_merge(self::EXCLUDE, $existing))->get();
        foreach ($roles as $role) {
            $newId = DB::table('roles')->insertGetId([
                'name' => $role->name,
                'guard_name' => $role->guard_name,
                'institute_id' => $instituteId,
                'branch_id' => $branchId,
                'created_at' => $now,
                'updated_at' => $now,
            ]);
            $permissions = DB::table('role_has_permissions')->where('role_id', $role->id)->pluck('permission_id');
            DB::table('role_has_permissions')->insert($permissions->map(fn ($p) => ['permission_id' => $p, 'role_id' => $newId])->all());
            $created++;
        }

        if ($created) {
            app()['cache']->forget(config('permission.cache.key'));
        }

        return $created;
    }

    public function roleId(int $instituteId, int $branchId, string $name): ?int
    {
        $find = fn () => DB::table('roles')->where(['institute_id' => $instituteId, 'branch_id' => $branchId, 'name' => $name])->value('id');

        $id = $find();
        if (! $id) {
            $this->ensure($instituteId, $branchId);
            $id = $find();
        }

        return $id ? (int) $id : null;
    }

    /**
     * The logged-in user's school role as {id, name} (drop-in for the old DB::table('roles') lookups).
     */
    public static function schoolRole(string $name): ?object
    {
        $id = app(self::class)->roleId((int) get_institute_id(), (int) get_branch_id(), $name);

        return $id ? (object) ['id' => $id, 'name' => $name] : null;
    }
}
