<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Build extends Model
{
    use HasFactory,SoftDeletes;
    protected $fillable = [
        'name',
        'city',
        'address',
        'user_id',
    ];

    protected $appends = ['total_rent'];

    public function getTotalRentAttribute()
    {
        return $this->renters()->sum('rent');
    }

    protected static function boot()
    {
        parent::boot();

        static::forceDeleting(function($model){
            $model->renters()->forceDelete();
        });

        static::deleting(function($model){
            $model->renters()->delete();
        });

        static::restoring(function($model){
            $model->renters()->restore();
        });
    }

    public function renters():HasMany
    {
        return $this->hasMany(Renter::class);
    }

    public function statment():HasMany
    {
        return $this->hasMany(Statement::class);
    }

    public function user():BelongsTo
    {
        return $this->belongsTo(User::class);
    }


}
