<!--begin::Navbar-->
<div class="app-navbar flex-shrink-0">
    <!--begin::Search-->
    <div class="app-navbar-item align-items-stretch ms-1 ms-md-3">
        <!--layout-partial:partials/search/_dropdown.html-->
    </div>
    <!--end::Search-->
    <!--begin::My apps links-->
    <div class="app-navbar-item ms-1 ms-md-3">
        <!--begin::Menu wrapper-->
        <div class="btn btn-icon btn-custom btn-icon-muted btn-active-light btn-active-color-primary w-30px h-30px w-md-40px h-md-40px"
            data-kt-menu-trigger="{default: 'click', lg: 'hover'}" data-kt-menu-attach="parent"
            data-kt-menu-placement="bottom-end">
            <span class="svg-icon svg-icon-2 svg-icon-md-1"><svg width="24" height="24" viewBox="0 0 24 24"
                fill="none" xmlns="http://www.w3.org/2000/svg">
                <rect x="2" y="2" width="9" height="9" rx="2"
                    fill="currentColor" />
                <rect opacity="0.3" x="13" y="2" width="9" height="9" rx="2"
                    fill="currentColor" />
                <rect opacity="0.3" x="13" y="13" width="9" height="9" rx="2"
                    fill="currentColor" />
                <rect opacity="0.3" x="2" y="13" width="9" height="9" rx="2"
                    fill="currentColor" />
            </svg>
        </span>
        </div>

        <!--begin::My apps-->
        <div class="menu menu-sub menu-sub-dropdown menu-column w-100 w-sm-350px" data-kt-menu="true" style="">
            <!--begin::Card-->
            <div class="card">
                <!--begin::Card header-->
                <div class="card-header">
                    <!--begin::Card title-->
                    <div class="card-title">Aplikasi</div>
                    <!--end::Card title-->

                    <!--begin::Card toolbar-->
                    <div class="card-toolbar">
                        <!--begin::Menu-->
                        <button type="button" class="btn btn-sm btn-icon btn-active-light-primary me-n3"
                            data-kt-menu-trigger="{default: 'click', lg: 'hover'}" data-kt-menu-placement="bottom-end">
                            <i class="ki-duotone ki-setting-3 fs-2"><span class="path1"></span><span
                                    class="path2"></span><span class="path3"></span><span class="path4"></span><span
                                    class="path5"></span></i> </button>

                       
                    </div>
                    <!--end::Card toolbar-->
                </div>
                <!--end::Card header-->

                <!--begin::Card body-->
                <div class="card-body py-5">
                    <!--begin::Scroll-->
                    <div class="mh-450px scroll-y me-n5 pe-5">
                        <!--begin::Row-->
                        <div class="row g-2">
                            <!--begin::Col-->
                            @foreach (getApplikasi() as $item_aplikasi)
                            <div class="col-4">
                                <a href="#"
                                    class="d-flex flex-column flex-center text-center text-gray-800 text-hover-primary bg-hover-light rounded py-4 px-3 mb-3">
                                    <img src="/images/logo/{{$item_aplikasi->image}}"
                                        class="w-25px h-25px mb-2" alt="">
                                    <span class="fw-semibold">{{$item_aplikasi->nama_aplikasi}}</span>
                                </a>
                            </div>
                            @endforeach
                            <!--end::Col-->
                        </div>
                        <!--end::Row-->
                    </div>
                    <!--end::Scroll-->
                </div>
                <!--end::Card body-->
            </div>
            <!--end::Card-->
        </div>
        <!--end::My apps-->
        <!--end::Menu wrapper-->
    </div>
    <!--end::My apps links-->
    <!--begin::Theme mode-->
    <div class="app-navbar-item ms-1 ms-md-3">
        <!--layout-partial:partials/theme-mode/_main.html-->
    </div>
    <!--end::Theme mode-->
    <div class="app-navbar-item ms-1 ms-md-3" id="kt_header_user_menu_toggle">
        <!--begin::Menu wrapper-->
        <div class="cursor-pointer symbol symbol-30px symbol-md-40px"
            data-kt-menu-trigger="{default: 'click', lg: 'hover'}" data-kt-menu-attach="parent"
            data-kt-menu-placement="bottom-end">
            <img src="{{ url('admin/assets/media/avatars/300-1.jpg') }}" alt="user">
        </div>

        <!--begin::User account menu-->
        <div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-800 menu-state-bg menu-state-color fw-semibold py-4 fs-6 w-275px"
            data-kt-menu="true" style="">
            <!--begin::Menu item-->
            <div class="menu-item px-3">
                <div class="menu-content d-flex align-items-center px-3">
                    <!--begin::Avatar-->
                    <div class="symbol symbol-50px me-5">
                        <img alt="Logo" src="{{ url('admin/assets/media/avatars/300-1.jpg') }}">
                    </div>
                    <!--end::Avatar-->

                    <!--begin::Username-->
                    <div class="d-flex flex-column">
                        <div class="fw-bold d-flex align-items-center fs-5">
                            {{ Auth::user()->name }} <span
                                class="badge badge-light-success fw-bold fs-8 px-2 py-1 ms-2"></span>
                        </div>

                        <a href="#" class="fw-semibold text-muted text-hover-primary fs-7">
                            {{ Auth::user()->email }} </a>
                    </div>
                    <!--end::Username-->
                </div>
            </div>
            <!--end::Menu item-->

            <!--begin::Menu separator-->
            <div class="separator my-2"></div>
            <!--end::Menu separator-->

            <!--begin::Menu item-->
            <div class="menu-item px-5">
                <a href="/metronic8/demo1/../demo1/account/overview.html" class="menu-link px-5">
                    My Profile
                </a>
            </div>
            <!--end::Menu item-->


            <!--begin::Menu separator-->
            <div class="separator my-2"></div>
            <!--end::Menu separator-->

            <!--begin::Menu item-->
            <div class="menu-item px-5">

                <a href="{{ route('logout') }}"
                    onclick="event.preventDefault();
            document.getElementById('logout-form').submit();"
                    class="menu-link px-5">
                    Sign Out
                </a>
            </div>
            <!--end::Menu item-->
        </div>
        <!--end::User account menu-->
        <!--end::Menu wrapper-->
    </div>
    <!--end::User menu-->
    <!--begin::Header menu toggle-->
    <div class="app-navbar-item d-lg-none ms-2 me-n3" title="Show header menu">
        <div class="btn btn-icon btn-active-color-primary w-30px h-30px w-md-35px h-md-35px"
            id="kt_app_header_menu_toggle">
            <!--begin::Svg Icon | path: icons/duotune/text/txt001.svg-->
            <span class="svg-icon svg-icon-2 svg-icon-md-1"><svg width="24" height="24" viewBox="0 0 24 24"
                    fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path
                        d="M13 11H3C2.4 11 2 10.6 2 10V9C2 8.4 2.4 8 3 8H13C13.6 8 14 8.4 14 9V10C14 10.6 13.6 11 13 11ZM22 5V4C22 3.4 21.6 3 21 3H3C2.4 3 2 3.4 2 4V5C2 5.6 2.4 6 3 6H21C21.6 6 22 5.6 22 5Z"
                        fill="currentColor" />
                    <path opacity="0.3"
                        d="M21 16H3C2.4 16 2 15.6 2 15V14C2 13.4 2.4 13 3 13H21C21.6 13 22 13.4 22 14V15C22 15.6 21.6 16 21 16ZM14 20V19C14 18.4 13.6 18 13 18H3C2.4 18 2 18.4 2 19V20C2 20.6 2.4 21 3 21H13C13.6 21 14 20.6 14 20Z"
                        fill="currentColor" />
                </svg>
            </span>
            <!--end::Svg Icon-->
        </div>
    </div>
    <!--end::Header menu toggle-->
</div>
<!--end::Navbar-->
