<?php

namespace Database\Seeders;

use App\Models\Build;
use App\Models\RentPayment;
use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $users = User::factory(2)->create();
        $users->push(User::create([
            'name'=>"shehab8",
            'email'=>"shehab8@gmail.com",
            'password'=>12345678,
        ]));
        foreach ($users as $user) {

            $buildSeeder = new BuildSeeder(5, $user);
            $builds = $buildSeeder->run();

            foreach ($builds as $build) {
                $renterSeeder = new RenterSeeder(3, $build);
                $renters = $renterSeeder->run();

                foreach ($renters as $renter) {
                    $renter->addPhone(fake()->randomNumber(9, True));
                }
            }
        }
    }
}
