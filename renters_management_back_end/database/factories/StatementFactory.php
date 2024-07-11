<?php

namespace Database\Factories;

use App\Models\Statement;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Statement>
 */
class StatementFactory extends Factory
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
            'TotalExpenses'=>0,
            'TotalIncomes'=>0,

        ];
    }
}
