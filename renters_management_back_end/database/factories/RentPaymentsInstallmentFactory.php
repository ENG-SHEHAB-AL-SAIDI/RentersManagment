<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\RentPaymentsInstallment>
 */
class RentPaymentsInstallmentFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'date'=>fake()->date(),
            'amount'=>fake()->randomFloat(1000,10000),
            'notes'=>fake()->text(),
        ];
    }
}
