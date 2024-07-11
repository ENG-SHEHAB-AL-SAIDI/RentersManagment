<?php

namespace App\Http\Controllers;

use App\Models\Build;
use Illuminate\Http\Request;

class CombinDataController extends Controller
{
    public function getAllUserData(int $id)
    {
        $builds =  Build::with('renter.renterPhones','renters.renterRentPayments')->get()->where('id',$id);
        return $builds;
    }
}
