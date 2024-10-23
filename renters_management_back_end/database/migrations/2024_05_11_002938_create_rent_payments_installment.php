<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('rent_payments_installments', function (Blueprint $table) {
            $table->id();
            $table->dateTime('date');
            $table->float('amount');
            $table->text('notes')->nullable();
            $table->softDeletes();
            $table->timestamps();

            $table->primary('id');
            $table->foreignId('rent_payment_id')
                ->constrained('rent_payments')->onUpdagte('cascade')->onDelete('cascade');
            $table->foreignId('income_id')->nullable()
                ->constrained('incomes')->onUpdate('cascade')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('rent_payments_installments');
    }
};
