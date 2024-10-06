<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\BuildController;
use App\Http\Controllers\CombinDataController;
use App\Http\Controllers\RenterController;
use App\Http\Controllers\RentPaymentController;
use App\Models\RentPayment;
use Illuminate\Support\Facades\Route;

Route::middleware(['api'])->prefix('auth')->group(
function ($router) {
    Route::post('/register', [AuthController::class, 'register'])->name('register');
    Route::post('/login', [AuthController::class, 'login'])->name('login');
    Route::post('/logout', [AuthController::class, 'logout'])->name('logout')->middleware('auth:api');
    Route::post('/refresh', [AuthController::class, 'refresh'])->name('refresh');
    Route::post('/me', [AuthController::class, 'me'])->name('me')->middleware('auth:api');
});

Route::middleware(['api','auth:api'])->group(
function () {
    Route::apiResource('user.builds',BuildController::class);
    Route::apiResource('builds.renters',RenterController::class);
    Route::apiResource('renters.rent_payments',RentPaymentController::class);


    // Route::get('getAllData',[CombinDataController::class, 'getAllUserData']);
});
