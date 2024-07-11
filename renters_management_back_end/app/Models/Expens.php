<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class Expens extends Model
{
    use HasFactory,SoftDeletes;

    protected $fillable =
    [
        'date',
        'amount',
        'describe',
    ];

    protected static function boot()
    {
        parent::boot();

        static::created(function($model){

            $model->statement()->TotalExpenses += $model->amount;
        });

        static::deleted(function($model){

            $model->statement()->TotalExpenses -= $model->amount;
        });
    }

    public function statement():BelongsTo
    {
        return $this->belongsTo(Statement::class);
    }
}
