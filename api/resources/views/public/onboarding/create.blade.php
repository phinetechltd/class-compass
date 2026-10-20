<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create School Account | Class Compass</title>
    <!-- Favicon -->
    <link rel="shortcut icon" href="{{ asset('favicon.png') }}" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f5f7fb;
            font-family: "Noto Sans", sans-serif;
        }

        .card {
            border: none;
            border-radius: 12px;
        }

        .btn-register {
            background-color: #ffc107;
            color: #000;
            font-weight: 600;
        }

        .btn-register:hover {
            background-color: #ffca2c;
            color: #000;
        }

        label {
            font-weight: 500;
        }

        .form-control,
        .form-select {
            border-radius: 8px;
        }

        .form-section {
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
        }

        .logo {
            text-align: center;
            margin-bottom: 15px;
        }

        .logo img {
            width: 90px;
        }

        .form-title {
            text-align: center;
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 25px;
        }
    </style>
</head>

<body>
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="form-section p-4">
                    <div class="logo">
                        <img src="{{ asset('backend_assets/logo/logo.png') }}" alt="Logo" style="height:100px;">
                    </div>
                    <h4 class="form-title">Create Your School Account</h4>

                    @if (session('success'))
                        <div class="alert alert-success">{{ session('success') }}</div>
                    @endif

                    <form action="{{ route('public.onboarding.store') }}" method="POST" enctype="multipart/form-data">
                        @csrf
                        <div class="row g-3">

                            <!-- Owner Name -->
                            <div class="col-md-6">
                                <label class="form-label">Owner Name <span class="text-danger">*</span></label>
                                <input type="text" name="name" value="{{ old('name') }}"
                                    class="form-control @error('name') is-invalid @enderror"
                                    placeholder="Owner Full Name" required>
                                @error('name')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>

                            <!-- Owner Email -->
                            <div class="col-md-6">
                                <label class="form-label">Owner Email <span class="text-danger">*</span></label>
                                <input type="email" name="email" value="{{ old('email') }}"
                                    class="form-control @error('email') is-invalid @enderror" placeholder="Owner Email"
                                    required>
                                @error('email')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>

                            <!-- Owner Phone -->
                            <div class="col-md-6">
                                <label class="form-label">Owner Phone <span class="text-danger">*</span></label>
                                <input type="text" name="phone" value="{{ old('phone') }}"
                                    class="form-control @error('phone') is-invalid @enderror" placeholder="Owner Phone"
                                    required>
                                @error('phone')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>

                            <!-- Owner Avatar -->
                            <div class="col-md-6">
                                <label class="form-label">Owner Avatar</label>
                                <input type="file" name="avatar"
                                    class="form-control @error('avatar') is-invalid @enderror">
                                @error('avatar')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>

                            <!-- School Name -->
                            <div class="col-md-6">
                                <label class="form-label">School Name <span class="text-danger">*</span></label>
                                <input type="text" name="institute_name" value="{{ old('institute_name') }}"
                                    class="form-control @error('institute_name') is-invalid @enderror"
                                    placeholder="School Name" required>
                                @error('institute_name')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>

                            <!-- School Email -->
                            <div class="col-md-6">
                                <label class="form-label">School Email <span class="text-danger">*</span></label>
                                <input type="email" name="institute_email" value="{{ old('institute_email') }}"
                                    class="form-control @error('institute_email') is-invalid @enderror"
                                    placeholder="School Email" required>
                                @error('institute_email')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>

                            <!-- School Phone -->
                            <div class="col-md-6">
                                <label class="form-label">School Phone <span class="text-danger">*</span></label>
                                <input type="text" name="institute_phone" value="{{ old('institute_phone') }}"
                                    class="form-control @error('institute_phone') is-invalid @enderror"
                                    placeholder="School Phone" required>
                                @error('institute_phone')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>

                            <!-- School Domain -->
                            <div class="col-md-6">
                                <label class="form-label">School Domain</label>
                                <input type="text" name="institute_domain" value="{{ old('institute_domain') }}"
                                    class="form-control @error('institute_domain') is-invalid @enderror"
                                    placeholder="myinstitute.com">
                                @error('institute_domain')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>

                            <!-- School Type -->
                            <div class="col-md-6">
                                <label class="form-label">School Type</label>
                                <input type="text" name="institute_type" value="{{ old('institute_type') }}"
                                    class="form-control @error('institute_type') is-invalid @enderror"
                                    placeholder="School, Cafe, etc.">
                                @error('institute_type')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>

                            <!-- School Address -->
                            <div class="col-md-12">
                                <label class="form-label">School Address</label>
                                <textarea name="institute_address" rows="2"
                                    class="form-control @error('institute_address') is-invalid @enderror" placeholder="Full Address">{{ old('institute_address') }}</textarea>
                                @error('institute_address')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>

                            <!-- School Logo -->
                            <div class="col-md-6">
                                <label class="form-label">School Logo</label>
                                <input type="file" name="institute_logo"
                                    class="form-control @error('institute_logo') is-invalid @enderror">
                                @error('institute_logo')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>

                            <!-- Password -->
                            <div class="col-md-6">
                                <label class="form-label">Password <span class="text-danger">*</span></label>
                                <input type="password" name="password"
                                    class="form-control @error('password') is-invalid @enderror"
                                    placeholder="Password" required>
                                @error('password')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>

                            <!-- Confirm Password -->
                            <div class="col-md-6">
                                <label class="form-label">Confirm Password <span class="text-danger">*</span></label>
                                <input type="password" name="password_confirmation"
                                    class="form-control @error('password_confirmation') is-invalid @enderror"
                                    placeholder="Confirm Password" required>
                                @error('password_confirmation')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>

                            <div class="col-12 text-center mt-3">
                                <button type="submit" class="btn btn-register px-5 py-2">Apply for
                                    School</button>
                            </div>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>
</body>

</html>
