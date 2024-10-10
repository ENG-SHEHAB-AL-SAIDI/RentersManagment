<?php

namespace App\Http\Requests;

use App\Models\Renter;
use App\Models\RentPayment;
use Illuminate\Foundation\Http\FormRequest;

class RentPaymentRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        if (($this->method('post') && $this->routeIs('rent_payments.addInstallment'))) {
            $remain_amount = RentPayment::find($this->route('id'))->remain_amount;
            return [
                'date'=> 'required|date',
                'amount'=>"required|lte:$remain_amount|gt:0",
                'notes'=>'nullable|string',
            ];
        }
        $rent = Renter::find($this->route('renter'))->rent;
        if (!$rent) {
            $rent = INF;
        }
        return [
            'year' => 'required|date_format:Y',
            'month' => 'required|in:1,2,3,4,5,6,7,8,9,10,11,12',
            'state' => 'required|in:payed,partially_payed,not_payed',
            'payed_amount' => ['numeric', "between:0,$rent"],
            "remain_amount" => ['numeric', "between:0,$rent"],
        ];
    }
}
