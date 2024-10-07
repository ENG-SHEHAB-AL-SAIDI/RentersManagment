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
        if(request()->isMethod('DELETE') ){
            return [];
        }
        return [
            'name'=>'required|max:50',
            'rent'=>'required|numeric',
            'job_domain'=>'sometimes|string',
            'enter_date'=>'sometimes|date',
            'phones' => 'sometimes|array',        // Ensure it's an array
            'phones.*' => 'sometimes|integer',
        ];
    }
}
