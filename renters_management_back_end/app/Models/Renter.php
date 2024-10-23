<?php

namespace App\Models;

use Carbon\Factory;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Renter extends Model
{
    use HasFactory, SoftDeletes;


    protected $fillable = [
        'name',
        'rent',
        'job_domain',
        'entery_year',
    ];



    protected static function boot()
    {
        parent::boot();

        static::created(function ($model) {

            for ($i = 0; $i < 12; $i++) {
                $model->rentPayments()->create([
                    'year' => $model->entery_year,
                    'month' => str($i+1),
                    'state' => 'not_payed',
                    'payed_amount' => 0,
                    'remain_amount' => $model->rent,
                ]);
            }

            if($model->build->statment()->where('year',$model->entery_year)->get()->isEmpty()){
                for ($i = 0; $i < 12; $i++) {
                    $model->build->statment()->create([
                        'year'=>$model->entery_year,
                        'month'=>str($i+1),
                    ]);
                }
            }
        });
        static::forceDeleting(function ($model) {
            $model->renterPhones()->forceDelete();
        });

        static::deleting(function ($model) {
            $model->renterPhones()->delete();
        });

        static::restoring(function ($model) {
            $model->renterPhones()->restore();
        });
    }


    public function renterPhones(): HasMany
    {
        return $this->hasMany(RentersPhone::class);
    }



    public function rentPayments(): HasMany
    {
        return $this->hasMany(RentPayment::class);
    }



    public function build(): BelongsTo
    {
        return $this->belongsTo(Build::class);
    }

    public function addPhone(int $phone)
    {
        $this->renterPhones()->updateOrCreate(['phone' => $phone]);
    }
}
