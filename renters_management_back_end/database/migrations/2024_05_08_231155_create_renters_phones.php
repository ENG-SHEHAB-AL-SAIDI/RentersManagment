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
        Schema::create('renters_phones', function (Blueprint $table) {
            $table->integer('phone');
            $table->softDeletes();
            $table->timestamps();
            $table->primary(['renter_id','phone']);

            $table->foreignId('renter_id')->constrained('renters')
            ->onUpdate('cascade')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('renters_phones');
    }
};
