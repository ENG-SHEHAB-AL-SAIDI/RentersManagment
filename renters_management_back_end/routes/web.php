<?php
use Illuminate\Foundation\Auth\EmailVerificationRequest;
use Illuminate\Support\Facades\Route;
use App\Models\User;
use Illuminate\Support\Facades\Auth;

Route::get('/', function () {
    return view('welcome');
});



Route::get('/email/verify/{id}/{hash}', function (EmailVerificationRequest $request) {
    $request->fulfill();

    return view('verifyStatus', ['status' => 'verified']);
})->middleware(['auth', 'signed'])->name('verification.verify');


// Route::get('email/verify/{id}/{hash}', function (EmailVerificationRequest $request) {
//     // Find the user by ID
//     echo "here";
//     echo $request->route('id');
//     $user = User::find($request->route('id'));

//     if (!$user) {
//         return view('verifyStatus', ['status' => 'failed', 'message' => 'User not found.']);
//     }
//     // Check if the user has already verified their email
//     if ($user->hasVerifiedEmail()) {
//         return view('verifyStatus', ['status' => 'already-verified']);
//     }

//     // Try to mark the email as verified
//     if ($user->markEmailAsVerified()) {
//         return view('verifyStatus', ['status' => 'verified']);
//     }

//     // If verification fails (e.g., invalid or expired link)
//     return view('verifyStatus', ['status' => 'failed']);
// })->middleware(['signed'])->name('verification.verify');
