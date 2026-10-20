<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>{{ env('APP_NAME', 'School Software') }}</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100 min-h-screen flex items-center justify-center">
    <div class="bg-white shadow-xl rounded-2xl p-10 w-full max-w-lg text-center">
        <div class="mb-6">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                stroke="currentColor" class="w-16 h-16 mx-auto text-blue-600">
                <path stroke-linecap="round" stroke-linejoin="round"
                    d="M9 12h6m-3-3v6m9-3a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
        </div>

        <h1 class="text-3xl font-bold text-gray-800 mb-3">
            Welcome to {{ env('APP_NAME', 'School Software') }}
        </h1>

        <p class="text-gray-600 mb-8">
            Thank you for choosing our application.
            Click the button below to start the installation process.
        </p>

        <a href="#"
            class="inline-block bg-blue-600 hover:bg-blue-700 text-white font-semibold px-8 py-3 rounded-xl transition shadow-md">
            Installation Done
        </a>

        <p class="text-xs text-gray-400 mt-6">
            Version {{ config('app.version', '3.0.0') }}
        </p>
    </div>
</body>

</html>
