<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class RentersPhone extends Model
{
    use HasFactory,SoftDeletes;

    protected $fillable = [
        'renter_id',
        'phone',
    ];


    public function renter():BelongsTo
    {
        return $this->belongsTo(Renter::class);
    }

}
