<?php

namespace Modules\Authentication\Http\Controllers\API;

use App\Helpers\DomainHelper;
use App\Http\Controllers\Controller;
use App\Traits\Authenticatable;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;

class UtilityController extends Controller
{
    use Authenticatable;

    public function linkStorage()
    {
        $publicStorage = public_path('storage');
        $target = storage_path('app/public');

        try {
            if (! File::exists($publicStorage)) {
                File::link($target, $publicStorage);

                return response()->json(['status' => 'success', 'message' => 'Storage link created.']);
            } else {
                return response()->json(['status' => 'info', 'message' => 'Storage link already exists.']);
            }
        } catch (Exception $e) {
            return response()->json(['status' => 'error', 'message' => $e->getMessage()]);
        }
    }

    public function unlinkStorage()
    {
        $publicStorage = public_path('storage');

        try {
            if (is_link($publicStorage)) {
                unlink($publicStorage);
            } elseif (is_dir($publicStorage)) {
                // Attempt to delete via Laravel
                if (! File::deleteDirectory($publicStorage)) {
                    // Fallback for stubborn directories
                    exec('rm -rf '.escapeshellarg($publicStorage));
                }
            }

            return response()->json([
                'status' => 'success',
                'message' => 'The storage link or directory has been removed.',
            ]);
        } catch (Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Failed: '.$e->getMessage(),
            ]);
        }
    }

    public function clearAllCache()
    {
        try {
            Artisan::call('config:cache');
            Artisan::call('cache:clear');
            Artisan::call('route:clear');
            Artisan::call('view:clear');

            return response()->json(['status' => 'success', 'message' => 'All caches cleared.']);
        } catch (Exception $e) {
            return response()->json(['status' => 'error', 'message' => $e->getMessage()]);
        }
    }

    public function allStudentsGet(Request $request)
    {
        $students = DB::table('student_sessions as ss')
            ->join('students as s', 's.id', '=', 'ss.student_id')
            ->select(
                'ss.qr_code',
                's.first_name',
                's.last_name'
            )
            ->whereNotNull('ss.qr_code')
            ->get();

        return $this->responseSuccess(
            $students,
            _lang('Students with QR code fetched successfully.')
        );
    }

    public function domainCheck(Request $request): JsonResponse
    {
        $domain = $request->query('domain');
        $info = DomainHelper::getDomainInfo($domain);

        // Add expiration warning
        $warning = DomainHelper::expirationWarning($info['expiration'] ?? null);
        $info['expiration_warning'] = $warning;

        return response()->json([
            'success' => true,
            'data' => $info,
        ]);
    }
}
