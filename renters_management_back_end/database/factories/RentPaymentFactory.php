<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\RentPayment>
 */
class RentPaymentFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'year'=>fake()->year(),
            'month'=>fake()->randomElement(['1','2','3','4','5','6','7','8','9','10','11','12']),
            'state'=>fake()->randomElement(['payed','partially','notPayed']),
            'payed_amount'=>0,
            'remain_amount'=>9999,
        ];
    }
}
