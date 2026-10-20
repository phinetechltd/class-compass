<div class="menu-item">
    <!--begin:Menu link-->
    <a class="menu-link {{ Request::is('dashboard') ? 'active' : '' }}" href="{{ route('dashboard') }}">
        <span class="menu-icon">
            <!--begin::Svg Icon | path: icons/duotune/general/gen014.svg-->
            <span class="svg-icon svg-icon-2">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <rect x="2" y="2" width="9" height="9" rx="2" fill="currentColor" />
                    <rect opacity="0.3" x="13" y="2" width="9" height="9" rx="2"
                        fill="currentColor" />
                    <rect opacity="0.3" x="13" y="13" width="9" height="9" rx="2"
                        fill="currentColor" />
                    <rect opacity="0.3" x="2" y="13" width="9" height="9" rx="2"
                        fill="currentColor" />
                </svg>
            </span>
            <!--end::Svg Icon-->
        </span>
        <span class="menu-title">{{ _lang('Dashboard') }}</span>
    </a>
    <!--end:Menu link-->
</div>

<!--begin:Menu item-->
<div data-kt-menu-trigger="click"
    class="menu-item menu-accordion  {{ Request::is('student/my-assignment') || Request::is('student/my-assignment/*') || Request::is('student/assignments-submit') || Request::is('student/assignments-submit/*') || Request::is('student/view-assignment/*') ? 'here show' : '' }}">
    <!--begin:Menu link-->
    <span class="menu-link">
        <span class="menu-icon">
            <!--begin::Svg Icon | path: icons/duotune/general/gen025.svg-->
            <span class="svg-icon svg-icon-2">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                    xmlns="http://www.w3.org/2000/svg">
                    <rect x="2" y="2" width="9" height="9" rx="2" fill="currentColor" />
                    <rect opacity="0.3" x="13" y="2" width="9" height="9" rx="2"
                        fill="currentColor" />
                    <rect opacity="0.3" x="13" y="13" width="9" height="9" rx="2"
                        fill="currentColor" />
                    <rect opacity="0.3" x="2" y="13" width="9" height="9" rx="2"
                        fill="currentColor" />
                </svg>
            </span>
            <!--end::Svg Icon-->
        </span>
        <span class="menu-title">{{ _lang('Assignment') }}</span>
        <span class="menu-arrow"></span>
    </span>
    <!--end:Menu link-->

    <!--begin:Menu sub-->
    <div class="menu-sub menu-sub-accordion">
        <!--begin:Menu item-->
        <div class="menu-item">
            <!--begin:Menu link-->
            <a class="menu-link {{ Request::is('student/my-assignment') || Request::is('student/view-assignment/*') ? 'active' : '' }}"
                href="{{ url('student/my-assignment') }}">
                <span class="menu-bullet">
                    <span class="bullet bullet-dot"></span>
                </span>
                <span class="menu-title">{{ _lang('My Assignment') }}</span>
            </a>
            <!--end:Menu link-->
        </div>
        <!--end:Menu item-->

        <!--begin:Menu item-->
        <div class="menu-item">
            <!--begin:Menu link-->
            <a class="menu-link {{ Request::is('student/assignments-submit') || Request::is('student/assignments-submit/*') ? 'active' : '' }}"
                href="{{ url('student/assignments-submit') }}">
                <span class="menu-bullet">
                    <span class="bullet bullet-dot"></span>
                </span>
                <span class="menu-title">{{ _lang('Assignment Submit') }}</span>
            </a>
            <!--end:Menu link-->
        </div>
        <!--end:Menu item-->
    </div>
    <!--end:Menu sub-->
</div>
<!--end:Menu item-->


<div class="menu-item">
    <!--begin:Menu link-->
    <a class="menu-link {{ Request::is('student/my-syllabus') ? 'active' : '' }}"
        href="{{ url('student/my-syllabus') }}">
        <span class="menu-icon">
            <!--begin::Svg Icon | path: icons/duotune/general/gen014.svg-->
            <span class="svg-icon svg-icon-2">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                    xmlns="http://www.w3.org/2000/svg">
                    <rect x="2" y="2" width="9" height="9" rx="2" fill="currentColor" />
                    <rect opacity="0.3" x="13" y="2" width="9" height="9" rx="2"
                        fill="currentColor" />
                    <rect opacity="0.3" x="13" y="13" width="9" height="9" rx="2"
                        fill="currentColor" />
                    <rect opacity="0.3" x="2" y="13" width="9" height="9" rx="2"
                        fill="currentColor" />
                </svg>
            </span>
            <!--end::Svg Icon-->
        </span>
        <span class="menu-title">{{ _lang('Syllabus') }}</span>
    </a>
    <!--end:Menu link-->
</div>

<div class="menu-item">
    <!--begin:Menu link-->
    <a class="menu-link {{ Request::is('student/my-subjects') ? 'active' : '' }}"
        href="{{ url('student/my-subjects') }}">
        <span class="menu-icon">
            <!--begin::Svg Icon | path: icons/duotune/general/gen014.svg-->
            <span class="svg-icon svg-icon-2">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                    xmlns="http://www.w3.org/2000/svg">
                    <rect x="2" y="2" width="9" height="9" rx="2" fill="currentColor" />
                    <rect opacity="0.3" x="13" y="2" width="9" height="9" rx="2"
                        fill="currentColor" />
                    <rect opacity="0.3" x="13" y="13" width="9" height="9" rx="2"
                        fill="currentColor" />
                    <rect opacity="0.3" x="2" y="13" width="9" height="9" rx="2"
                        fill="currentColor" />
                </svg>
            </span>
            <!--end::Svg Icon-->
        </span>
        <span class="menu-title">{{ _lang('Subjects') }}</span>
    </a>
    <!--end:Menu link-->
</div>

<div class="menu-item">
    <!--begin:Menu link-->
    <a class="menu-link {{ Request::is('student/class-routine') ? 'active' : '' }}"
        href="{{ url('student/class-routine') }}">
        <span class="menu-icon">
            <!--begin::Svg Icon | path: icons/duotune/general/gen014.svg-->
            <span class="svg-icon svg-icon-2">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                    xmlns="http://www.w3.org/2000/svg">
                    <rect x="2" y="2" width="9" height="9" rx="2" fill="currentColor" />
                    <rect opacity="0.3" x="13" y="2" width="9" height="9" rx="2"
                        fill="currentColor" />
                    <rect opacity="0.3" x="13" y="13" width="9" height="9" rx="2"
                        fill="currentColor" />
                    <rect opacity="0.3" x="2" y="13" width="9" height="9" rx="2"
                        fill="currentColor" />
                </svg>
            </span>
            <!--end::Svg Icon-->
        </span>
        <span class="menu-title">{{ _lang('Class Routine') }}</span>
    </a>
    <!--end:Menu link-->
</div>

<div class="menu-item">
    <!--begin:Menu link-->
    <a class="menu-link {{ Request::is('student/exam_routine') ? 'active' : '' }}"
        href="{{ url('student/exam_routine') }}">
        <span class="menu-icon">
            <!--begin::Svg Icon | path: icons/duotune/general/gen014.svg-->
            <span class="svg-icon svg-icon-2">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                    xmlns="http://www.w3.org/2000/svg">
                    <rect x="2" y="2" width="9" height="9" rx="2" fill="currentColor" />
                    <rect opacity="0.3" x="13" y="2" width="9" height="9" rx="2"
                        fill="currentColor" />
                    <rect opacity="0.3" x="13" y="13" width="9" height="9" rx="2"
                        fill="currentColor" />
                    <rect opacity="0.3" x="2" y="13" width="9" height="9" rx="2"
                        fill="currentColor" />
                </svg>
            </span>
            <!--end::Svg Icon-->
        </span>
        <span class="menu-title">{{ _lang('Exam Routine') }}</span>
    </a>
    <!--end:Menu link-->
</div>

<div class="menu-item">
    <!--begin:Menu link-->
    <a class="menu-link {{ Request::is('student/quiz') ? 'active' : '' }}" href="{{ url('student/quiz') }}">
        <span class="menu-icon">
            <!--begin::Svg Icon | path: icons/duotune/general/gen014.svg-->
            <span class="svg-icon svg-icon-2">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                    xmlns="http://www.w3.org/2000/svg">
                    <rect x="2" y="2" width="9" height="9" rx="2" fill="currentColor" />
                    <rect opacity="0.3" x="13" y="2" width="9" height="9" rx="2"
                        fill="currentColor" />
                    <rect opacity="0.3" x="13" y="13" width="9" height="9" rx="2"
                        fill="currentColor" />
                    <rect opacity="0.3" x="2" y="13" width="9" height="9" rx="2"
                        fill="currentColor" />
                </svg>
            </span>
            <!--end::Svg Icon-->
        </span>
        <span class="menu-title">{{ _lang('Quiz') }}</span>
    </a>
    <!--end:Menu link-->
</div>


<div class="menu-item">
    <!--begin:Menu link-->
    <a class="menu-link {{ Request::is('student/library-history') ? 'active' : '' }}"
        href="{{ url('student/library-history') }}">
        <span class="menu-icon">
            <!--begin::Svg Icon | path: icons/duotune/general/gen014.svg-->
            <span class="svg-icon svg-icon-2">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                    xmlns="http://www.w3.org/2000/svg">
                    <rect x="2" y="2" width="9" height="9" rx="2" fill="currentColor" />
                    <rect opacity="0.3" x="13" y="2" width="9" height="9" rx="2"
                        fill="currentColor" />
                    <rect opacity="0.3" x="13" y="13" width="9" height="9" rx="2"
                        fill="currentColor" />
                    <rect opacity="0.3" x="2" y="13" width="9" height="9" rx="2"
                        fill="currentColor" />
                </svg>
            </span>
            <!--end::Svg Icon-->
        </span>
        <span class="menu-title">{{ _lang('Library History') }}</span>
    </a>
    <!--end:Menu link-->
</div>

<!--begin:Menu item-->
<div data-kt-menu-trigger="click" class="menu-item menu-accordion">
    <!--begin:Menu link-->
    <span class="menu-link">
        <span class="menu-icon">
            <!--begin::Svg Icon | path: icons/duotune/general/gen025.svg-->
            <span class="svg-icon svg-icon-2">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                    xmlns="http://www.w3.org/2000/svg">
                    <rect x="2" y="2" width="9" height="9" rx="2" fill="currentColor" />
                    <rect opacity="0.3" x="13" y="2" width="9" height="9" rx="2"
                        fill="currentColor" />
                    <rect opacity="0.3" x="13" y="13" width="9" height="9" rx="2"
                        fill="currentColor" />
                    <rect opacity="0.3" x="2" y="13" width="9" height="9" rx="2"
                        fill="currentColor" />
                </svg>
            </span>
            <!--end::Svg Icon-->
        </span>
        <span class="menu-title">{{ _lang('My Invoice') }}</span>
        <span class="menu-arrow"></span>
    </span>
    <!--end:Menu link-->

    <!--begin:Menu sub-->
    <div class="menu-sub menu-sub-accordion">
        <!--begin:Menu item-->
        <div class="menu-item">
            <!--begin:Menu link-->
            <a class="menu-link {{ Request::is('student/unpaid-info') ? 'active' : '' }}"
                href="{{ url('student/unpaid-info') }}">
                <span class="menu-bullet">
                    <span class="bullet bullet-dot"></span>
                </span>
                <span class="menu-title">{{ _lang('Unpaid Invoice') }}</span>
            </a>
            <!--end:Menu link-->
        </div>
        <!--end:Menu item-->

        <!--begin:Menu item-->
        <div class="menu-item">
            <!--begin:Menu link-->
            <a class="menu-link {{ Request::is('student/payment-fee-info') ? 'active' : '' }}"
                href="{{ url('student/payment-fee-info') }}">
                <span class="menu-bullet">
                    <span class="bullet bullet-dot"></span>
                </span>
                <span class="menu-title">{{ _lang('Paid Invoice') }}</span>
            </a>
            <!--end:Menu link-->
        </div>
        <!--end:Menu item-->
    </div>
    <!--end:Menu sub-->
</div>
<!--end:Menu item-->

<!--begin:Menu item-->
<div data-kt-menu-trigger="click" class="menu-item menu-accordion">
    <!--begin:Menu link-->
    <span class="menu-link">
        <span class="menu-icon">
            <!--begin::Svg Icon | path: icons/duotune/general/gen025.svg-->
            <span class="svg-icon svg-icon-2">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                    xmlns="http://www.w3.org/2000/svg">
                    <rect x="2" y="2" width="9" height="9" rx="2" fill="currentColor" />
                    <rect opacity="0.3" x="13" y="2" width="9" height="9" rx="2"
                        fill="currentColor" />
                    <rect opacity="0.3" x="13" y="13" width="9" height="9" rx="2"
                        fill="currentColor" />
                    <rect opacity="0.3" x="2" y="13" width="9" height="9" rx="2"
                        fill="currentColor" />
                </svg>
            </span>
            <!--end::Svg Icon-->
        </span>
        <span class="menu-title">{{ _lang('My Fine') }}</span>
        <span class="menu-arrow"></span>
    </span>
    <!--end:Menu link-->

    <!--begin:Menu sub-->
    <div class="menu-sub menu-sub-accordion">
        <!--begin:Menu item-->
        <div class="menu-item">
            <!--begin:Menu link-->
            <a class="menu-link {{ Request::is('student/attendance-fine-report') || Request::is('student/attendance-fine-report/*') ? 'active' : '' }}"
                href="{{ route('student-attendance-fine-report') }}">
                <span class="menu-bullet">
                    <span class="bullet bullet-dot"></span>
                </span>
                <span class="menu-title">{{ _lang('Attendance Fine') }}</span>
            </a>
            <!--end:Menu link-->
        </div>
        <!--end:Menu item-->

        <!--begin:Menu item-->
        <div class="menu-item">
            <!--begin:Menu link-->
            <a class="menu-link {{ Request::is('student/quiz-fine-report') || Request::is('student/quiz-fine-report/*') ? 'active' : '' }}"
                href="{{ route('student-quiz-fine-report') }}">
                <span class="menu-bullet">
                    <span class="bullet bullet-dot"></span>
                </span>
                <span class="menu-title">{{ _lang('Quiz Fine') }}</span>
            </a>
            <!--end:Menu link-->
        </div>
        <!--end:Menu item-->

        <!--begin:Menu item-->
        <div class="menu-item">
            <!--begin:Menu link-->
            <a class="menu-link {{ Request::is('student/lab-fine-report') || Request::is('student/lab-fine-report/*') ? 'active' : '' }}"
                href="{{ url('student/lab-fine-report') }}">
                <span class="menu-bullet">
                    <span class="bullet bullet-dot"></span>
                </span>
                <span class="menu-title">{{ _lang('Lab Fine') }}</span>
            </a>
            <!--end:Menu link-->
        </div>
        <!--end:Menu item-->
    </div>
    <!--end:Menu sub-->
</div>
<!--end:Menu item-->

<div class="menu-item">
    <!--begin:Menu link-->
    <a class="menu-link {{ Request::is('student/feedback') ? 'active' : '' }}" href="{{ url('student/feedback') }}">
        <span class="menu-icon">
            <!--begin::Svg Icon | path: icons/duotune/general/gen014.svg-->
            <span class="svg-icon svg-icon-2">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                    xmlns="http://www.w3.org/2000/svg">
                    <rect x="2" y="2" width="9" height="9" rx="2" fill="currentColor" />
                    <rect opacity="0.3" x="13" y="2" width="9" height="9" rx="2"
                        fill="currentColor" />
                    <rect opacity="0.3" x="13" y="13" width="9" height="9" rx="2"
                        fill="currentColor" />
                    <rect opacity="0.3" x="2" y="13" width="9" height="9" rx="2"
                        fill="currentColor" />
                </svg>
            </span>
            <!--end::Svg Icon-->
        </span>
        <span class="menu-title">{{ _lang('Teachers Feedback') }}</span>
    </a>
    <!--end:Menu link-->
</div>

<div class="menu-item">
    <!--begin:Menu link-->
    <a class="menu-link" href="#">
        <span class="menu-icon">
            <!--begin::Svg Icon | path: icons/duotune/general/gen014.svg-->
            <span class="svg-icon svg-icon-2">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                    xmlns="http://www.w3.org/2000/svg">
                    <rect x="2" y="2" width="9" height="9" rx="2" fill="currentColor" />
                    <rect opacity="0.3" x="13" y="2" width="9" height="9" rx="2"
                        fill="currentColor" />
                    <rect opacity="0.3" x="13" y="13" width="9" height="9" rx="2"
                        fill="currentColor" />
                    <rect opacity="0.3" x="2" y="13" width="9" height="9" rx="2"
                        fill="currentColor" />
                </svg>
            </span>
            <!--end::Svg Icon-->
        </span>
        <span class="menu-title">{{ _lang('Progress Card') }}</span>
    </a>
    <!--end:Menu link-->
</div>
