<?php

namespace App\Http\Controllers;

use App\Http\Requests\BuildRequest;
use App\Http\Requests\BuildStoreRequst;
use App\Http\Requests\BuildUpdateRequst;
use App\Models\Build;
use Illuminate\Http\Request;

class BuildController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {

        $builds = auth()->guard('api')->user()->builds()->get();
        return response()->json([
            "Builds"=>$builds
        ],200);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(BuildStoreRequst $request)
    {
        $request->validated();
        $data = $request->except('token');

        $build = auth()->guard('api')->user()->builds()->create($data);
        return response()->json([
            'message'=>'Store done',
            'build' => $build,
        ],200);
    }

    /**
     * Display the specified resource.
     */
    public function show(int $id)
    {
        $build = Build::find($id);

        if(auth()->guard('api')->user()->id === $build->user_id){
            return response()->json([
                'message'=>'done',
                "Build" => $build
            ],200);
        }

        return response()->json([
            'message' => 'UnAuthorize access',
            'data' => null
        ],401);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(BuildUpdateRequst $request, int $id)
    {
        $request->validated();

        $build = Build::find($id);
        $build->name = $request->query('name');
        $build->save();
        return response()->json([
            'message'=>'update done',
            'build' => $build,
        ],200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $build = Build::find($id);

        if(auth()->guard('api')->user()->id === $build->user_id){
            $build->delete();
            return response()->json([
                'message'=>'delete done',
                'Build' => $build
            ],200);
        }

        return response()->json([
            'message' => 'UnAuthorize access',
            'data' => null
        ],401);
    }
}
