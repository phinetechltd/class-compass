<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Modules\Authentication\Http\Controllers\API\AuthController;
use Modules\Authentication\Http\Controllers\API\BranchController;
use Modules\Authentication\Http\Controllers\API\ClientLicenseController;
use Modules\Authentication\Http\Controllers\API\DashboardController;
use Modules\Authentication\Http\Controllers\API\FeedbackController;
use Modules\Authentication\Http\Controllers\API\InstituteController;
use Modules\Authentication\Http\Controllers\API\InstituteImageSAASSettingController;
use Modules\Authentication\Http\Controllers\API\InstituteImageSettingController;
use Modules\Authentication\Http\Controllers\API\OnboardingsController;
use Modules\Authentication\Http\Controllers\API\PermissionController;
use Modules\Authentication\Http\Controllers\API\PlanController;
use Modules\Authentication\Http\Controllers\API\RoleController;
use Modules\Authentication\Http\Controllers\API\SAASFaqController;
use Modules\Authentication\Http\Controllers\API\SAASSubscriptionController;
use Modules\Authentication\Http\Controllers\API\UserController;
use Modules\Authentication\Http\Controllers\API\UtilityController;

// (Removed the unused Sanctum /user stub: the app authenticates with Passport.)

Route::controller(AuthController::class)->group(function () {
    // Brute-force protection: 10 attempts per minute per IP.
    Route::post('/login', 'login')->middleware('throttle:10,1');
    // Public self-registration created accounts with no school attached; schools create
    // their own users, so the endpoint is disabled.
});

Route::middleware(['auth:api', 'check.subscription'])->group(function () {
    Route::controller(AuthController::class)->group(function () {
        Route::get('/profile', 'user');
        Route::post('/logout', 'logout');
        Route::post('/change-password', 'changePassword');
        Route::post('/profile-update', 'profileUpdate');
    });

    // A school sees only its own record (InstituteController); creating, editing, deleting and
    // (de)activating schools is the platform admin's job.
    Route::apiResource('institutes', InstituteController::class)->only(['index', 'show']);
    Route::middleware('saas.admin')->group(function () {
        Route::get('institutes-status-update/{instituteId}', [InstituteController::class, 'statusUpdate']);
        Route::apiResource('institutes', InstituteController::class)->except(['index', 'show']);
    });
    Route::apiResource('branches', BranchController::class);
    Route::apiResource('permissions', PermissionController::class);
    Route::apiResource('roles', RoleController::class);
    Route::apiResource('users', UserController::class);
    Route::apiResource('plans', PlanController::class)->only(['index', 'show']);
    // Plans (and their limits) are shared by every school: only the platform admin edits them.
    Route::middleware('saas.admin')->group(fn () => Route::apiResource('plans', PlanController::class)->except(['index', 'show']));
    Route::apiResource('saas-subscriptions', SAASSubscriptionController::class);

    Route::get('client-licenses/generate-key', [ClientLicenseController::class, 'generateKey']);
    Route::get('client-licenses-status-update/{id}', [ClientLicenseController::class, 'statusUpdate']);
    Route::apiResource('client-licenses', ClientLicenseController::class);

    Route::apiResource('feedbacks', FeedbackController::class);
    Route::apiResource('saas-faqs', SAASFaqController::class);
    Route::get('saas-dashboard-data', [DashboardController::class, 'saasDashboardData']);
    Route::get('dashboard-data', [DashboardController::class, 'index']);
    Route::get('student-attendance-summery', [DashboardController::class, 'studentAttendanceSummary']);

    // Onboarding
    Route::get('onboardings-list', [OnboardingsController::class, 'index'])->middleware('saas.admin');
    Route::get('onboardings-approve/{onboardingId}', [OnboardingsController::class, 'approve'])->middleware('saas.admin');
    // Activating or approving a plan is the platform admin's job; schools only send requests.
    Route::post('/subscription/upgrade', [OnboardingsController::class, 'upgrade'])->middleware('saas.admin');

    Route::prefix('subscription')->group(function () {
        Route::get('/request-upgrade-list', [OnboardingsController::class, 'requestUpgradeList'])->middleware('saas.admin');
        Route::post('/request-upgrade', [OnboardingsController::class, 'requestUpgrade']);
        Route::get('/approve-request/{id}', [OnboardingsController::class, 'approveRequest'])->middleware('saas.admin');
        Route::post('/payment-upgrade', [OnboardingsController::class, 'paymentSubscriptions']);
    });

    Route::post('saas-settings-update', [DashboardController::class, 'saasSettingsUpdate']);
    Route::post('saas-settings-upload-logo', [DashboardController::class, 'uploadLogo']);
    Route::post('saas-settings-mail-update', [DashboardController::class, 'updateMailConfig']);
    Route::get('saas-settings-mail-config', [DashboardController::class, 'getMailConfig']);

    // Image Upload settings
    Route::apiResource('institute-image-settings', InstituteImageSettingController::class);
    Route::apiResource('institute-image-saas-settings', InstituteImageSAASSettingController::class);
});

Route::get('get-feedbacks', [FeedbackController::class, 'getFeedbacks']);
Route::get('get-saas-faqs', [SAASFaqController::class, 'getSaasFaqs']);
Route::get('get-packages', [PlanController::class, 'getPackages']);
Route::get('get-saas-settings', [DashboardController::class, 'getSAASSettings']);
Route::post('saas-subscriptions-email-store', [SAASSubscriptionController::class, 'publicStore']);

// Maintenance tools: platform admin only (they were public).
Route::middleware(['auth:api', 'saas.admin'])->group(function () {
    Route::get('system/link-storage', [UtilityController::class, 'linkStorage']);
    Route::get('system/unlink-storage', [UtilityController::class, 'unlinkStorage']);
    Route::get('system/clear-cache', [UtilityController::class, 'clearAllCache']);
    Route::get('system/all-students-get', [UtilityController::class, 'allStudentsGet']);
});
Route::get('v1/system/domain-check', [UtilityController::class, 'domainCheck'])->middleware('throttle:20,1');
