<?php

namespace App\Http\Requests;

use App\Models\Build;
use GuzzleHttp\Psr7\Request;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Routing\Route;

class BuildUpdateRequst extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        $id = intval( request()->segment(count(request()->segments())));
        return auth()->guard('api')->user()->id === Build::find($id)->user_id;
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
