<?php

use App\Http\Controllers\BuildController;
use App\Http\Controllers\CombinDataController;
use App\Http\Controllers\RenterController;
use App\Models\Build;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

