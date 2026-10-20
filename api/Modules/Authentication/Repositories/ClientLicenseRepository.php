<?php

namespace Modules\Authentication\Repositories;

use App\Abstracts\EntityRepository;
use Exception;
use Illuminate\Contracts\Pagination\Paginator;
use Illuminate\Database\Eloquent\Builder as EloquentBuilder;
use Illuminate\Database\Query\Builder;
use Modules\Authentication\Models\ClientLicense;
use Symfony\Component\HttpFoundation\Response;

class ClientLicenseRepository extends EntityRepository
{
    public string $table = ClientLicense::TABLE_NAME;

    protected array $fillableColumns = [
        'institute_id',
        'plan_id',
        'license_key',
        'status',
        'issued_at',
        'expires_at',
        'student_limit',
        'branch_limit',
        'notes',
        'created_at',
        'updated_at',
        'deleted_at',
    ];

    protected function getQuery(): Builder
    {
        return parent::getQuery();
    }

    public function getAll(array $filterData = []): Paginator
    {
        $filter = $this->getFilterData($filterData);
        $query = $this->getLicenseQuery();

        if (! $filter['with_deleted']) {
            $query->whereNull("{$this->table}.deleted_at");
        }

        if (isset($filter['search']) && strlen($filter['search']) > 0) {
            $query = $this->filterSearchQuery($query, $filter['search']);
        }

        if (isset($filter['status']) && strlen($filter['status']) > 0) {
            $query->where("{$this->table}.status", $filter['status']);
        }

        if (isset($filter['institute_id']) && $filter['institute_id'] > 0) {
            $query->where("{$this->table}.institute_id", $filter['institute_id']);
        }

        return $query
            ->orderBy($filter['orderBy'], $filter['order'])
            ->paginate($filter['perPage']);
    }

    protected function getFilterData(array $filterData = []): array
    {
        $defaultArgs = [
            'perPage' => 10,
            'search' => '',
            'status' => '',
            'institute_id' => 0,
            'orderBy' => 'id',
            'order' => 'desc',
            'with_deleted' => false,
        ];

        return array_merge($defaultArgs, $filterData);
    }

    private function getLicenseQuery(): Builder
    {
        return $this->getQuery()
            ->leftJoin('institutes', 'client_licenses.institute_id', '=', 'institutes.id')
            ->leftJoin('plans', 'client_licenses.plan_id', '=', 'plans.id')
            ->select([
                'client_licenses.id',
                'client_licenses.institute_id',
                'client_licenses.plan_id',
                'client_licenses.license_key',
                'client_licenses.status',
                'client_licenses.issued_at',
                'client_licenses.expires_at',
                'client_licenses.student_limit',
                'client_licenses.branch_limit',
                'client_licenses.notes',
                'client_licenses.created_at',
                'client_licenses.updated_at',
                'client_licenses.deleted_at',
                'institutes.name as institute_name',
                'plans.name as plan_name',
            ]);
    }

    protected function filterSearchQuery(Builder|EloquentBuilder $query, string $searchedText): Builder
    {
        $searchable = "%$searchedText%";

        return $query->where(function (Builder $query) use ($searchable) {
            $query->where('client_licenses.license_key', 'LIKE', $searchable)
                ->orWhere('institutes.name', 'LIKE', $searchable)
                ->orWhere('plans.name', 'LIKE', $searchable)
                ->orWhere('client_licenses.status', 'LIKE', $searchable);
        });
    }

    /**
     * @throws Exception
     */
    public function getByColumn(string $columnName, $columnValue, array $selects = ['*']): ?object
    {
        $license = $this->getLicenseQuery()
            ->where($columnName, $columnValue)
            ->first();

        if (empty($license)) {
            throw new Exception(
                $this->getExceptionMessage(static::MESSAGE_ITEM_DOES_NOT_EXIST_MESSAGE),
                Response::HTTP_NOT_FOUND
            );
        }

        return $license;
    }

    public function getCount(array $filterData = []): int
    {
        $filter = $this->getFilterData($filterData);
        $query = $this->getQuery();

        if (! $filter['with_deleted']) {
            $query->whereNull("{$this->table}.deleted_at");
        }

        return $query->count();
    }

    /**
     * @throws Exception
     */
    public function create(array $data): object
    {
        try {
            $data = $this->prepareForDB($data);
            $id = $this->getQuery()->insertGetId($data);

            return ClientLicense::find($id);
        } catch (Exception $exception) {
            throw new Exception($exception->getMessage(), Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * @throws Exception
     */
    public function prepareForDB(array $data, ?object $item = null): array
    {
        $data = parent::prepareForDB($data, $item);

        if (empty($item)) {
            $data['created_at'] = now();
            if (empty($data['license_key'])) {
                $data['license_key'] = $this->generateLicenseKey();
            }
            if (empty($data['issued_at'])) {
                $data['issued_at'] = now()->toDateString();
            }
        } else {
            $data['updated_at'] = now();
        }

        return $data;
    }

    public function generateLicenseKey(): string
    {
        do {
            $key = strtoupper(implode('-', [
                'CC',
                bin2hex(random_bytes(2)),
                bin2hex(random_bytes(2)),
                bin2hex(random_bytes(2)),
                bin2hex(random_bytes(2)),
            ]));
        } while ($this->getQuery()->where('license_key', $key)->exists());

        return $key;
    }

    /**
     * @throws Exception
     */
    public function update(int $id, array $data): ?object
    {
        try {
            $license = ClientLicense::find($id);
            $data = $this->prepareForDB($data, $license);
            parent::update($id, $data);

            return $this->getById($id);
        } catch (Exception $exception) {
            throw new Exception($exception->getMessage(), Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    protected function getExceptionMessages(): array
    {
        $exceptionMessages = parent::getExceptionMessages();

        $licenseExceptionMessages = [
            static::MESSAGE_ITEM_DOES_NOT_EXIST_MESSAGE => 'Client license does not exist.',
            static::MESSAGE_ITEM_COULD_NOT_BE_DELETED => 'Client license could not be deleted.',
        ];

        return array_merge($exceptionMessages, $licenseExceptionMessages);
    }
}
