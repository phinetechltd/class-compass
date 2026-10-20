<?php

use Illuminate\Support\Facades\Route;
use Modules\Gateways\Http\Controllers\API\OnlineFeePaymentController;
use Modules\Gateways\Http\Controllers\API\PaymentController;

Route::middleware(['auth:api', 'check.subscription'])->group(function () {
    // Digital Payment API
    Route::get('digital-payment', [PaymentController::class, 'index']);
    Route::put('digital-payment/{settingId}', [PaymentController::class, 'update']);
    Route::post('digital-payment', [PaymentController::class, 'payment']);
    Route::get('digital-payment-status/{settingId}', [PaymentController::class, 'statusUpdate']);

    Route::get('saas-digital-payment', [PaymentController::class, 'saasIndex']);
    Route::put('saas-digital-payment/{settingId}', [PaymentController::class, 'saasUpdate']);
    Route::get('saas-digital-payment-status/{settingId}', [PaymentController::class, 'saasStatusUpdate']);

    // Online school-fee payments (parents and students)
    Route::prefix('online-fees')->controller(OnlineFeePaymentController::class)->group(function () {
        Route::get('due', 'due');
        Route::post('pay', 'pay')->middleware('throttle:10,1');
        Route::get('payments', 'history');
        Route::get('payments/{paymentId}', 'status')->middleware('throttle:60,1');
    });

    // School admin
    Route::get('online-fee-payments', [OnlineFeePaymentController::class, 'adminIndex']);
    Route::post('digital-payment/mpesa/test', [OnlineFeePaymentController::class, 'testMpesa'])->middleware('throttle:10,1');
});

// Gateway callbacks (called by Safaricom / Paystack, no user session)
Route::post('payment/mpesa/callback/{paymentId}/{token}', [OnlineFeePaymentController::class, 'mpesaCallback'])
    ->middleware('throttle:120,1')->name('mpesa.callback');
Route::post('payment/paystack/webhook', [OnlineFeePaymentController::class, 'paystackWebhook'])
    ->middleware('throttle:120,1')->name('paystack.webhook');
