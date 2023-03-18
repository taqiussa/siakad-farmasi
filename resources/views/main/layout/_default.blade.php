<!--begin::App-->
<div class="d-flex flex-column flex-root app-root" id="kt_app_root">
    <!--begin::Page-->
    <div class="app-page  flex-column flex-column-fluid " id="kt_app_page">
        @include('main.layout.partials._header')
        <!--begin::Wrapper-->
        <div class="app-wrapper  flex-column flex-row-fluid " id="kt_app_wrapper">
            @include('main.layout.partials._sidebar')
            <!--begin::Main-->
            <div class="app-main flex-column flex-row-fluid" id="kt_app_main">
                <!--begin::Content wrapper-->
                <div class="d-flex flex-column flex-column-fluid">
                    @include('main.layout.partials._toolbar')
                    @include('main.layout.partials._content')
                </div>
                <!--end::Content wrapper-->
                @include('main.layout.partials._footer')
            </div>
            <!--end:::Main-->
        </div>
        <!--end::Wrapper-->
    </div>
    <!--end::Page-->
</div>
<!--end::App-->
<!--layout-partial:partials/_drawers.php' ?> ?>
