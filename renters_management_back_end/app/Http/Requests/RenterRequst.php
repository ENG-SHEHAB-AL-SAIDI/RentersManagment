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
        $id = request()->route('builds');
        return auth()->guard('api')->user()->id === Build::find($id)->user_id; 
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
            'rent'=>'integer',
            'job_domain'=>'string',
            'enter_date'=>'date',
            'phones' => 'array',        // Ensure it's an array
            'phones.*' => 'integer',
        ];
    }
}
