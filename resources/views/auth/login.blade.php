<!DOCTYPE html>
<html lang="en">
<head>
    <script>
        (function(w, d, s, l, i) {
            w[l] = w[l] || [];
            w[l].push({
                'gtm.start': new Date().getTime(),
                event: 'gtm.js'
            });
            var f = d.getElementsByTagName(s)[0],
                j = d.createElement(s),
                dl = l != 'dataLayer' ? '&l=' + l : '';
            j.async = true;
            j.src =
                'https://www.googletagmanager.com/gtm.js?id=' + i + dl;
            f.parentNode.insertBefore(j, f);
        })(window, document, 'script', 'dataLayer', 'GTM-5FS8GGP');
    </script>
    <meta charset="utf-8" />
    <title>Sign In | Keenthemes</title>
    <meta name="description" content="Singin page example" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link rel="canonical" href="https://keenthemes.com/metronic" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" />
    <link href="{{ url('admin/assets/css/pages/login/login-3.css?v=7.2.9') }}" rel="stylesheet" type="text/css" />
    <link href="{{ url('admin/assets/plugins/global/plugins.bundle.css?v=7.2.9') }}" rel="stylesheet" type="text/css" />
    <link href="{{ url('admin/assets/plugins/custom/prismjs/prismjs.bundle.css?v=7.2.9') }}" rel="stylesheet"
        type="text/css" />
    <link href="{{ url('admin/assets/css/style.bundle.css?v=7.2.9') }}" rel="stylesheet" type="text/css" />
    
    <link href="{{ url('admin/assets/css/pages/login/light.css?v=7.2.9') }}" rel="stylesheet" type="text/css" />
    <link href="{{ url('admin/assets/css/pages/header/light.css?v=7.2.9') }}" rel="stylesheet" type="text/css" />
    <link href="{{ url('admin/assets/css/pages/layout/brand/dark.css?v=7.2.9') }}" rel="stylesheet" type="text/css" />
    <link href="{{ url('admin/assets/css/pages/layout/aside/dark.css?v=7.2.9') }}" rel="stylesheet" type="text/css" />
    
    <link rel="shortcut icon" href="{{ url('admin/assets/media/logos/favicon.ico') }}" />

    <script>
        (function(h, o, t, j, a, r) {
            h.hj = h.hj || function() {
                (h.hj.q = h.hj.q || []).push(arguments)
            };
            h._hjSettings = {
                hjid: 1070954,
                hjsv: 6
            };
            a = o.getElementsByTagName('head')[0];
            r = o.createElement('script');
            r.async = 1;
            r.src = t + h._hjSettings.hjid + j + h._hjSettings.hjsv;
            a.appendChild(r);
        })(window, document, 'https://static.hotjar.com/c/hotjar-', '.js?sv=');
    </script>
</head>

<body id="kt_body"
    class="header-fixed header-mobile-fixed subheader-enabled subheader-fixed aside-enabled aside-fixed aside-minimize-hoverable page-loading">
    <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-5FS8GGP" height="0" width="0"
            style="display:none;visibility:hidden"></iframe></noscript>
    <div class="d-flex flex-column flex-root">
        <div class="login login-3 wizard d-flex flex-column flex-lg-row flex-column-fluid">
            <div class="login-aside d-flex flex-column flex-row-auto">
                <div class="d-flex flex-column-auto flex-column pt-lg-40 pt-15">
                    <a href="#" class="login-logo text-center pt-lg-25 pb-10">
                        <img src="{{ url('admin/assets/media/logos/logo-1.png') }}" class="max-h-70px" alt="" />
                    </a>
                    <h3 class="font-weight-bolder text-center font-size-h4 text-dark-50 line-height-xl">
                        User Experience & Interface Design<br />
                        Strategy SaaS Solutions
                    </h3>
                </div>
                <div class="aside-img d-flex flex-row-fluid bgi-no-repeat bgi-position-x-center"
                    style="background-position-y: calc(100% + 5rem); background-image: url({{ url('admin/assets/media/svg/illustrations/login-visual-5.svg') }})">
                </div>
            </div>
            <div class="login-content flex-row-fluid d-flex flex-column p-10">
                <div class="text-right d-flex justify-content-center">
                    <div class="top-signin text-right d-flex justify-content-end pt-5 pb-lg-0 pb-10">
                        <span class="font-weight-bold text-muted font-size-h4">Having issues?</span>
                        <a href="javascript:;" class="font-weight-bold text-primary font-size-h4 ml-2"
                            id="kt_login_signup">Get Help</a>
                    </div>
                </div>
                <div class="d-flex flex-row-fluid flex-center">
                    <div class="login-form">
                        <form method="POST" action="{{ route('login') }}">
                            @csrf
                            <div class="pb-5 pb-lg-15">
                                <h3 class="font-weight-bolder text-dark font-size-h1 font-size-h1-lg">Sign In</h3>
                            </div>
                            <div class="form-group">
                                <label class="font-size-h1 font-weight-bolder text-dark">User</label>
                                <input
                                    class="form-control h-auto py-7 px-6 rounded-lg border-0  @error('username') is-invalid @enderror"
                                    type="text" name="username" id="username" value="{{ old('username') }}" required
                                    autocomplete="username" autofocus />
                                @error('username')
                                    <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                            </div>
                            <div class="form-group">
                                <div class="d-flex justify-content-between mt-n5">
                                    <label class="font-size-h6 font-weight-bolder text-dark pt-5">Password</label>

                                    <a href="/metronic/demo1/custom/pages/login/login-3/forgot.html"
                                        class="text-primary font-size-h6 font-weight-bolder text-hover-primary pt-5">
                                        Forgot Password ?
                                    </a>
                                </div>
                                <input
                                    class="form-control h-auto py-7 px-6 rounded-lg border-0  @error('password') is-invalid @enderror"
                                    type="password" name="password" id="password" required
                                    autocomplete="current-password" />
                                @error('password')
                                    <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                            </div>

                            <div class="pb-lg-0 pb-5">
                                <button type="submit"
                                    class="btn btn-primary font-weight-bolder font-size-h6 px-8 py-4 my-3 mr-3">Sign
                                    In</button>
                                <button type="button"
                                    class="btn btn-light-primary font-weight-bolder px-8 py-4 my-3 font-size-lg">
                                    <span class="svg-icon svg-icon-md">
                                       <svg
                                            xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                                            viewBox="0 0 20 20" fill="none">
                                            <path
                                                d="M19.9895 10.1871C19.9895 9.36767 19.9214 8.76973 19.7742 8.14966H10.1992V11.848H15.8195C15.7062 12.7671 15.0943 14.1512 13.7346 15.0813L13.7155 15.2051L16.7429 17.4969L16.9527 17.5174C18.879 15.7789 19.9895 13.221 19.9895 10.1871Z"
                                                fill="#4285F4" />
                                            <path
                                                d="M10.1993 19.9313C12.9527 19.9313 15.2643 19.0454 16.9527 17.5174L13.7346 15.0813C12.8734 15.6682 11.7176 16.0779 10.1993 16.0779C7.50243 16.0779 5.21352 14.3395 4.39759 11.9366L4.27799 11.9466L1.13003 14.3273L1.08887 14.4391C2.76588 17.6945 6.21061 19.9313 10.1993 19.9313Z"
                                                fill="#34A853" />
                                            <path
                                                d="M4.39748 11.9366C4.18219 11.3166 4.05759 10.6521 4.05759 9.96565C4.05759 9.27909 4.18219 8.61473 4.38615 7.99466L4.38045 7.8626L1.19304 5.44366L1.08875 5.49214C0.397576 6.84305 0.000976562 8.36008 0.000976562 9.96565C0.000976562 11.5712 0.397576 13.0882 1.08875 14.4391L4.39748 11.9366Z"
                                                fill="#FBBC05" />
                                            <path
                                                d="M10.1993 3.85336C12.1142 3.85336 13.406 4.66168 14.1425 5.33717L17.0207 2.59107C15.253 0.985496 12.9527 0 10.1993 0C6.2106 0 2.76588 2.23672 1.08887 5.49214L4.38626 7.99466C5.21352 5.59183 7.50242 3.85336 10.1993 3.85336Z"
                                                fill="#EB4335" />
                                        </svg>
                                    </span> Sign in with Google
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        var HOST_URL = "/metronic/theme/html/tools/preview";
    </script>
    <script>
        var KTAppSettings = {
            "breakpoints": {
                "sm": 576,
                "md": 768,
                "lg": 992,
                "xl": 1200,
                "xxl": 1400
            },
            "colors": {
                "theme": {
                    "base": {
                        "white": "#ffffff",
                        "primary": "#3699FF",
                        "secondary": "#E5EAEE",
                        "success": "#1BC5BD",
                        "info": "#8950FC",
                        "warning": "#FFA800",
                        "danger": "#F64E60",
                        "light": "#E4E6EF",
                        "dark": "#181C32"
                    },
                    "light": {
                        "white": "#ffffff",
                        "primary": "#E1F0FF",
                        "secondary": "#EBEDF3",
                        "success": "#C9F7F5",
                        "info": "#EEE5FF",
                        "warning": "#FFF4DE",
                        "danger": "#FFE2E5",
                        "light": "#F3F6F9",
                        "dark": "#D6D6E0"
                    },
                    "inverse": {
                        "white": "#ffffff",
                        "primary": "#ffffff",
                        "secondary": "#3F4254",
                        "success": "#ffffff",
                        "info": "#ffffff",
                        "warning": "#ffffff",
                        "danger": "#ffffff",
                        "light": "#464E5F",
                        "dark": "#ffffff"
                    }
                },
                "gray": {
                    "gray-100": "#F3F6F9",
                    "gray-200": "#EBEDF3",
                    "gray-300": "#E4E6EF",
                    "gray-400": "#D1D3E0",
                    "gray-500": "#B5B5C3",
                    "gray-600": "#7E8299",
                    "gray-700": "#5E6278",
                    "gray-800": "#3F4254",
                    "gray-900": "#181C32"
                }
            },
            "font-family": "Poppins"
        };
    </script>

    <script src="{{ url('admin/assets/plugins/global/plugins.bundle.js?v=7.2.9') }}"></script>
    <script src="{{ url('admin/assets/plugins/custom/prismjs/prismjs.bundle.js?v=7.2.9') }}"></script>
    <script src="{{ url('admin/assets/js/scripts.bundle.js?v=7.2.9') }}"></script>
</body>

</html>
