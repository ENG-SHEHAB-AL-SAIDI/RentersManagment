<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\BuildController;
use App\Http\Controllers\RenterController;
use App\Http\Controllers\RentPaymentController;
use App\Http\Controllers\StatementController;
use App\Http\Controllers\YearController;
use Illuminate\Support\Facades\Route;

Route::middleware(['api'])->prefix('auth')->group(
    function ($router) {
        Route::post('/register', [AuthController::class, 'register'])->name('register');
        Route::post('/login', [AuthController::class, 'login'])->name('login');
        Route::post('/logout', [AuthController::class, 'logout'])->name('logout')->middleware('auth:api');
        Route::post('/refresh', [AuthController::class, 'refresh'])->name('refresh');
        Route::post('/me', [AuthController::class, 'me'])->name('me')->middleware('auth:api');
    }
);

Route::middleware(['api', 'auth:api'])->prefix('user')->group(
    function () {
        Route::apiResource('builds', BuildController::class);

        Route::apiResource('builds.renters', RenterController::class);
        Route::post('renters/{id}/phones', [RenterController::class, 'addPhone'])->name('renters.addPhone');
        Route::delete('renters/{id}/phones', [RenterController::class, 'destroyPhone'])->name('renters.deletePhone');
        Route::apiResource('renters.rent_payments', RentPaymentController::class);
        Route::post('rent_payments/{id}/installments', [RentPaymentController::class, 'addInstallment'])->name('rent_payments.addInstallment');
        Route::delete('rent_payments/{id}/installments/{installmentId}', [RentPaymentController::class, 'deleteInstallment'])->name('rent_payments.deleteInstallment');

        Route::apiResource('builds.statements', StatementController::class);
        Route::post('statements/{id}/incomes', [StatementController::class, 'addIncome'])->name('statements.addIncome');
        Route::delete('statements/{id}/incomes/{incomeId}', [StatementController::class, 'destroyIncome'])->name('statements.destroyIncome');
        Route::post('statements/{id}/expenses', [StatementController::class, 'addExpens'])->name('statements.addExpens');
        Route::delete('statements/{id}/expenses/{expensesId}', [StatementController::class, 'destroyExpens'])->name('statements.destroyExpens');

        Route::post('year/renters/{renterId}',[YearController::class,'addYearToRenter'])->name('addYearToRenter');
        Route::delete('year/renters/{renterId}',[YearController::class,'deleteYearToRenter'])->name('deleteYearToRenter');
        Route::post('year/builds/{renterId}', [YearController::class, 'addYearToBuild'])->name('addYearToBuild');
    }
);
