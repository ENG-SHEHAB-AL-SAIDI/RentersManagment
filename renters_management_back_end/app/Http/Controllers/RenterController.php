<?php

namespace App\Http\Controllers;

use App\Http\Requests\RenterRequst;
use App\Models\Build;
use Illuminate\Support\Arr;

class RenterController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index($buildId)
    {
        $build = Build::find($buildId);
        if (auth()->guard('api')->user()->id === $build->user_id) {
            $renters = $build->renters->load('renterPhones');
            return response()->json([
                'message' => 'successful',
                'build' => $renters,
            ], 200);
        }
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(RenterRequst $request, $buildId)
    {
        if($request->authorize()){
            $data = $request->validated();
            $phones = $data['phones']; // Store the password in a separate variable
            $data = Arr::except($data, ['phones']);

            $build = Build::find($buildId);
            $renter = $build->renters()->create($data);
            foreach ($phones as $phone) {
                $renter->addPhone($phone);
            }
            return response()->json([
                'renter' => $renter->load('renterPhones'),
            ], 200);

        }
    }

    /**
     * Display the specified resource.
     */
    public function show(int $buildId, int $renterId)
    {
        $build = Build::find($buildId);
        if (auth()->guard('api')->user()->id === $build->user_id) {
            $renter = $build->renters->find($renterId);
            return response()->json([
                'message' => 'successful',
                'build' => $renter->load('renterPhones'),
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
    public function update(RenterRequst $request,int $buildId, int $renterId)
    {
        if($request->authorize()){
            $data = $request->validated();
            $phones = $data['phones']; // Store the password in a separate variable
            $data = Arr::except($data, ['phones']);
            $build = Build::find($buildId);
            $renter = $build->renters->find($renterId);

            $renter->update($data);

            foreach ($phones as $phone) {
                $renter->addPhone($phone);
            }
            return response()->json([
                'message' => 'update successful',
                'renter' => $renter->load('renterPhones')
            ], 200);
        }
        return response()->json([
            'message' => 'UnAuthorize access',
            'data' => null
        ], 401);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(RenterRequst $request, int $buildId, int $renterId)
    {
        if($request->authorize()){
            $build = Build::find($buildId);
            $renter = $build->renters->find($renterId);
            return response()->json([
                'message' => 'delete successful',
                'Build' => $renter
            ], 200);
        }
        return response()->json([
            'message' => 'UnAuthorize access',
            'data' => null
        ], 401);
    }
}
