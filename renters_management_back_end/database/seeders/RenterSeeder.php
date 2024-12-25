<?php

namespace Database\Seeders;

use App\Models\Build;
use App\Models\Renter;
use App\Models\RentPayment;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class RenterSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    protected int $count;
    protected Build $build;

    public function __construct(int $count = null , Build $build) {
        $this->count = $count;
        $this->build = $build;
    }

    public function run()
    {

        $renters = Renter::factory()->count($this->count??1)->for($this->build)->create();

        return $renters;
    }
}
