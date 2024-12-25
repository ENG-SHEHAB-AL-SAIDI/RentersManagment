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
    protected $table = 'expenses';
    protected static function boot()
    {
        parent::boot();

        static::created(function($model){

            $model->statement->TotalExpenses += $model->amount;
            $model->statement->save();
        });

        static::deleted(function($model){

            $model->statement->TotalExpenses -= $model->amount;
            $model->statement->save();
        });
    }

    public function statement():BelongsTo
    {
        return $this->belongsTo(Statement::class);
    }
}
