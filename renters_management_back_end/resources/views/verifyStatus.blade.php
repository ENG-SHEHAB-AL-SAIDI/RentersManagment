<!-- resources/views/verify-status.blade.php -->
<!DOCTYPE html>
<html>
<head>
    <title>Email Verification</title>
</head>
<body>
    @if ($status === 'verified')
        <h1>Your email has been successfully verified!</h1>
        <p>Thank you for confirming your email. You can now log in to the app.</p>
    @elseif ($status === 'already-verified')
        <h1>Email Already Verified</h1>
        <p>Your email has already been verified. You can proceed to log in.</p>
    @elseif ($status === 'failed')
        <h1>Email Verification Failed</h1>
        @if ($message)
        <p> $message </p>
        @else
        <p>There was a problem verifying your email. Please check the link or request a new verification email.</p>
        @endif
    @endif
</body>
</html>
