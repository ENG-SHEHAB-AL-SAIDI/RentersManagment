<?php

namespace App\Http\Controllers;

use App\Http\Requests\RentPaymentRequest;
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
        $rentPayments = RentPayment::where('renter_id',$renterId)->with('rentPaymentsInstallments')->get()->groupBy('year');
            return response()->json([
                'message' => 'successful',
                'grouped_rent_payments' => $rentPayments,
            ], 200);
    }



    /**
     * Display the specified resource.
     */
    public function show(int $renterId , int $rentPaymentId)
    {
        $rentPayment = RentPayment::with('rentPaymentsInstallments')->find($rentPaymentId);
        if(!$rentPayment){
            return response()->json([
                'message' => 'not found',
                'rent_payment' => $rentPayment,
            ], 404);
        }
            return response()->json([
                'message' => 'successful',
                'rent_payment' => $rentPayment,
            ], 200);
    }



    /**
     * Store a newly created resource in storage.
     */
    public function store(RentPaymentRequest $request, int $renterId)
    {
        $data = $request->validated();
        $rentPayments = Renter::find($renterId)->rentPayments()->create($data)->unsetRelation('renter');;
        return response()->json([
            'message' => 'successful',
            'rent_payment' => $rentPayments,
        ], 200);
    }


    /**
     * Update the specified resource in storage.
     */
    public function update(RentPaymentRequest $request, int $rentPaymentId)
    {
        $data = $request->validated();
        $rentPayment = RentPayment::with('rentPaymentsInstallments')->find($rentPaymentId);
        if(!$rentPayment){
            return response()->json([
                'message' => 'not found',
                'rent_payment' => $rentPayment,
            ], 404);
        }
        $rentPayment->update($data);

        return response()->json([
            'message' => 'Update Successful',
            'rent_payment' => $rentPayment,
        ], 200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(int $rentPaymentId)
    {
        $rentPayment = RentPayment::find($rentPaymentId);
        if(!$rentPayment){
            return response()->json([
                'message' => 'not found',
                'rent_payment' => $rentPayment,
            ], 404);
        }
            return response()->json([
                'message' => 'Delete Successful',
            ], 200);
    }
}
