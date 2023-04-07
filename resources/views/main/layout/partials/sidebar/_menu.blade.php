<div class="app-sidebar-menu overflow-hidden flex-column-fluid">
    <!--begin::Menu wrapper-->
    <div id="kt_app_sidebar_menu_wrapper" class="app-sidebar-wrapper hover-scroll-overlay-y my-5" data-kt-scroll="true"
        data-kt-scroll-activate="true" data-kt-scroll-height="auto"
        data-kt-scroll-dependencies="#kt_app_sidebar_logo, #kt_app_sidebar_footer"
        data-kt-scroll-wrappers="#kt_app_sidebar_menu" data-kt-scroll-offset="5px" data-kt-scroll-save-state="true">
        <!--begin::Menu-->
        <div class="menu menu-column menu-rounded menu-sub-indention px-3" id="#kt_app_sidebar_menu" data-kt-menu="true"
            data-kt-menu-expand="false">
            <div data-kt-menu-trigger="click" class="menu-item here show menu-accordion">
                <a href="home"><span class="menu-link"><span class="menu-icon"><i
                                class="bi bi-grid fs-3"></i></span><span class="menu-title">Dashboards</span></span></a>
            </div>
            @foreach (getMenus() as $item_menu)
                @php
                    $path_array = array_column($item_menu, 'path');
                    $path = array_search(Request::segment(1), $path_array);
                    
                    if ($path != '') {
                        $show = 'show';
                    } else {
                        $show = '';
                    }
                @endphp
                <div data-kt-menu-trigger="click" class="menu-item {{ $show }} menu-accordion">
                    <span class="menu-link"><span class="menu-icon"> <i
                                class='fa {{ $item_menu[0]['icon'] }} '></i></span><span
                            class="menu-title">{{ $item_menu[0]['nama_menu'] }}</span><span
                            class="menu-arrow"></span></span>
                    <div class="menu-sub menu-sub-accordion">
                        @foreach ($item_menu as $item_sub_menu)
                            @if (Request::segment(1) == $item_sub_menu['path'])
                                {
                                @php $active = "active";@endphp
                                }
                            @else
                                {
                                @php $active = "";@endphp
                                }
                            @endif

                            <div class="menu-item"><a class="menu-link {{ $active }}"
                                    href="{{ URL::to('/'.$item_sub_menu['path'])  }}"><span class="menu-bullet"><span> <i
                                                class='fa {{ $item_sub_menu['icon_modul'] }} '></i> </span></span><span
                                        class="menu-title">{{ $item_sub_menu['nama_modul'] }}</span></a></div>
                        @endforeach
                    </div>
                </div>
            @endforeach
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
