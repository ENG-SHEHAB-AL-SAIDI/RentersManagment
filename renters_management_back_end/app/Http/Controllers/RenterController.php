<?php

namespace App\Http\Controllers;

use App\Http\Requests\RenterRequst;
use App\Models\Build;
use App\Models\Renter;
use Illuminate\Support\Arr;

class RenterController extends Controller
{

    public function addPhone(RenterRequst $request, int $renterId)
    {
        $data = $request->validated();
        $renter = Renter::find($renterId);
        if (!$renter) {
            return response()->json([
                'message' => 'renter not found',
                'Renter' => $renter
            ], 404);
        }
        $renter->addPhone($data['phone']);
        return response()->json([
            'message' => 'phone added',
        ], 200);
    }


    public function destroyPhone(RenterRequst $request, int $renterId)
    {
        $data = $request->validated();
        $renter = Renter::find($renterId);
        if (!$renter) {
            return response()->json([
                'message' => 'renter not found',
                'Renter' => $renter
            ], 404);
        }
        $isDeleted = $renter->renterPhones()->where('renter_id', $renterId)->where('phone', $data['phone'])->forceDelete();
        if($isDeleted){
            return response()->json([
                'message' => 'phone deleted',
            ], 200);
        }

        return response()->json([
            'message' => 'phone is already deleted or some error happened',
        ], 500);
    }
    /**
     * Display a listing of the resource.
     */
    public function index($buildId)
    {

        $renters = Renter::where('build_id', $buildId)->with('renterPhones')->get();
        if ($renters) {
            $renters->each(function ($renter) {
                $groupedRentPayments = $renter->rentPayments()->with('rentPaymentsInstallments')->get()->groupBy('year');
                $renter->unsetRelation('rentPayments');
                $renter->grouped_rent_payments = $groupedRentPayments;
            });
        }
        return response()->json([
            'message' => 'successful',
            'Renters' => $renters,
        ], 200);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(RenterRequst $request, $buildId)
    {

        $data = $request->validated();
        if (array_key_exists('phones', $data)) {
            $phones = $data['phones'];
            $data = Arr::except($data, ['phones']);
        }

        $build = Build::find($buildId);
        if (!$build) {
            return response()->json(['error' => 'Building not found'], 404);
        }

        $renter = $build->renters()->create($data);

        if (array_key_exists('phones', $data)) {
            foreach ($phones as $phone) {
                $renter->addPhone($phone);
            }
        }
        $renter->load('renterPhones');
        $groupedRentPayments = $renter->rentPayments->groupBy('year');
        $renter->unsetRelation('rentPayments');
        $renter->grouped_rent_payments = $groupedRentPayments;


        return response()->json([
            'Renter' => $renter,
        ], 200);
    }

    /**
     * Display the specified resource.
     */
    public function show(int $buildId, int $renterId)
    {
        $renter = Renter::where('build_id', $buildId)->with('renterPhones')->find($renterId);

        if (!$renter) {
            return response()->json([
                'message' => 'renter not found',
                'Renter' => $renter
            ], 404);
        }


        $groupedRentPayments = $renter->rentPayments()->with('rentPaymentsInstallments')->get()->groupBy('year');
        $renter->unsetRelation('rentPayments');
        $renter->grouped_rent_payments = $groupedRentPayments;

        return response()->json([
            'message' => 'successful',
            'Renter' => $renter,
        ], 200);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(RenterRequst $request, int $buildId, int $renterId)
    {

        $data = $request->validated();

        if (array_key_exists('phones', $data)) {
            $phones = $data['phones']; // Store the password in a separate variable
            $data = Arr::except($data, ['phones']);
        }
        $renter = Renter::where('build_id', $buildId)->with('renterPhones')->find($renterId);

        if (!$renter) {
            return response()->json([
                'message' => 'renter not found',
                'Renter' => $renter
            ], 404);
        }

        $renter->update($data);


        $groupedRentPayments = $renter->rentPayments()->with('rentPaymentsInstallments')->get()->groupBy('year');
        $renter->unsetRelation('rentPayments');
        $renter->grouped_rent_payments = $groupedRentPayments;

        if (array_key_exists('phones', $data)) {
            foreach ($phones as $phone) {
                $renter->addPhone($phone);
            }
        }

        return response()->json([
            'message' => 'update successful',
            'Renter' => $renter
        ], 200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(RenterRequst $request, int $buildId, int $renterId)
    {

        $renter = Renter::where('build_id', $buildId)->find($renterId);
        $renter->delete();
        if (!$renter) {
            return response()->json([
                'message' => 'renter not found',
            ], 404);
        }
        return response()->json([
            'message' => 'delete successful',
        ], 200);
    }
}
