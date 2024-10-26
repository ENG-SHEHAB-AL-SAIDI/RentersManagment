<?php

namespace App\Http\Controllers;

use App\Models\Build;
use App\Models\Renter;
use Illuminate\Http\Request;

class CombinDataController extends Controller
{
    public function getAllUserData()
    {
        $builds = auth()->guard('api')->user()->builds()->withCount('renters')->get();
        $builds = $builds->load('renters','renters.renterPhones');

        $builds->each(function ($build) {
            $build->renters->each(function ($renter) {
                $groupedRentPayments = $renter->rentPayments->groupBy('year');
                $renter->groupedRentPayments = $groupedRentPayments;
            });
        });


        return response()->json([
            'Builds' => $builds
        ], 200);
    }
}
