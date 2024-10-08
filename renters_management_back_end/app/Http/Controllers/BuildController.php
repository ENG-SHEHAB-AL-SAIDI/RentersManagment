<?php

namespace App\Http\Controllers;

use App\Http\Requests\BuildRequst;
use App\Models\Build;

class BuildController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $builds = auth()->guard('api')->user()->builds()->with(['renters', 'renters.renterPhones'])->withCount('renters')->get();

        $builds->each(function ($build) {
            $build->renters->each(function ($renter) {
                $groupedRentPayments = $renter->rentPayments()->with('rentPaymentsInstallments')->get()->groupBy('year');
                $renter->unsetRelation('rentPayments');
                $renter->grouped_rent_payments = $groupedRentPayments;
            });
        });

        return response()->json([
            'Builds' => $builds
        ], 200);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(BuildRequst $request)
    {
        $request->validated();
        $data = $request->except('token');

        $build = auth()->guard('api')->user()->builds()->with('renters', 'renters.renterPhones')->create($data);
        $build->renters->each(function ($renter) {
            $groupedRentPayments = $renter->rentPayments()->with('rentPaymentsInstallments')->get()->groupBy('year');
            $renter->unsetRelation('rentPayments');
            $renter->grouped_rent_payments = $groupedRentPayments;
        });
        return response()->json([
            'message' => 'store successful',
            'Build' => $build
        ], 200);
    }

    /**
     * Display the specified resource.
     */
    public function show(BuildRequst $request, int $id)
    {
        $request->authorize();
        $build = Build::withCount('renters')->find($id);

        if(!$build){
            return response()->json([
                'message' => 'build not found',
                'Renter' => $build
            ], 404);
        }

        $build->renters->each(function ($renter) {
            $groupedRentPayments = $renter->rentPayments()->with('rentPaymentsInstallments')->get()->groupBy('year');
            $renter->unsetRelation('rentPayments');
            $renter->grouped_rent_payments = $groupedRentPayments;
        });
        return response()->json([
            'Build' => $build,
        ], 200);
    }



    /**
     * Update the specified resource in storage.
     */
    public function update(BuildRequst $request, int $id)
    {
        $request->validated();
        $build = Build::withCount('renters')->with('renters', 'renters.renterPhones')->find($id);

        if(!$build){
            return response()->json([
                'message' => 'build not found',
                'Renter' => $build
            ], 404);
        }

        $build->renters->each(function ($renter) {
            $groupedRentPayments = $renter->rentPayments()->with('rentPaymentsInstallments')->get()->groupBy('year');
            $renter->unsetRelation('rentPayments');
            $renter->grouped_rent_payments = $groupedRentPayments;
        });
        $build->update($request->all());
        return response()->json([
            'message' => 'update successful',
            'Build' => $build,
        ], 200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(BuildRequst $request, string $id)
    {

        $build = Build::find($id);
        if(!$build){
            return response()->json([
                'message' => 'build not found',
                'Renter' => $build
            ], 404);
        }
        $build->delete();
        return response()->json([
            'message' => 'delete successful',
        ], 200);
    }
}
