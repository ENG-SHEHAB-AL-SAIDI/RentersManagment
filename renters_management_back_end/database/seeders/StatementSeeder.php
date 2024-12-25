<?php

namespace Database\Seeders;

use App\Models\Build;
use App\Models\Statement;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class StatementSeeder extends Seeder
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

    public function run(): void
    {
        Statement::factory()->count($this->count??1)->for($this->build)->create()->addPhone(fake()->randomNumber(9,True));
    }
}
