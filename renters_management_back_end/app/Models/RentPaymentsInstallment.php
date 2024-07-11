<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class RentPaymentsInstallment extends Model
{
    use HasFactory,SoftDeletes;

    protected $fillable = 
    [
        'date',
        'amount',
        'notes',
    ];

    public function rentPayment():BelongsTo
    {
        return $this->belongsTo(RentPayment::class);
    }
}
