<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class RentPayment extends Model
{
    use HasFactory,SoftDeletes;

    protected $fillable =
    [
        'year',
        'month',
        'state',
        'PayedAmount',
        'remainAmount',
    ];


    protected static function boot()
    {
        parent::boot();

        static::forceDeleting(function($model){
            $model->rentPaymentsInstallments()->forceDelete();
        });

        static::deleting(function($model){
            $model->rentPaymentsInstallments()->delete();
        });

        static::restoring(function($model){
            $model->rentPaymentsInstallments()->restore();
        });

        static::creating(function($model){
            $model->remainAmount = $model->renter()->get()->rent;
        });
    }


    public function renter():BelongsTo
    {
        return $this->belongsTo(Renter::class);
    }

    public function rentPaymentsInstallments():HasMany
    {
        return $this->hasMany(RentPaymentsInstallment::class);
    }


}
