<?php

namespace App\Http\Controllers;

use App\Http\Requests\RentPaymentRequest;
use App\Models\Renter;
use App\Models\RentPayment;

class RentPaymentController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(int $renterId)
    {
        $rentPayments = RentPayment::where('renter_id', $renterId)->with('rentPaymentsInstallments')->get()->groupBy('year');
        return response()->json([
            'message' => 'successful',
            'grouped_rent_payments' => $rentPayments,
        ], 200);
    }



    /**
     * Display the specified resource.
     */
    public function show(int $renterId, int $rentPaymentId)
    {
        $rentPayment = RentPayment::with('rentPaymentsInstallments')->find($rentPaymentId);
        if (!$rentPayment) {
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
        if (!$rentPayment) {
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
        if (!$rentPayment) {
            return response()->json([
                'message' => 'not found',
                'rent_payment' => $rentPayment,
            ], 404);
        }
        $rentPayment->forceDelete();
        return response()->json([
            'message' => 'Delete Successful',
        ], 200);
    }


    public function addInstallment(RentPaymentRequest $request, int $rentPaymentId)
    {
        $data = $request->validated();
        $rentPayment = RentPayment::find($rentPaymentId);
        if (!$rentPayment) {
            return response()->json([
                'message' => 'payment not found',
                'rent_payment' => $rentPayment,
            ], 404);
        }

        // $statement = $rentPayment->renter->build->statements()->where('year', $rentPayment->year)->where('month', $rentPayment->month)->get()->first();
        // $income = $statement->incomes()->create([
        //     'date' => $data['date'],
        //     'amount' => $data['amount'],
        //     'paymentType' => $data['paymentType'],
        //     'paymentID' => $data['paymentID']??0,
        //     'describe' => $data['note']??null,
        // ]);


        $installment = $rentPayment->rentPaymentsInstallments()->create([
            'date' => $data['date'],
            'amount' => $data['amount'],
            'notes' => $data['note']??null,
        ]);
        $rentPayment->remain_amount -= $data['amount'];
        $rentPayment->payed_amount += $data['amount'];
        if ($rentPayment->payed_amount == 0) {
            $rentPayment->state = 'not_payed';
        } elseif ($rentPayment->remain_amount == 0) {
            $rentPayment->state = 'payed';
        } else {
            $rentPayment->state = 'partially_payed';
        }
        $rentPayment->save();

        return response()->json([
            'message' => 'Installment Add Successful',
            'remain_amount' => number_format($rentPayment->remain_amount, 2,'.',''),
            'payed_amount' =>  number_format($rentPayment->payed_amount, 2,'.',''),
            'state' => $rentPayment->state,
            'installment' => $installment
        ], 200);
    }


    public function deleteInstallment(int $rentPaymentId, int $installmentId)
    {
        $rentPayment = RentPayment::find($rentPaymentId);
        if (!$rentPayment) {
            return response()->json([
                'message' => 'payment not found',
                'rent_payment' => $rentPayment,
            ], 404);
        }
        $installment = $rentPayment->rentPaymentsInstallments()->find($installmentId);

        if (!$installment) {
            return response()->json([
                'message' => 'installment not found',

            ], 404);
        }
        $rentPayment->remain_amount += $installment->amount;
        $rentPayment->payed_amount -= $installment->amount;
        if ($rentPayment->payed_amount == 0) {
            $rentPayment->state = 'not_payed';
        } elseif ($rentPayment->remain_amount == 0) {
            $rentPayment->state = 'payed';
        } else {
            $rentPayment->state = 'partially_payed';
        }
        $rentPayment->save();

        $installment->forceDelete();
        return response()->json([
            'message' => 'Installment Delete Successful',
            'remain_amount' => $rentPayment->remain_amount,
            'payed_amount' => $rentPayment->payed_amount,
            'state' => $rentPayment->state
        ], 200);
    }
}
