<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class RentPayment extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable =
    [
        'year',
        'month',
        'state',
        'payed_amount',
        'remain_amount',
    ];


    protected static function boot()
    {
        parent::boot();

        static::forceDeleting(function ($model) {
            $model->rentPaymentsInstallments()->forceDelete();
        });

        static::restoring(function ($model) {
            $model->rentPaymentsInstallments()->restore();
        });

        static::creating(function ($model) {
            $model->remain_amount = $model->renter->rent;
        });
    }


    public function renter(): BelongsTo
    {
        return $this->belongsTo(Renter::class);
    }

    public function rentPaymentsInstallments(): HasMany
    {
        return $this->hasMany(RentPaymentsInstallment::class);
    }
}
