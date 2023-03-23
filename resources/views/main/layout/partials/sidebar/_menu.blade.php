<!--begin::sidebar menu-->
<div class="app-sidebar-menu overflow-hidden flex-column-fluid">
    <!--begin::Menu wrapper-->
    <div id="kt_app_sidebar_menu_wrapper" class="app-sidebar-wrapper hover-scroll-overlay-y my-5" data-kt-scroll="true" data-kt-scroll-activate="true" data-kt-scroll-height="auto" data-kt-scroll-dependencies="#kt_app_sidebar_logo, #kt_app_sidebar_footer" data-kt-scroll-wrappers="#kt_app_sidebar_menu" data-kt-scroll-offset="5px" data-kt-scroll-save-state="true">
        <!--begin::Menu-->
        <div class="menu menu-column menu-rounded menu-sub-indention px-3" id="#kt_app_sidebar_menu" data-kt-menu="true" data-kt-menu-expand="false">
            <!--begin:Menu item-->
            <div data-kt-menu-trigger="click" class="menu-item here show menu-accordion"><!--begin:Menu link--><span class="menu-link"><span class="menu-icon"><i class="bi bi-grid fs-3"></i></span><span class="menu-title">Dashboards</span></span><!--end:Menu link--><!--begin:Menu sub-->
                
            </div><!--end:Menu item--><!--begin:Menu item-->
            <div data-kt-menu-trigger="click" class="menu-item menu-accordion"><!--begin:Menu link--><span class="menu-link"><span class="menu-icon"><i class="bi bi-person-lines-fill fs-3"></i></span><span class="menu-title">User Profile</span><span class="menu-arrow"></span></span><!--end:Menu link--><!--begin:Menu sub-->
                <div class="menu-sub menu-sub-accordion"><!--begin:Menu item-->
                    <div class="menu-item"><!--begin:Menu link--><a class="menu-link" href="?page=pages/user-profile/overview"><span class="menu-bullet"><span class="bullet bullet-dot"></span></span><span class="menu-title">Overview</span></a><!--end:Menu link--></div><!--end:Menu item--><!--begin:Menu item-->
                    <div class="menu-item"><!--begin:Menu link--><a class="menu-link" href="?page=pages/user-profile/projects"><span class="menu-bullet"><span class="bullet bullet-dot"></span></span><span class="menu-title">Projects</span></a><!--end:Menu link--></div><!--end:Menu item--><!--begin:Menu item-->
                    <div class="menu-item"><!--begin:Menu link--><a class="menu-link" href="?page=pages/user-profile/campaigns"><span class="menu-bullet"><span class="bullet bullet-dot"></span></span><span class="menu-title">Campaigns</span></a><!--end:Menu link--></div><!--end:Menu item--><!--begin:Menu item-->
                    <div class="menu-item"><!--begin:Menu link--><a class="menu-link" href="?page=pages/user-profile/documents"><span class="menu-bullet"><span class="bullet bullet-dot"></span></span><span class="menu-title">Documents</span></a><!--end:Menu link--></div><!--end:Menu item--><!--begin:Menu item-->
                    <div class="menu-item"><!--begin:Menu link--><a class="menu-link" href="?page=pages/user-profile/followers"><span class="menu-bullet"><span class="bullet bullet-dot"></span></span><span class="menu-title">Followers</span></a><!--end:Menu link--></div><!--end:Menu item--><!--begin:Menu item-->
                    <div class="menu-item"><!--begin:Menu link--><a class="menu-link" href="?page=pages/user-profile/activity"><span class="menu-bullet"><span class="bullet bullet-dot"></span></span><span class="menu-title">Activity</span></a><!--end:Menu link--></div><!--end:Menu item-->
                </div><!--end:Menu sub-->
            </div><!--end:Menu item--><!--begin:Menu item-->
            <li class="nav-item">
                <a class="dropdown-item" href="{{ route('logout') }}"
                onclick="event.preventDefault();
                document.getElementById('logout-form').submit();">
                <i class="nav-icon fas fa-th"></i> Logout
                </a>
                
                <form id="logout-form" action="{{ route('logout') }}" method="POST" class="d-none">
                @csrf
                </form>
                </li>
        </div>
        <!--end::Menu-->
    </div>
    <!--end::Menu wrapper-->
</div>
<!--end::sidebar menu-->