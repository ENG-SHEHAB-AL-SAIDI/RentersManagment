<?php

namespace Database\Seeders;

use App\Models\Statement;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class ExpensSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    protected int $count;
    protected Statement $statement;

    public function __construct(int $count = null , Statement $statement) {
        $this->count = $count;
        $this->statement = $statement;
    }

    public function run(): void
    {
        Statement::factory()->count($this->count??1)->for($this->statement)->create();
    }
}
