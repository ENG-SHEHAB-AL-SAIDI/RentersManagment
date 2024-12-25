<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Statement extends Model
{
    use HasFactory,SoftDeletes;

    protected $fillable =
    [
        'year',
        'month',
        'TotalExpenses',
        'TotalIncomes',
    ];

    protected static function boot()
    {
        parent::boot();

        static::forceDeleting(function($model){
            $model->incomes()->forceDelete();
            $model->expenses()->forceDelete();
        });

        static::deleting(function($model){
            $model->incomes()->delete();
            $model->expenses()->delete();
        });

        static::restoring(function($model){
            $model->incomes()->restore();
            $model->expenses()->restore();
        });
    }

    public function build():BelongsTo
    {
        return $this->belongsTo(Build::class);
    }

    public function incomes():HasMany
    {
        return $this->hasMany(Income::class);
    }

    public function expenses():HasMany
    {
        return $this->hasMany(Expens::class);
    }
}
