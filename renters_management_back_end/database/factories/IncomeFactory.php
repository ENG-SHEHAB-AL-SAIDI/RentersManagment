<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Income>
 */
class IncomeFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $paymentType = fake()->randomElement(['cash','trans']);
        return [
            'date' => fake()->date(),
            'amount' => fake()->numberBetween(1000,10000),
            'describe' => fake()->text(),
            'paymentType' => $paymentType,
            'paymentID' => ($paymentType = 'trans')? fake()->randomNumber(10,true):0

        ];
    }
}
