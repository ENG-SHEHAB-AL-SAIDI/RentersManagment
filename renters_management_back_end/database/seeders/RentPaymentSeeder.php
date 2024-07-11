<?php

namespace Database\Seeders;

use App\Models\Renter;
use App\Models\RentPayment;
use Exception;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class RentPaymentSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    protected int $count;
    protected String $year;
    protected ?Renter $renter = null;

    public function __construct(int $count = -1 ,String $year="", Renter $renter = null) {
        $this->count = $count;
        $this->renter = $renter;
        $this->year = $year;
    }

    public function run()
    {
        try{
            if($this->renter == null){
                $rentPayments = RentPayment::factory()->count(($this->count==-1)?1:$this->count)->create();
                return $rentPayments;
            }
            $status=[];
            if ($this->year != ""){
                $status['year'] = $this->year;
            }
            $rentPayments = RentPayment::factory(($this->count==-1)?1:$this->count , $status)->for($this->renter)->create();
            return $rentPayments;
    }catch(Exception){
        echo "error";
    }

    }
}
