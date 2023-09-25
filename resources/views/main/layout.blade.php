<!DOCTYPE html>
<!--
Author: Keenthemes
Product Name: Metronic
Product Version: 8.1.7
Purchase: https://1.envato.market/EA4JP
Website: http://www.keenthemes.com
Contact: support@keenthemes.com
Follow: www.twitter.com/keenthemes
Dribbble: www.dribbble.com/keenthemes
Like: www.facebook.com/keenthemes
License: For each use you must have a valid license purchased only from above link in order to legally use the theme for your project.
-->
<html lang="en">
<!--begin::Head-->

<head>
    <base href="" />
    <title>Metronic - The World's #1 Selling Bootstrap Admin Template by Keenthemes</title>
    <meta charset="utf-8" />
    <meta name="description"
        content="
            The most advanced Bootstrap 5 Admin Theme with 40 unique prebuilt layouts on Themeforest trusted by 100,000 beginners and professionals. Multi-demo,
            Dark Mode, RTL support and complete React, Angular, Vue, Asp.Net Core, Rails, Spring, Blazor, Django, Express.js, Node.js, Flask, Symfony & Laravel versions.
            Grab your copy now and get life-time updates for free.
        " />
    <meta name="keywords"
        content="
            metronic, bootstrap, bootstrap 5, angular, VueJs, React, Asp.Net Core, Rails, Spring, Blazor, Django, Express.js,
            Node.js, Flask, Symfony & Laravel starter kits, admin themes, web design, figma, web development, free templates,
            free admin themes, bootstrap theme, bootstrap template, bootstrap dashboard, bootstrap dak mode, bootstrap button,
            bootstrap datepicker, bootstrap timepicker, fullcalendar, datatables, flaticon
        " />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta property="og:locale" content="en_US" />
    <meta property="og:type" content="article" />
    <meta property="og:title"
        content="
            Metronic - Bootstrap Admin Template, HTML, VueJS, React, Angular. Laravel, Asp.Net Core, Ruby on Rails,
            Spring Boot, Blazor, Django, Express.js, Node.js, Flask Admin Dashboard Theme & Template
        " />
    <meta property="og:url" content="https://keenthemes.com/metronic" />
    <meta property="og:site_name" content="Keenthemes | Metronic" />
    <link rel="canonical" href="https://preview.keenthemes.com/metronic8" />
    <link rel="shortcut icon" href="{{ url('admin/assets/media/logos/favicon.ico') }}" />
    <!--begin::Fonts(mandatory for all pages)-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inter:300,400,500,600,700" />
    <!--end::Fonts-->
    <!--begin::Vendor Stylesheets(used for this page only)-->
    <link href="{{ url('admin/assets/plugins/custom/fullcalendar/fullcalendar.bundle.css') }}" rel="stylesheet"
        type="text/css" />
    <link href="{{ url('admin/assets/plugins/custom/datatables/datatables.bundle.css') }}" rel="stylesheet"
        type="text/css" />
    <!--end::Vendor Stylesheets-->
    <!--begin::Global Stylesheets Bundle(mandatory for all pages)-->
    <link href="{{ url('admin/assets/plugins/global/plugins.bundle.css') }}" rel="stylesheet" type="text/css" />
    <link href="{{ url('admin/assets/css/style.bundle.css') }}" rel="stylesheet" type="text/css" />
    <!--end::Global Stylesheets Bundle-->
    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
<!--end::Head-->
<!--begin::Body-->

<body id="kt_app_body" data-kt-app-layout="dark-sidebar" data-kt-app-header-fixed="true"
    data-kt-app-sidebar-enabled="true" data-kt-app-sidebar-fixed="true" data-kt-app-sidebar-hoverable="true"
    data-kt-app-sidebar-push-header="true" data-kt-app-sidebar-push-toolbar="true"
    data-kt-app-sidebar-push-footer="true" data-kt-app-toolbar-enabled="true" class="app-default">

    <script src="{{ url('admin/assets/plugins/global/plugins.bundle.js') }}"></script>
    <script src="{{ url('admin/assets/js/scripts.bundle.js') }}"></script>

    {{-- /Users/dhananghadiyanto/Documents/www/laravel/theme/public/admin/assets/plugins/custom/virtualselect --}}
    <link rel="stylesheet" href="{{ url('admin/assets/plugins/custom/virtualselect/virtual-select.min.css') }}">
    <script type="text/javascript" src="{{ url('admin/assets/plugins/custom/virtualselect/virtual-select.min.js') }}">
    </script>


    <script type="text/javascript">
        $(document).ready(function() {

            $(".date").daterangepicker({
                singleDatePicker: true,
                showDropdowns: true,
                minYear: 1960,
                maxYear: parseInt(moment().format("YYYY"), 10),
                locale: {
                    format: 'DD-MM-YYYY'
                },
                timePicker: false,
            });

            $(".datetime").daterangepicker({
                singleDatePicker: true,
                showDropdowns: true,
                minYear: 1960,
                maxYear: parseInt(moment().format("YYYY"), 10),
                locale: {
                    format: 'DD-MM-YYYY hh:mm A'
                },
                timePicker: true,
            });

            VirtualSelect.init({
                ele: '.virtual',
                maxWidth: '850px',
            });

            $('.numberonly').keypress(function(e) {

                var charCode = (e.which) ? e.which : event.keyCode
                if (String.fromCharCode(charCode).match(/[^0-9]/g))

                    return false;

            });

            $('.currency').keyup(function(e) {
                $(this).val(format($(this).val()));
            });

        });


        var format = function(num) {
            var str = num.toString().replace("", ""),
                parts = false,
                output = [],
                i = 1,
                formatted = null;
            if (str.indexOf(".") > 0) {
                parts = str.split(".");
                str = parts[0];
            }
            str = str.split("").reverse();
            for (var j = 0, len = str.length; j < len; j++) {
                if (str[j] != ",") {
                    output.push(str[j]);
                    if (i % 3 == 0 && j < (len - 1)) {
                        output.push(",");
                    }
                    i++;
                }
            }
            formatted = output.reverse().join("");
            return ("" + formatted + ((parts) ? "." + parts[1].substr(0, 2) : ""));
        };

        function loading() {
            $(".btn").attr("disabled", true);
            Swal.fire({
                title: 'Mohon Tunggu !',
                html: 'Data Sedang Diproses',
                icon: 'info',
                timerProgressBar: true,
                allowOutsideClick: false,
                didOpen: () => {
                    Swal.showLoading()

                }
            })
        }

        function finish() {
            $(".btn").attr("disabled", false);
            swal.close();
        }
    </script>


    @include('main.flash-message')
    @include('main.partials.theme-mode._init')
    @include('main.layout._default')
    @include('main.partials._scrolltop')

    <!--begin::Javascript-->
    <script>
        var hostUrl = "assets/";
    </script>
    <!--begin::Global Javascript Bundle(mandatory for all pages)-->
    <!--end::Global Javascript Bundle-->
    <!--begin::Vendors Javascript(used for this page only)-->
    <script src="{{ url('admin/assets/plugins/custom/fullcalendar/fullcalendar.bundle.js') }}"></script>
    <script src="https://cdn.amcharts.com/lib/5/index.js"></script>
    <script src="https://cdn.amcharts.com/lib/5/xy.js"></script>
    <script src="https://cdn.amcharts.com/lib/5/percent.js"></script>
    <script src="https://cdn.amcharts.com/lib/5/radar.js"></script>
    <script src="https://cdn.amcharts.com/lib/5/themes/Animated.js"></script>
    <script src="https://cdn.amcharts.com/lib/5/map.js"></script>
    <script src="https://cdn.amcharts.com/lib/5/geodata/worldLow.js"></script>
    <script src="https://cdn.amcharts.com/lib/5/geodata/continentsLow.js"></script>
    <script src="https://cdn.amcharts.com/lib/5/geodata/usaLow.js"></script>
    <script src="https://cdn.amcharts.com/lib/5/geodata/worldTimeZonesLow.js"></script>
    <script src="https://cdn.amcharts.com/lib/5/geodata/worldTimeZoneAreasLow.js"></script>
    <script src="{{ url('admin/assets/plugins/custom/datatables/datatables.bundle.js') }}"></script>
    <!--end::Vendors Javascript-->
    <!--begin::Custom Javascript(used for this page only)-->
    <script src="{{ url('admin/assets/js/widgets.bundle.js') }}"></script>
    <script src="{{ url('admin/assets/js/custom/widgets.js') }}"></script>
    <script src="{{ url('admin/assets/js/custom/apps/chat/chat.js') }}"></script>
    <script src="{{ url('admin/assets/js/custom/utilities/modals/upgrade-plan.js') }}"></script>
    <script src="{{ url('admin/assets/js/custom/utilities/modals/create-app.js') }}"></script>
    <script src="{{ url('admin/assets/js/custom/utilities/modals/new-target.js') }}"></script>
    <script src="{{ url('admin/assets/js/custom/utilities/modals/users-search.js') }}"></script>
    <!--end::Custom Javascript-->
    <!--end::Javascript-->

    {{-- livewire --}}
    @stack('scripts')
</body>
<!--end::Body-->

</html>
@include('main.modal')
