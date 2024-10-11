<?php

namespace Database\Seeders;

use App\Models\RentPayment;
use App\Models\RentPaymentsInstallment;
use Illuminate\Database\Seeder;

class RentPaymentsInstallmentSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    protected int $count;
    protected RentPayment $rentPayment;

    public function __construct(int $count = null, RentPayment $rentPayment)
    {
        $this->count = $count;
        $this->rentPayment = $rentPayment;
    }

    public function run(): void
    {
        for ($i = 0; $i < $this->count; $i++) {

            $installment = RentPaymentsInstallment::factory()->for($this->rentPayment)->create(
                [
                    'amount' => fake()->randomFloat(null, 0, $this->rentPayment->remain_amount),
                ]
            );
            $this->rentPayment->remain_amount -= $installment->amount;
            $this->rentPayment->payed_amount += $installment->amount;
            if ($this->rentPayment->payed_amount == 0) {
                $this->rentPayment->state = 'not_payed';
            } elseif ($this->rentPayment->remain_amount == 0) {
                $this->rentPayment->state = 'payed';
            } else {
                $this->rentPayment->state = 'partially_payed';
            }
            $this->rentPayment->save();
        }
    }
}
