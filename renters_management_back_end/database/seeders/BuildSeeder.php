<?php

namespace Database\Seeders;

use App\Models\Build;
use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class BuildSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    protected int $count;
    protected User $user;

    public function __construct(int $count = null , User $user) {
        $this->count = $count;
        $this->user = $user;
    }

    public function run()
    {
        $builds = Build::factory()->count($this->count??1)->for($this->user)->create();
        return $builds;
    }
}
