<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Nette\Utils\Random;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('incomes', function (Blueprint $table) {
            $table->id();
            $table->date('date');
            $table->float('amount');
            $table->enum('paymentType',['cash','trans','part_from_trans']);
            $table->bigInteger('paymentID')->nullable();
            $table->text('describe')->nullable();
            $table->softDeletes();
            $table->timestamps();

            $table->primary('id');
            $table->foreignId('statement_id')->constrained('statements')
            ->onUpdate('cascade')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('incomes');
    }
};
