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
    use HasFactory,SoftDeletes;


    protected $fillable = [
        'name',
        'rent',
        'job_domain',
        'enter_date',
    ];



    protected static function boot()
    {
        parent::boot();

        static::forceDeleting(function($model){
            $model->renter_phones()->forceDelete();
        });

        static::deleting(function($model){
            $model->renter_phones()->delete();
        });

        static::restoring(function($model){
            $model->renter_phones()->restore();
        });
    }


    public function renterPhones() :HasMany
    {
        return $this->hasMany(RentersPhone::class);
    }

    public function RentPayments() :HasMany
    {
        return $this->hasMany(RentPayment::class);
    }

    public function build():BelongsTo
    {
        return $this->belongsTo(Build::class);
    }

    public function addPhone(int $phone)
    {
        $this->renterPhones()->create(['phone'=>$phone]);
    }
}
