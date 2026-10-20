<div class="menu-item">
    <!--begin:Menu link-->
    <a class="menu-link {{ Route::is('dashboard') ? 'active' : '' }}" href="{{ route('dashboard') }}">
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
    class="menu-item menu-accordion {{ Request::is('student-attendance') || Request::is('exams-attendance') || Request::is('reports/student_attendance_report') || Request::is('reports/student_attendance_report/view') || Request::is('reports-student_attendance_date_to_date/view') || Request::is('reports-student_attendance_date_to_date') ? 'here show' : '' }}">
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
        <span class="menu-title">{{ _lang('Student Attendance') }}</span>
        <span class="menu-arrow"></span>
    </span>
    <!--end:Menu link-->
    <!--begin:Menu sub-->
    <div class="menu-sub menu-sub-accordion">
        <!--begin:Menu item-->
        <div class="menu-item">
            <!--begin:Menu link-->
            <a class="menu-link {{ Request::is('student-attendance') ? 'active' : '' }}"
                href="{{ url('student-attendance') }}">
                <span class="menu-bullet">
                    <span class="bullet bullet-dot"></span>
                </span>
                <span class="menu-title">{{ _lang('Student Attendance') }}</span>
            </a>
            <!--end:Menu link-->
        </div>
        <!--end:Menu item-->

        <!--begin:Menu item-->
        <div class="menu-item">
            <!--begin:Menu link-->
            <a class="menu-link {{ Request::is('exams-attendance') ? 'active' : '' }}"
                href="{{ url('exams-attendance') }}">
                <span class="menu-bullet">
                    <span class="bullet bullet-dot"></span>
                </span>
                <span class="menu-title">{{ _lang('Exam Attendance') }}</span>
            </a>
            <!--end:Menu link-->
        </div>
        <!--end:Menu item-->

        <!--begin:Menu item-->
        <div class="menu-item">
            <!--begin:Menu link-->
            <a class="menu-link {{ Request::is('reports-student_attendance_date_to_date') || Request::is('reports-student_attendance_date_to_date') || Request::is('reports-student_attendance_date_to_date/view') ? 'active' : '' }}"
                href="{{ url('reports-student_attendance_date_to_date') }}">
                <span class="menu-bullet">
                    <span class="bullet bullet-dot"></span>
                </span>
                <span class="menu-title">{{ _lang('Attendance Report') }}</span>
            </a>
            <!--end:Menu link-->
        </div>
        <!--end:Menu item-->

        <!--begin:Menu item-->
        <div class="menu-item">
            <!--begin:Menu link-->
            <a class="menu-link {{ Request::is('student_attendance/delete') ? 'active' : '' }}"
                href="{{ route('student_attendance.delete') }}">
                <span class="menu-bullet">
                    <span class="bullet bullet-dot"></span>
                </span>
                <span class="menu-title">{{ _lang('Attendance Delete') }}</span>
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
    <a class="menu-link {{ Route::is('teacher/assignments') ? 'active' : '' }}"
        href="{{ url('teacher/assignments') }}">
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
        <span class="menu-title">{{ _lang('Assignment') }}</span>
    </a>
    <!--end:Menu link-->
</div>

<div class="menu-item">
    <!--begin:Menu link-->
    <a class="menu-link {{ Route::is('syllabus') ? 'active' : '' }}" href="{{ url('syllabus') }}">
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
    <a class="menu-link {{ Route::is('teacher/class-schedule') ? 'active' : '' }}"
        href="{{ url('teacher/class-schedule') }}">
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
        <span class="menu-title">{{ _lang('Class Schedule') }}</span>
    </a>
    <!--end:Menu link-->
</div>



<div class="menu-item">
    <!--begin:Menu link-->
    <a class="menu-link {{ Route::is('resources') ? 'active' : '' }}" href="{{ url('resources') }}">
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
        <span class="menu-title">{{ _lang('resources') }}</span>
    </a>
    <!--end:Menu link-->
</div>

<div class="menu-item">
    <!--begin:Menu link-->
    <a class="menu-link {{ Route::is('classlessons') ? 'active' : '' }}" href="{{ url('classlessons') }}">
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
        <span class="menu-title">{{ _lang('Class lessons') }}</span>
    </a>
    <!--end:Menu link-->
</div>

<div class="menu-item">
    <!--begin:Menu link-->
    <a class="menu-link {{ Route::is('prayers') ? 'active' : '' }}" href="{{ url('prayers') }}">
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
        <span class="menu-title">{{ _lang('prayers') }}</span>
    </a>
    <!--end:Menu link-->
</div>

<div class="menu-item">
    <!--begin:Menu link-->
    <a class="menu-link {{ Route::is('behaviors') ? 'active' : '' }}" href="{{ url('behaviors') }}">
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
        <span class="menu-title">{{ _lang('behaviors') }}</span>
    </a>
    <!--end:Menu link-->
</div>

<div class="menu-item">
    <!--begin:Menu link-->
    <a class="menu-link {{ Route::is('gamifications') ? 'active' : '' }}" href="{{ url('gamifications') }}">
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
        <span class="menu-title">{{ _lang('gamifications') }}</span>
    </a>
    <!--end:Menu link-->
</div>

<!--begin:Menu item-->
<div data-kt-menu-trigger="click"
    class="menu-item menu-accordion {{ Request::is('topics') || Request::is('topics/*') || Request::is('questions') || Request::is('questions/*') || Request::is('answers') || Request::is('answers/*') || Request::is('all-reports') || Request::is('all-reports/*') ? 'here show' : '' }}">

    <!--begin:Menu link-->
    <span class="menu-link">
        <span class="menu-icon">
            <!--begin::Svg Icon | path: icons/duotune/general/gen025.svg-->
            <span class="svg-icon svg-icon-2">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                    xmlns="http://www.w3.org/2000/svg">
                    <path opacity="0.3"
                        d="M4.05424 15.1982C8.34524 7.76818 13.5782 3.26318 20.9282 2.01418C21.0729 1.98837 21.2216 1.99789 21.3618 2.04193C21.502 2.08597 21.6294 2.16323 21.7333 2.26712C21.8372 2.37101 21.9144 2.49846 21.9585 2.63863C22.0025 2.7788 22.012 2.92754 21.9862 3.07218C20.7372 10.4222 16.2322 15.6552 8.80224 19.9462L4.05424 15.1982ZM3.81924 17.3372L2.63324 20.4482C2.58427 20.5765 2.5735 20.7163 2.6022 20.8507C2.63091 20.9851 2.69788 21.1082 2.79503 21.2054C2.89218 21.3025 3.01536 21.3695 3.14972 21.3982C3.28408 21.4269 3.42387 21.4161 3.55224 21.3672L6.66524 20.1802L3.81924 17.3372ZM16.5002 5.99818C16.2036 5.99818 15.9136 6.08615 15.6669 6.25097C15.4202 6.41579 15.228 6.65006 15.1144 6.92415C15.0009 7.19824 14.9712 7.49984 15.0291 7.79081C15.0869 8.08178 15.2298 8.34906 15.4396 8.55884C15.6494 8.76862 15.9166 8.91148 16.2076 8.96935C16.4986 9.02723 16.8002 8.99753 17.0743 8.884C17.3484 8.77046 17.5826 8.5782 17.7474 8.33153C17.9123 8.08486 18.0002 7.79485 18.0002 7.49818C18.0002 7.10035 17.8422 6.71882 17.5609 6.43752C17.2796 6.15621 16.8981 5.99818 16.5002 5.99818Z"
                        fill="currentColor"></path>
                    <path
                        d="M4.05423 15.1982L2.24723 13.3912C2.15505 13.299 2.08547 13.1867 2.04395 13.0632C2.00243 12.9396 1.9901 12.8081 2.00793 12.679C2.02575 12.5498 2.07325 12.4266 2.14669 12.3189C2.22013 12.2112 2.31752 12.1219 2.43123 12.0582L9.15323 8.28918C7.17353 10.3717 5.4607 12.6926 4.05423 15.1982ZM8.80023 19.9442L10.6072 21.7512C10.6994 21.8434 10.8117 21.9129 10.9352 21.9545C11.0588 21.996 11.1903 22.0083 11.3195 21.9905C11.4486 21.9727 11.5718 21.9252 11.6795 21.8517C11.7872 21.7783 11.8765 21.6809 11.9402 21.5672L15.7092 14.8442C13.6269 16.8245 11.3061 18.5377 8.80023 19.9442ZM7.04023 18.1832L12.5832 12.6402C12.7381 12.4759 12.8228 12.2577 12.8195 12.032C12.8161 11.8063 12.725 11.5907 12.5653 11.4311C12.4057 11.2714 12.1901 11.1803 11.9644 11.1769C11.7387 11.1736 11.5205 11.2583 11.3562 11.4132L5.81323 16.9562L7.04023 18.1832Z"
                        fill="currentColor"></path>
                </svg>
            </span>
            <!--end::Svg Icon-->
        </span>
        <span class="menu-title">{{ _lang('Quiz') }}</span>
        <span class="menu-arrow"></span>
    </span>
    <!--end:Menu link-->

    <!--begin:Menu sub-->
    <div class="menu-sub menu-sub-accordion">
        <!--begin:Menu item-->
        <div class="menu-item">
            <!--begin:Menu link-->
            <a class="menu-link {{ Request::is('topics') || Request::is('topics/*') ? 'active' : '' }}"
                href="{{ route('topics.index') }}">
                <span class="menu-bullet">
                    <span class="bullet bullet-dot"></span>
                </span>
                <span class="menu-title">{{ _lang('Topics') }}</span>
            </a>
            <!--end:Menu link-->
        </div>
        <!--end:Menu item-->

        <!--begin:Menu item-->
        <div class="menu-item">
            <!--begin:Menu link-->
            <a class="menu-link {{ Request::is('questions') || Request::is('questions/*') ? 'active' : '' }}"
                href="{{ route('questions.index') }}">
                <span class="menu-bullet">
                    <span class="bullet bullet-dot"></span>
                </span>
                <span class="menu-title">{{ _lang('Questions') }}</span>
            </a>
            <!--end:Menu link-->
        </div>
        <!--end:Menu item-->

        <!--begin:Menu item-->
        <div class="menu-item">
            <!--begin:Menu link-->
            <a class="menu-link {{ Request::is('answers') || Request::is('answers/*') ? 'active' : '' }}"
                href="{{ route('answers.index') }}">
                <span class="menu-bullet">
                    <span class="bullet bullet-dot"></span>
                </span>
                <span class="menu-title">{{ _lang('Answers') }}</span>
            </a>
            <!--end:Menu link-->
        </div>
        <!--end:Menu item-->

        <!--begin:Menu item-->
        <div class="menu-item">
            <!--begin:Menu link-->
            <a class="menu-link {{ Request::is('all-reports') || Request::is('all-reports/*') ? 'active' : '' }}"
                href="{{ route('all-reports.index') }}">
                <span class="menu-bullet">
                    <span class="bullet bullet-dot"></span>
                </span>
                <span class="menu-title">{{ _lang('Quiz Results') }}</span>
            </a>
            <!--end:Menu link-->
        </div>
        <!--end:Menu item-->

    </div>
    <!--end:Menu sub-->
</div>
<!--end:Menu item-->

<!--begin:Menu item-->
<div data-kt-menu-trigger="click"
    class="menu-item menu-accordion {{ Request::is('semester-exam-settings-exam-startup') || Request::is('semester-exam-settings-mark-config') || Request::is('semester-exam-settings-mark-config/*') || Request::is('remarks-config') || Request::is('remarks-config/*') || Request::is('mark-input-section-wise') || Request::is('mark-input-section-wise-class') || Request::is('mark-input-section-wise-class/*') || Request::is('exam-result-view') ? 'here show' : '' }}">
    <!--begin:Menu link-->
    <span class="menu-link">
        <span class="menu-icon">
            <!--begin::Svg Icon | path: icons/duotune/general/gen025.svg-->
            <span class="svg-icon svg-icon-2">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                    xmlns="http://www.w3.org/2000/svg">
                    <path
                        d="M20 7H3C2.4 7 2 6.6 2 6V3C2 2.4 2.4 2 3 2H20C20.6 2 21 2.4 21 3V6C21 6.6 20.6 7 20 7ZM7 9H3C2.4 9 2 9.4 2 10V20C2 20.6 2.4 21 3 21H7C7.6 21 8 20.6 8 20V10C8 9.4 7.6 9 7 9Z"
                        fill="currentColor"></path>
                    <path opacity="0.3"
                        d="M20 21H11C10.4 21 10 20.6 10 20V10C10 9.4 10.4 9 11 9H20C20.6 9 21 9.4 21 10V20C21 20.6 20.6 21 20 21Z"
                        fill="currentColor"></path>
                </svg>
            </span>
            <!--end::Svg Icon-->
        </span>
        <span class="menu-title">{{ _lang('Exam Module') }}</span>
        <span class="menu-arrow"></span>
    </span>
    <!--end:Menu link-->
    <!--begin:Menu sub-->
    <div class="menu-sub menu-sub-accordion">
        <!--begin:Menu item-->
        <div class="menu-item">
            <!--begin:Menu link-->
            <a class="menu-link {{ Request::is('mark-input-section-wise') || Request::is('mark-input-section-wise-class') || Request::is('mark-input-section-wise-class/*') ? 'active' : '' }}"
                href="{{ route('mark-input-section-wise') }}">
                <span class="menu-bullet">
                    <span class="bullet bullet-dot"></span>
                </span>
                <span class="menu-title">{{ _lang('Mark Input') }}</span>
            </a>
            <!--end:Menu link-->
        </div>
        <!--end:Menu item-->

        <!--begin:Menu item-->
        <div class="menu-item">
            <!--begin:Menu link-->
            <a class="menu-link {{ Request::is('exam-result-view') ? 'active' : '' }}"
                href="{{ url('exam-result-view') }}">
                <span class="menu-bullet">
                    <span class="bullet bullet-dot"></span>
                </span>
                <span class="menu-title text-danger">{{ _lang('Exam Result') }}</span>
            </a>
            <!--end:Menu link-->
        </div>
        <!--end:Menu item-->
    </div>
    <!--end:Menu sub-->
</div>
<!--end:Menu item-->
