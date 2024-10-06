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
        $userId = $this->route('user');
        if (!$userId ) {
            throw new \Exception('User ID not found in the request.');
        }
        $buildId = $this->route('build');
        $authenticatedUser = auth()->guard('api')->user();

        if(!$buildId){
            return $authenticatedUser->id === $userId;
        }
        return $authenticatedUser->id === $userId && $authenticatedUser->builds()->where('id', $buildId)->exists();
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        if ($this->isMethod('get') || $this->routeIs('builds.show') || $this->isMethod('DELETE') || $this->routeIs('builds.destroy')) {
            // No validation for GET (show) requests
            return [];
        }

        return [
            'name' => 'required|max:50',
            'city' => 'sometimes|max:50',
            'address' => 'sometimes|max:50',
        ];
    }
}
