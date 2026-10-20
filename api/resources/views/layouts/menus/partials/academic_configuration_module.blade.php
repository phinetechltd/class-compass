@if (
    $user->can('academic_configuration.academic_session') ||
        $user->can('academic_configuration.shifts') ||
        $user->can('academic_configuration.classes') ||
        $user->can('academic_configuration.sections') ||
        $user->can('academic_configuration.groups') ||
        $user->can('academic_configuration.periods') ||
        $user->can('academic_configuration.subjects') ||
        $user->can('academic_configuration.subject_config') ||
        $user->can('academic_configuration.exams') ||
        $user->can('academic_configuration.student_categories') ||
        $user->can('academic_configuration.departments') ||
        $user->can('academic_configuration.picklist') ||
        $user->can('academic_configuration.principal_signatures'))

    <!--begin:Menu item-->
    <div data-kt-menu-trigger="click"
        class="menu-item menu-accordion {{ Request::is('academic-years') ||
        Request::is('student-categories') ||
        Request::is('student-categories/*') ||
        Request::is('periods') ||
        Request::is('periods/*') ||
        Request::is('departments') ||
        Request::is('departments/*') ||
        Request::is('sections') ||
        Request::is('sections/*') ||
        Request::is('sections-class/*') ||
        Request::is('subjects') ||
        Request::is('subjects/*') ||
        Request::is('subject-config') ||
        Request::is('subject-config/*') ||
        Request::is('class') ||
        Request::is('class/*') ||
        Request::is('leave') ||
        Request::is('leave/*') ||
        Request::is('student_groups') ||
        Request::is('student_groups/*') ||
        Request::is('shift') ||
        Request::is('shift/*') ||
        Request::is('picklists') ||
        Request::is('picklists/*') ||
        Request::is('picklists-type/*') ||
        Request::is('signatures') ||
        Request::is('signatures/*') ||
        Request::is('exams') ||
        Request::is('student-groups') ||
        Request::is('student-groups/*')
            ? 'here show'
            : '' }}">

        <!--begin:Menu link-->
        <span class="menu-link">
            <span class="menu-icon">
                <!--begin::Svg Icon | path: icons/duotune/general/gen025.svg-->
                <span class="svg-icon svg-icon-2">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path
                            d="M11.7 8L7.49998 15.3L4.59999 20.3C3.49999 18.4 3.1 17.7 2.3 16.3C1.9 15.7 1.9 14.9 2.3 14.3L8.8 3L11.7 8Z"
                            fill="currentColor"></path>
                        <path opacity="0.3"
                            d="M11.7 8L8.79999 3H13.4C14.1 3 14.8 3.4 15.2 4L20.6 13.3H14.8L11.7 8ZM7.49997 15.2L4.59998 20.2H17.6C18.3 20.2 19 19.8 19.4 19.2C20.2 17.7 20.6 17 21.7 15.2H7.49997Z"
                            fill="currentColor"></path>
                    </svg>
                </span>
                <!--end::Svg Icon-->
            </span>
            <span class="menu-title">{{ _lang('Academic Configuration') }}</span>
            <span class="menu-arrow"></span>
        </span>
        <!--end:Menu link-->

        <!--begin:Menu sub-->
        <div class="menu-sub menu-sub-accordion">
            @if ($user->can('academic_configuration.academic_session'))
                <!--begin:Menu item-->
                <div class="menu-item">
                    <!--begin:Menu link-->
                    <a class="menu-link {{ Request::is('academic-years') || Request::is('academic-years/*') ? 'active' : '' }}"
                        href="{{ route('academic-years.index') }}">
                        <span class="menu-bullet">
                            <span class="bullet bullet-dot"></span>
                        </span>
                        <span class="menu-title text-danger">{{ _lang('Academic Session') }}</span>
                    </a>
                    <!--end:Menu link-->
                </div>
                <!--end:Menu item-->
            @endif

            @if ($user->can('academic_configuration.shifts'))
                <!--begin:Menu item-->
                <div class="menu-item">
                    <!--begin:Menu link-->
                    <a class="menu-link {{ Request::is('shift') || Request::is('shift/*') ? 'active' : '' }}"
                        href="{{ route('shift.index') }}">
                        <span class="menu-bullet">
                            <span class="bullet bullet-dot"></span>
                        </span>
                        <span class="menu-title">{{ _lang('Shift') }}</span>
                    </a>
                    <!--end:Menu link-->
                </div>
                <!--end:Menu item-->
            @endif

            @if ($user->can('academic_configuration.classes'))
                <!--begin:Menu item-->
                <div class="menu-item">
                    <!--begin:Menu link-->
                    <a class="menu-link {{ Request::is('class') || Request::is('class/*') ? 'active' : '' }}"
                        href="{{ route('class.index') }}">
                        <span class="menu-bullet">
                            <span class="bullet bullet-dot"></span>
                        </span>
                        <span class="menu-title">{{ _lang('Class') }}</span>
                    </a>
                    <!--end:Menu link-->
                </div>
                <!--end:Menu item-->
            @endif

            @if ($user->can('academic_configuration.sections'))
                <!--begin:Menu item-->
                <div class="menu-item">
                    <!--begin:Menu link-->
                    <a class="menu-link {{ Request::is('sections') || Request::is('sections/*') || Request::is('sections-class/*') ? 'active' : '' }}"
                        href="{{ route('sections.index') }}">
                        <span class="menu-bullet">
                            <span class="bullet bullet-dot"></span>
                        </span>
                        <span class="menu-title">{{ _lang('Sections') }}</span>
                    </a>
                    <!--end:Menu link-->
                </div>
                <!--end:Menu item-->
            @endif

            @if ($user->can('academic_configuration.groups'))
                <!--begin:Menu item-->
                <div class="menu-item">
                    <!--begin:Menu link-->
                    <a class="menu-link {{ Request::is('student-groups') || Request::is('student-groups/*') ? 'active' : '' }}"
                        href="{{ route('student-groups.index') }}">
                        <span class="menu-bullet">
                            <span class="bullet bullet-dot"></span>
                        </span>
                        <span class="menu-title">{{ _lang('Groups') }}</span>
                    </a>
                    <!--end:Menu link-->
                </div>
                <!--end:Menu item-->
            @endif

            @if ($user->can('academic_configuration.periods'))
                <!--begin:Menu item-->
                <div class="menu-item">
                    <!--begin:Menu link-->
                    <a class="menu-link {{ Request::is('periods') || Request::is('periods/*') ? 'active' : '' }}"
                        href="{{ route('periods.index') }}">
                        <span class="menu-bullet">
                            <span class="bullet bullet-dot"></span>
                        </span>
                        <span class="menu-title">{{ _lang('Periods') }}</span>
                    </a>
                    <!--end:Menu link-->
                </div>
                <!--end:Menu item-->
            @endif

            @if ($user->can('academic_configuration.subjects'))
                <!--begin:Menu item-->
                <div class="menu-item">
                    <!--begin:Menu link-->
                    <a class="menu-link {{ Request::is('subjects') || Request::is('subjects/*') ? 'active' : '' }}"
                        href="{{ route('subjects.index') }}">
                        <span class="menu-bullet">
                            <span class="bullet bullet-dot"></span>
                        </span>
                        <span class="menu-title">{{ _lang('Subjects') }}</span>
                    </a>
                    <!--end:Menu link-->
                </div>
                <!--end:Menu item-->
            @endif

            @if ($user->can('academic_configuration.subject_config'))
                <!--begin:Menu item-->
                <div class="menu-item">
                    <!--begin:Menu link-->
                    <a class="menu-link {{ Request::is('subject-config') || Request::is('subject-config/*') ? 'active' : '' }}"
                        href="{{ route('subject-config.create') }}">
                        <span class="menu-bullet">
                            <span class="bullet bullet-dot"></span>
                        </span>
                        <span class="menu-title">{{ _lang('Subject Config') }}</span>
                    </a>
                    <!--end:Menu link-->
                </div>
                <!--end:Menu item-->
            @endif

            @if ($user->can('academic_configuration.exams'))
                <!--begin:Menu item-->
                <div class="menu-item">
                    <!--begin:Menu link-->
                    <a class="menu-link {{ Request::is('exams') ? 'active' : '' }}" href="{{ url('exams') }}">
                        <span class="menu-bullet">
                            <span class="bullet bullet-dot"></span>
                        </span>
                        <span class="menu-title">{{ _lang('Exam') }}</span>
                    </a>
                    <!--end:Menu link-->
                </div>
                <!--end:Menu item-->
            @endif

            @if ($user->can('academic_configuration.student_categories'))
                <!--begin:Menu item-->
                <div class="menu-item">
                    <!--begin:Menu link-->
                    <a class="menu-link {{ Request::is('student-categories') || Request::is('student-categories/*') ? 'active' : '' }}"
                        href="{{ route('student-categories.index') }}">
                        <span class="menu-bullet">
                            <span class="bullet bullet-dot"></span>
                        </span>
                        <span class="menu-title">{{ _lang('Student Categories') }}</span>
                    </a>
                    <!--end:Menu link-->
                </div>
                <!--end:Menu item-->
            @endif


            @if ($user->can('academic_configuration.departments'))
                <!--begin:Menu item-->
                <div class="menu-item">
                    <!--begin:Menu link-->
                    <a class="menu-link {{ Request::is('departments') || Request::is('departments/*') ? 'active' : '' }}"
                        href="{{ route('departments.index') }}">
                        <span class="menu-bullet">
                            <span class="bullet bullet-dot"></span>
                        </span>
                        <span class="menu-title">{{ _lang('Departments') }}</span>
                    </a>
                    <!--end:Menu link-->
                </div>
                <!--end:Menu item-->
            @endif

            @if ($user->can('academic_configuration.picklist'))
                <!--begin:Menu item-->
                <div class="menu-item">
                    <!--begin:Menu link-->
                    <a class="menu-link {{ Request::is('picklists') || Request::is('picklists/*') || Request::is('picklists-type/*') ? 'active' : '' }}"
                        href="{{ route('picklists.index') }}">
                        <span class="menu-bullet">
                            <span class="bullet bullet-dot"></span>
                        </span>
                        <span class="menu-title">{{ _lang('Picklist') }}</span>
                    </a>
                    <!--end:Menu link-->
                </div>
                <!--end:Menu item-->
            @endif

            @if ($user->can('academic_configuration.principal_signatures'))
                <!--begin:Menu item-->
                <div class="menu-item">
                    <!--begin:Menu link-->
                    <a class="menu-link {{ Request::is('signatures') || Request::is('signatures/*') ? 'active' : '' }}"
                        href="{{ route('signatures.index') }}">
                        <span class="menu-bullet">
                            <span class="bullet bullet-dot"></span>
                        </span>
                        <span class="menu-title text-danger">{{ _lang('Principal Signature') }}</span>
                    </a>
                    <!--end:Menu link-->
                </div>
                <!--end:Menu item-->
            @endif

        </div>
        <!--end:Menu sub-->
    </div>
    <!--end:Menu item-->
@endif
