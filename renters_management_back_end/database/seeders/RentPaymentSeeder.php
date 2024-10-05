<?php

namespace Database\Seeders;

use App\Models\Renter;
use App\Models\RentPayment;
use Exception;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Seeder;

class RentPaymentSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    protected int $count;
    protected array $years;
    protected ?Renter $renter = null;

    public function __construct(int $count = -1, array $years = [], Renter $renter = null)
    {
        $this->count = $count;
        $this->renter = $renter;
        $this->years = $years;
    }

    public function run()
    {
        try {
            if ($this->renter == null) {
                $rentPayments = RentPayment::factory()->count(($this->count == -1) ? 1 : $this->count)->create();
                return $rentPayments;
            }
            $rentPayments = new Collection(RentPayment::class);
            foreach($this->years as $year){
                for ($i = 0; $i < $this->count; $i++) {
                    $status = [];
                    if ($year != "") {
                        $status['year'] = $year;
                        $status['month'] = $i+1;
                    }
                    $rentPayments->push(RentPayment::factory(1, $status)->for($this->renter)->create());
                }
            }

            return $rentPayments;
        } catch (Exception $e) {
            echo $e->getMessage();
        }
    }
}
