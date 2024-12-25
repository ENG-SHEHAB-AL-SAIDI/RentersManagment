<?php

namespace App\Http\Requests;

use App\Models\Build;
use Illuminate\Foundation\Http\FormRequest;

class RenterRequst extends FormRequest
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
        if(($this->isMethod('post') && $this->routeIs('renters.addPhone')||$this->isMethod('DELETE') && $this->routeIs('renters.deletePhone'))){
            return [
                'phone' => 'required|integer',
            ];
        }
        if($this->isMethod('DELETE') ){
            return [];
        }
        return [
            'name'=>'required|max:50',
            'rent'=>'required|numeric',
            'job_domain'=>'sometimes|string',
            'entery_year'=>'required|date_format:Y',
            'phones' => 'sometimes|array',        // Ensure it's an array
            'phones.*' => 'sometimes|integer',
        ];
    }
}
