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
        Schema::create('rent_payments_installment', function (Blueprint $table) {
            $table->dateTime('date');
            $table->float('amount');
            $table->text('notes')->nullable();
            $table->softDeletes();
            $table->timestamps();

            $table->primary(['rent_payments_id','date']);
            $table->foreignId('rent_payments_id')->constrained('rent_payments')
            ->onUpdate('cascade')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('rent_payments_installment');
    }
};
