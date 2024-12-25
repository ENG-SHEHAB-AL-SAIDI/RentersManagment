<?php

namespace Database\Seeders;

use App\Models\Renter;
use App\Models\RentersPhone;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class RentersPhoneSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    protected int $count;
    protected Renter $renter;

    public function __construct(int $count = null , Renter $renter) {
        $this->count = $count;
        $this->renter = $renter;
    }

    public function run(): void
    {
        RentersPhone::factory()->count($this->count??1)->for($this->renter)->create();
    }
}
