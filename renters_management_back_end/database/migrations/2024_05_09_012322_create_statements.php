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
        Schema::create('statements', function (Blueprint $table) {
            $table->id();
            $table->string('year');
            $table->enum('month',['1','2','3','4','5','6','7','8','9','10','11','12']);
            $table->float('TotalExpenses')->nullable();
            $table->float('TotalIncomes')->nullable();
            $table->softDeletes();
            $table->timestamps();

            $table->primary('id');
            $table->foreignId('build_id')->constrained('builds')
            ->onUpdate('cascade')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('statements');
    }
};
