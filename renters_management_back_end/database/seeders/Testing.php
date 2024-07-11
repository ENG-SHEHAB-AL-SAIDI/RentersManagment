<?php

namespace Database\Seeders;

use App\Models\Build;
use App\Models\Renter;
use App\Models\RentPayment;
use App\Models\User;
use Faker\Provider\ar_EG\Payment;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Laravel\Ui\Presets\React;

class Testing extends Seeder
{
    /**
     * Run the database seeds.
     */

    public function run(): void
    {
        // User::factory(12)->create();
        // Build::factory()->count(20)->has(
        //     Renter::factory(10)->has(
        //         RentPayment::factory(12,['year'=>'2020'])
        //     ))->for(User::inRandomOrder()->first())->create();
    }
}
