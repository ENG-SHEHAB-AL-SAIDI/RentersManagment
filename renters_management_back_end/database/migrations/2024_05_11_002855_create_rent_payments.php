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
        Schema::create('rent_payments', function (Blueprint $table) {
            $table->id();
            $table->string('year')->nullable(false);
            $table->enum('month',['1','2','3','4','5','6','7','8','9','10','11','12'])->nullable(false);
            $table->enum('state',['payed','partially_payed','not_payed'])->nullable(false);
            $table->float('payed_amount')->default(0);
            $table->float('remain_amount');
            $table->softDeletes();
            $table->timestamps();

            $table->primary('id');
            $table->unique(['year','month','renter_id']);
            $table->foreignId('renter_id')->constrained('renters')
            ->onUpdate('cascade')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('rent_payments');
    }
};
