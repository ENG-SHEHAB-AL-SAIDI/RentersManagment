<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class BuildStoreRequst extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return True;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'name'=>'required|max:50',
            'city'=>'max:50',
            'address'=>'max:50',
        ];
    }
}
