<?php

namespace App\Http\Requests;
use App\Models\Build;
use Illuminate\Foundation\Http\FormRequest;

class BuildRequst extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        if( request()->isMethod('PUT') || request()->isMethod('PATCH') || request()->isMethod('DELETE') ){
            $id = request()->route('build');
        return auth()->guard('api')->user()->id === Build::find($id)->user_id;
        }

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
            'city'=>'max:50',
            'address'=>'max:50',
        ];
    }
}
