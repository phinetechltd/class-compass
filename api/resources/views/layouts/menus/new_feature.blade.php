@if ($user->can('sms_notifications.todo_module'))
    <!--begin:Menu item-->
    <div data-kt-menu-trigger="click"
        class="menu-item menu-accordion {{ Request::is('sms-template') || Request::is('sms-template/*') || Request::is('phone-book') || Request::is('phone-book/*') || Request::is('phone-book-category') || Request::is('phone-book-category/*') || Request::is('sms/compose') || Request::is('sms/institute') || Request::is('sms/institute*') || Request::is('sms/notification') || Request::is('sms/notification-sent') || Request::is('sms-purchase') || Request::is('sms-purchase/*') || Request::is('sms-send-report-all') || Request::is('sms-send-report-all') ? 'here show' : '' }}">

        <!--begin:Menu link-->
        <span class="menu-link">
            <span class="menu-icon">
                <!--begin::Svg Icon | path: icons/duotune/general/gen025.svg-->
                <span class="svg-icon svg-icon-2">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path opacity="0.3"
                            d="M21 19H3C2.4 19 2 18.6 2 18V6C2 5.4 2.4 5 3 5H21C21.6 5 22 5.4 22 6V18C22 18.6 21.6 19 21 19Z"
                            fill="currentColor"></path>
                        <path
                            d="M21 5H2.99999C2.69999 5 2.49999 5.10005 2.29999 5.30005L11.2 13.3C11.7 13.7 12.4 13.7 12.8 13.3L21.7 5.30005C21.5 5.10005 21.3 5 21 5Z"
                            fill="currentColor"></path>
                    </svg>
                </span>
                <!--end::Svg Icon-->
            </span>
            <span class="menu-title">{{ _lang('SMS Module') }}</span>
            <span class="menu-arrow"></span>
        </span>
        <!--end:Menu link-->

        <!--begin:Menu sub-->
        <div class="menu-sub menu-sub-accordion">

            <!--begin:Menu item-->
            <div class="menu-item">
                <!--begin:Menu link-->
                <a class="menu-link {{ Request::is('sms-template') || Request::is('sms-template/*') ? 'active' : '' }}"
                    href="{{ route('sms-template.index') }}">
                    <span class="menu-bullet">
                        <span class="bullet bullet-dot"></span>
                    </span>
                    <span class="menu-title">{{ _lang('SMS Template') }}</span>
                </a>
                <!--end:Menu link-->
            </div>
            <!--end:Menu item-->

            <!--begin:Menu item-->
            <div class="menu-item">
                <!--begin:Menu link-->
                <a class="menu-link {{ Request::is('phone-book') || Request::is('phone-book/*') ? 'active' : '' }}"
                    href="{{ route('phone-book.index') }}">
                    <span class="menu-bullet">
                        <span class="bullet bullet-dot"></span>
                    </span>
                    <span class="menu-title">{{ _lang('Phone Book') }}</span>
                </a>
                <!--end:Menu link-->
            </div>
            <!--end:Menu item-->

            <!--begin:Menu item-->
            <div class="menu-item">
                <!--begin:Menu link-->
                <a class="menu-link {{ Request::is('phone-book-category') ? 'active' : '' }}"
                    href="{{ route('phone-book-category.index') }}">
                    <span class="menu-bullet">
                        <span class="bullet bullet-dot"></span>
                    </span>
                    <span class="menu-title">{{ _lang('Category') }}</span>
                </a>
                <!--end:Menu link-->
            </div>
            <!--end:Menu item-->

            <!--begin:Menu item-->
            <div class="menu-item">
                <!--begin:Menu link-->
                <a class="menu-link {{ Request::is('sms/compose') || Request::is('sms/institute') || Request::is('sms/institute*') || Request::is('sms/notification') || Request::is('sms/notification-sent') ? 'active' : '' }}"
                    href="{{ url('sms/compose') }}">
                    <span class="menu-bullet">
                        <span class="bullet bullet-dot"></span>
                    </span>
                    <span class="menu-title">{{ _lang('Person Wise') }}</span>
                </a>
                <!--end:Menu link-->
            </div>
            <!--end:Menu item-->

            <!--begin:Menu item-->
            <div class="menu-item">
                <!--begin:Menu link-->
                <a class="menu-link {{ Request::is('sms/notification') || Request::is('sms/notification-sent') ? 'active' : '' }}"
                    href="{{ url('sms/notification') }}">
                    <span class="menu-bullet">
                        <span class="bullet bullet-dot"></span>
                    </span>
                    <span class="menu-title">{{ _lang('Notification Wise') }}</span>
                </a>
                <!--end:Menu link-->
            </div>
            <!--end:Menu item-->

            <!--begin:Menu item-->
            <div class="menu-item">
                <!--begin:Menu link-->
                <a class="menu-link {{ Request::is('sms-purchase') || Request::is('sms-purchase/*') ? 'active' : '' }}"
                    href="{{ route('sms-purchase.index') }}">
                    <span class="menu-bullet">
                        <span class="bullet bullet-dot"></span>
                    </span>
                    <span class="menu-title">{{ _lang('Purchase SMS') }}</span>
                </a>
                <!--end:Menu link-->
            </div>
            <!--end:Menu item-->

            <!--begin:Menu item-->
            <div class="menu-item">
                <!--begin:Menu link-->
                <a class="menu-link {{ Request::is('sms-send-report-all') || Request::is('sms-send-report-all') ? 'active' : '' }}"
                    href="{{ route('sms.sendReport-all') }}">
                    <span class="menu-bullet">
                        <span class="bullet bullet-dot"></span>
                    </span>
                    <span class="menu-title">{{ _lang('SMS Report') }}</span>
                </a>
                <!--end:Menu link-->
            </div>
            <!--end:Menu item-->

        </div>
        <!--end:Menu sub-->
    </div>
    <!--end:Menu item-->
@endif
