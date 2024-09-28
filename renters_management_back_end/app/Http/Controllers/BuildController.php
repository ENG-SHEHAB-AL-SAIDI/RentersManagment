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

        $builds = auth()->guard('api')->user()->builds()->withCount('renters')->get();
        return response()->json([
            'Builds' => $builds->load('renters','renters.renterPhones','renters.RentPayments')
        ], 200);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(BuildRequst $request)
    {
        $request->validated();
        $data = $request->except('token');

        $build = auth()->guard('api')->user()->builds()->create($data);
        return response()->json([
                'message' => 'store successful',
                'Build' => $build->load('renters','renters.renterPhones','renters.RentPayments')
        ], 200);
    }

    /**
     * Display the specified resource.
     */
    public function show(int $id)
    {
        $build = Build::withCount('renters')->find($id);

        if (auth()->guard('api')->user()->id === $build->user_id) {
            return response()->json([
                'Build' => $build->load('renters','renters.renterPhones','renters.RentPayments')
            ], 200);
        }

        return response()->json([
            'message' => 'UnAuthorize access',
            'data' => null
        ], 401);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(BuildRequst $request, int $id)
    {
        $request->validated();
        $build = Build::withCount('renters')->find($id);
        $build->update($request->all());
        return response()->json([
            'message' => 'update successful',
            'Build' => $build->load('renters','renters.renterPhones','renters.RentPayments'),
        ], 200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(BuildRequst $request,string $id)
    {
        if($request->authorize()){
            $build = Build::withCount('renters')->find($id);
            $build->delete();
            return response()->json([
                'message' => 'delete successful',
                'Build' => $build->load('renters','renters.renterPhones','renters.RentPayments')
            ], 200);
        }
        return response()->json([
            'message' => 'UnAuthorize access',
            'data' => null
        ], 401);
    }
}
