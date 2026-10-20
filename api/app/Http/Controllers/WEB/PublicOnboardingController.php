<?php

namespace App\Http\Controllers\WEB;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Modules\Frontend\Models\Onboarding;

class PublicOnboardingController extends Controller
{
    public function create()
    {
        return view('public.onboarding.create');
    }

    public function store(Request $request)
    {
        $request->validate([
            'institute_name' => 'required|string|max:100',
            'institute_email' => 'required|email|max:255|unique:institutes,email',
            'institute_phone' => 'required|string|max:15|unique:institutes,phone',
            'institute_domain' => 'nullable|string|max:100|unique:institutes,domain',
            'institute_type' => 'nullable|string|max:100',
            'institute_address' => 'nullable|string|max:255',
            'institute_logo' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
            'name' => 'required|string|max:100',
            'email' => 'required|email|max:255|unique:users,email',
            'phone' => 'required|string|max:50',
            'password' => 'required|string|min:4|confirmed',
            'avatar' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);

        // Handle the institute_logo file upload if it exists
        $instituteLogoPath = $request->hasFile('institute_logo')
            ? fileUploader('institutes/', 'png', $request->file('institute_logo'))
            : null;

        // Handle the user_avatar file upload if it exists
        $userAvatarPath = $request->hasFile('avatar')
            ? fileUploader('user_avatars/', 'png', $request->file('avatar'))
            : null;

        // Save onboarding data
        Onboarding::create([
            'institute_name' => $request->institute_name,
            'institute_email' => $request->institute_email,
            'institute_phone' => $request->institute_phone,
            'institute_domain' => $request->institute_domain,
            'institute_type' => $request->institute_type,
            'institute_address' => $request->institute_address,
            'name' => $request->name,
            'email' => $request->email,
            'phone' => $request->phone,
            'password' => Hash::make($request->password),
            'institute_logo' => $instituteLogoPath,
            'user_avatar' => $userAvatarPath,
            'status' => 'pending',
        ]);

        return redirect()->back()->with('success', 'Your onboarding request has been submitted successfully!');
    }
}
