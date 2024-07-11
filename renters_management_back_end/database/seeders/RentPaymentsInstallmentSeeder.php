<?php

namespace Database\Seeders;

use App\Models\RentPayment;
use App\Models\RentPaymentsInstallment;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class RentPaymentsInstallmentSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    protected int $count;
    protected RentPayment $rentPayment;

    public function __construct(int $count = null , RentPayment $rentPayment) {
        $this->count = $count;
        $this->rentPayment = $rentPayment;
    }

    public function run(): void
    {
        RentPaymentsInstallment::factory($this->count??1)->for($this->rentPayment)->create();
    }
}
