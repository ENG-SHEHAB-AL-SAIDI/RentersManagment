<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StatementRequest extends FormRequest
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
        if ($this->isMethod('post') && $this->routeIs('statements.addIncome')) {
            return [
                'date'=>'required|date',
                'amount'=>'required|numeric',
                'paymentType'=>'required|in:cash,trans,part_from_trans',
                'paymentID'=>'nullable|integer',
                'describe'=>'nullable',
            ];
        }
        elseif($this->isMethod('post') && $this->routeIs('statements.addExpens')){
            return [
                'date'=>'required|date',
                'amount'=>'required|numeric',
                'describe'=>'nullable',
            ];
        }
        return [];


    }
}
