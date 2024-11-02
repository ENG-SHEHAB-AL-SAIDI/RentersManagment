<?php

namespace App\Http\Controllers;

use App\Http\Requests\StatementRequest;
use App\Models\Statement;
use Illuminate\Http\Request;

class StatementController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index($buildId)
    {

        $statements = Statement::where('build_id', $buildId)->with(['incomes','expenses'])->get()->groupBy('year');
        return response()->json([
            'message' => 'successful',
            'GropedStatements' => $statements,
        ], 200);
    }


    /**
     * Display the specified resource.
     */
    public function show($buildId,$statementId)
    {
        $statement = Statement::where('build_id', $buildId)->find($statementId)->load(['incomes','expenses']);
        return response()->json([
            'message' => 'successful',
            'Statement' => $statement,
        ], 200);
    }


    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request,$buildId)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $buildId,$statementId)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($buildId,$statementId)
    {
        //
    }



    public function addIncome(StatementRequest $request, int $statementId)
    {
        $data = $request->validated();
        $statement = Statement::find($statementId);
        if (!$statement) {
            return response()->json([
                'message' => 'statement not found',
            ], 404);
        }
        $income = $statement->incomes()->create($data);
        return response()->json([
            'message' => 'income added',
            'income' => $income
        ], 200);
    }


    public function destroyIncome(StatementRequest $request, int $statementId,$incomeId)
    {
        $statement = Statement::find($statementId);
        if (!$statement) {
            return response()->json([
                'message' => 'statement not found',
            ], 404);
        }

        $isDeleted = $statement->incomes()->find($incomeId)->forceDelete();
        if($isDeleted){
            return response()->json([
                'message' => 'income deleted',
            ], 200);
        }

        return response()->json([
            'message' => 'income is already deleted or some error happened',
        ], 500);
    }


    public function addExpens(StatementRequest $request, int $statementId)
    {
        $data = $request->validated();
        $statement = Statement::find($statementId);
        if (!$statement) {
            return response()->json([
                'message' => 'statement not found',
            ], 404);
        }
        $expens = $statement->expenses()->create($data);
        return response()->json([
            'message' => 'expens added',
            'expens' => $expens
        ], 200);
    }


    public function destroyExpens(StatementRequest $request, int $statementId,$expensId)
    {
        $statement = Statement::find($statementId);
        if (!$statement) {
            return response()->json([
                'message' => 'statement not found',
            ], 404);
        }

        $isDeleted = $statement->expenses()->find($expensId)->forceDelete();
        if($isDeleted){
            return response()->json([
                'message' => 'expens deleted',
            ], 200);
        }

        return response()->json([
            'message' => 'expens is already deleted or some error happened',
        ], 500);
    }
}
