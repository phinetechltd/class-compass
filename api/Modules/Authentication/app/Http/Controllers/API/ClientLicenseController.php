<?php

namespace Modules\Authentication\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Traits\RequestSanitizerTrait;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Modules\Authentication\Http\Requests\ClientLicense\ClientLicenseStoreRequest;
use Modules\Authentication\Http\Requests\ClientLicense\ClientLicenseUpdateRequest;
use Modules\Authentication\Models\ClientLicense;
use Modules\Authentication\Repositories\ClientLicenseRepository;

class ClientLicenseController extends Controller
{
    use RequestSanitizerTrait;

    public function __construct(private ClientLicenseRepository $clientLicense) {}

    public function index(Request $request): JsonResponse
    {
        try {
            return $this->responseSuccess(
                $this->clientLicense->getAll($request->all()),
                'Client license has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function store(ClientLicenseStoreRequest $request): JsonResponse
    {
        try {
            return $this->responseSuccess(
                $this->clientLicense->create($request->all()),
                'Client license has been created successfully.'
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function show(int $id): JsonResponse
    {
        try {
            return $this->responseSuccess(
                $this->clientLicense->getById($id),
                'Client license has been fetched successfully.'
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function update(ClientLicenseUpdateRequest $request, int $id): JsonResponse
    {
        try {
            return $this->responseSuccess(
                $this->clientLicense->update($id, $this->getUpdateRequest($request)),
                'Client license has been updated successfully.'
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function destroy(int $id): JsonResponse
    {
        try {
            $license = $this->clientLicense->getById($id);
            if (! $license) {
                return $this->responseError([], 'Client license not found.');
            }

            return $this->responseSuccess(
                $this->clientLicense->delete($id),
                'Client license has been deleted successfully.'
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function generateKey(): JsonResponse
    {
        try {
            return $this->responseSuccess(
                ['license_key' => $this->clientLicense->generateLicenseKey()],
                'License key generated successfully.'
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }

    public function statusUpdate(int $id): JsonResponse
    {
        try {
            $license = ClientLicense::find($id);

            if (! $license) {
                return $this->responseError([], 'Client license not found.', 404);
            }

            $license->status = $license->status === 'active' ? 'suspended' : 'active';
            $license->save();

            return $this->responseSuccess(
                ['status' => $license->status],
                'Client license status updated successfully.'
            );
        } catch (Exception $exception) {
            return $this->responseError([], $exception->getMessage(), $exception->getCode());
        }
    }
}
