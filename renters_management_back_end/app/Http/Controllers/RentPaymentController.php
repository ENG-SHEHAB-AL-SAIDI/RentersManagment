<?php

namespace App\Http\Controllers;

use App\Models\Renter;
use App\Models\RentPayment;
use Illuminate\Http\Request;

class RentPaymentController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(int $renterId)
    {
        $renter = Renter::find($renterId);
        if (auth()->guard('api')->user()->id === $renter->build->user_id) {

            $rentPayments = $renter->rentPayments->groupBy('year');

            return response()->json([
                'message' => 'successful',
                'grouped_rent_payments' => $rentPayments,
            ], 200);
        }
        return response()->json([
            'message' => 'UnAuthorize access',
            'data' => null
        ], 401);
    }



    /**
     * Display the specified resource.
     */
    public function show(int $renterId , int $rentPaymentId)
    {
        $renter = Renter::find($renterId);
        if (auth()->guard('api')->user()->id === $renter->build->user_id) {

            $rentPayments = $renter->rentPayments->find($rentPaymentId);

            return response()->json([
                'message' => 'successful',
                'rent_payment' => $rentPayments,
            ], 200);
        }
        return response()->json([
            'message' => 'UnAuthorize access',
            'data' => null
        ], 401);
    }



    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        
    }


    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
