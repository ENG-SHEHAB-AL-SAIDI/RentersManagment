<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\BuildController;
use Illuminate\Support\Facades\Route;

Route::middleware(['api'])->prefix('auth')->group(
function ($router) {
    Route::post('/register', [AuthController::class, 'register'])->name('register');
    Route::post('/login', [AuthController::class, 'login'])->name('login');
    Route::post('/logout', [AuthController::class, 'logout'])->name('logout')->middleware('auth:api');
    Route::post('/refresh', [AuthController::class, 'refresh'])->name('refresh')->middleware('auth:api');
    Route::post('/me', [AuthController::class, 'me'])->name('me')->middleware('auth:api');
});

Route::middleware(['api','auth:api'])->prefix('user')->group(
function () {
    Route::apiResource('builds',BuildController::class);
});
