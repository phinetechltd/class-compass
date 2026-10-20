<?php

namespace App\Traits;

use Illuminate\Http\JsonResponse;
use Symfony\Component\HttpFoundation\Response;

trait ResponseTrait
{
    /**
     * Success response.
     *
     * @param  object|array  $data
     */
    public function responseSuccess($data, string $message = 'Successful'): JsonResponse
    {
        return response()->json([
            'status' => true,
            'message' => $message,
            'data' => $data,
            'errors' => null,
        ], Response::HTTP_OK);
    }

    /**
     * Error response.
     *
     * @param  array|object  $errors
     */
    public function responseError(
        $errors,
        string $message = 'Something went wrong.',
        int $responseCode = Response::HTTP_INTERNAL_SERVER_ERROR
    ): JsonResponse {
        // Never show raw database/driver errors to users in production.
        if (! config('app.debug')) {
            $leaks = fn ($v) => is_string($v) && preg_match('/SQLSTATE|PDOException|Stack trace|Illuminate.Database|vendor.laravel/i', $v);
            if ($leaks($message)) {
                logger()->error('Hidden error message', ['message' => $message]);
                $message = 'Something went wrong. Please try again.';
            }
            if ($leaks($errors)) {
                $errors = [];
            }
        }

        return response()->json([
            'status' => false,
            'message' => $message,
            'data' => null,
            'errors' => $errors,
        ], $responseCode);
    }
}
