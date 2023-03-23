<script>
    toastr.options = {
        "closeButton": false,
        "debug": false,
        "newestOnTop": false,
        "progressBar": true,
        "positionClass": "toast-bottom-full-width",
        "preventDuplicates": false,
        "onclick": null,
        "showDuration": "300",
        "hideDuration": "1000",
        "timeOut": "5000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    };
</script>

@if ($message = Session::get('success'))
    <script>
        toastr.success('{{ $message }}', "Success");
    </script>
@endif


@if ($message = Session::get('error'))
    <script>
        toastr.success('{{ $message }}', "Error");
    </script>
@endif

@if ($message = Session::get('warning'))
    <script>
        toastr.success('{{ $message }}', "Warning");
    </script>
@endif


@if ($message = Session::get('info'))
    <script>
        toastr.info('{{ $message }}', "Warning");
    </script>
@endif

@if ($errors->any())
    <script>
        toastr.error('{{ $errors }}', "Error");
    </script>
@endif
