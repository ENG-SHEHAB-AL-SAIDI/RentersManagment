<?php

namespace App\Http\Controllers;

use App\Models\Renter;
use Illuminate\Http\Client\Request;
use Illuminate\Validation\Rule;

class YearController extends Controller
{
    public function addYearToRenter(int $renterId)
    {
        $data = request()->validate([
            'year' => [
                'required',
                'date_format:Y',
                Rule::unique('rent_payments','year')->where('renter_id',$renterId),
                ]
        ]);

        $renter = Renter::find($renterId);
        if (!$renter) {
            return response()->json([
                'message' => 'renter not found',
                'Renter' => $renter
            ], 404);
        }

        for ($i = 0; $i < 12; $i++) {
            $renter->rentPayments()->create([
                'year' => $data['year'],
                'month' => str($i + 1),
                'state' => 'not_payed',
                'payed_amount' => 0,
                'remain_amount' => $renter->rent,
            ]);
        }

        if ($renter->build->statements()->where('year', $data['year'])->get()->isEmpty()) {
            for ($i = 0; $i < 12; $i++) {
                $renter->build->statements()->create([
                    'year' => $data['year'],
                    'month' => str($i + 1),
                ]);
            }
        }

        $groupedRentPayments = $renter->rentPayments->where('year',$data['year'])->groupBy('year');
		$groupedStatments = $renter->build->statements()->with(['incomes','expenses'])->where('year',$data['year'])->get()->groupBy('year');

        return response()->json([
            'message' => 'year added',
            'grouped_rent_payments' => $groupedRentPayments,
            'grouped_statements' => $groupedStatments,

        ], 200);
    }

    public function deleteYearToRenter(int $renterId)
    {
        $data = request()->validate([
            'year' => [
                'required',
                'date_format:Y',
                ]
        ]);

        $renter = Renter::find($renterId);
        if (!$renter) {
            return response()->json([
                'message' => 'renter not found',
                'Renter' => $renter
            ], 404);
        }

        $renter->rentPayments()->where('year',$data['year'])->forceDelete();
        
        return response()->json([
            'message' => 'year deleted',
        ], 200);
    }

    public function addYearToRentersGrope() {}

    public function addYearToBuild(int $buildId) {}
}
