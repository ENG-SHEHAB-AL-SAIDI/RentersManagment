<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class Income extends Model
{
    use HasFactory,SoftDeletes;

    protected $fillable =
    [
        'date',
        'amount',
        'paymentType',
        'paymentID',
        'describe',
    ];


    protected static function boot()
    {
        parent::boot();

        static::created(function($model){

            $model->statement()->first()->TotalExpenses += $model->amount;
        });

        static::deleted(function($model){

            $model->statement()->first()->TotalExpenses -= $model->amount;
        });
    }

    public function statement():BelongsTo
    {
        return $this->belongsTo(Statement::class);
    }
}
