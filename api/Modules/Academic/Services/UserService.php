<?php

declare(strict_types=1);

namespace Modules\Academic\Services;

use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Modules\Academic\Repositories\UserRepository;
use Modules\Authentication\Models\User;

class UserService
{
    public function __construct(
        private readonly UserRepository $userRepository
    ) {}

    /**
     * Get categories by filtering args.
     */
    public function get(array $args = []): Collection|Builder
    {
        $orderBy = empty($args['order_by']) ? 'id' : $args['order_by']; // column name
        $order = empty($args['order']) ? 'asc' : $args['order']; // asc, desc
        $query = User::where('institute_id', get_institute_id())->where('branch_id', get_branch_id())->orderBy($orderBy, $order);

        if (isset($args['is_query']) && $args['is_query']) {
            return $query;
        }

        return $query->get();
    }

    public function getUsersAll(): Collection
    {
        return $this->userRepository->all();
    }

    public function getUsers(array $filter = [], int $perPage = 100): LengthAwarePaginator
    {
        return $this->userRepository->paginate($perPage, $filter);
    }

    public function findUserById(int $id): ?User
    {
        return $this->userRepository->show((int) $id);
    }

    public function createOrUpdateUser(array $data, $id = null, $request = null): ?User
    {
        $data = $this->prepareForDB($data, $request);

        if ($id === null) {
            $data['institute_id'] = get_institute_id();
            $data['branch_id'] = get_branch_id();

            return $this->userRepository->create($data);
        } else {
            $result = $this->userRepository->update($data, (int) $id);

            if ($result) {
                return $this->findUserById((int) $id);
            } else {
                return null;
            }
        }
    }

    public function deleteUserById(int $id)
    {
        return $this->userRepository->delete($id);
    }

    public function getUsersByExistType($userType): Collection
    {
        return User::where('user_type', '=', $userType)
            ->select('id', 'name', 'phone', 'user_type')
            ->get();
    }

    public function getUsersByExcludedParentAndStudent(): Collection
    {
        return User::where('user_type', '!=', 'Parent')
            ->where('user_type', '!=', 'Student')
            ->orderBy('id', 'ASC')->get();
    }

    public function prepareForDB(array $data, ?Request $request = null): array
    {
        $preparedData[] = null;
        if (isset($data['email']) && ! empty($data['email'])) {
            $preparedData['email'] = $data['email'];
        }

        if (isset($data['phone']) && ! empty($data['phone'])) {
            $preparedData['phone'] = $data['phone'];
        }

        // Image Upload (SAFE)
        // if ($request && $request->hasFile('image') && $request->file('image')->isValid()) {
        //     $preparedData['image'] = fileUploader(
        //         'users/',
        //         'png',
        //         $request->file('image')
        //     );
        // }

        if (! empty($data['name'])) {
            $preparedData['name'] = $data['name'];
            $preparedData['user_type'] = $data['user_type'];
            $preparedData['role_id'] = $data['role_id'];
            $preparedData['image'] = $data['image'] ?? null;
            $preparedData['facebook'] = $data['facebook'] ?? '#';
            $preparedData['twitter'] = $data['twitter'] ?? '#';
            $preparedData['linkedin'] = $data['linkedin'] ?? '#';
            $preparedData['google_plus'] = $data['google_plus'] ?? '#';
        } else {
            $preparedData['name'] = $data['first_name'];
            $preparedData['user_type'] = 'Student';
        }

        if (isset($data['password']) && ! empty($data['password'])) {
            $preparedData['password'] = Hash::make($data['password']);
        }

        return $preparedData;
    }

    public function getUsersByExcludedType($userType): Collection
    {
        return User::select('id', 'name', 'user_type')
            ->whereNotIn('user_type', [
                $userType,
                'SAAS Admin',
                'Super Admin',
                'System Admin',
                'Parent',
                'Student',
            ])
            ->with('userPayroll')
            ->orderByDesc('id')
            ->get();
    }
}
