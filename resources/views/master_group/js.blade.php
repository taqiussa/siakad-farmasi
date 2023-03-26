<script type="text/javascript">
    $(document).ready(function() {
        $(document).on('click', '.fa-item', function() {
            var attr = $(this).html();
            var start = attr.indexOf('"');
            var res = attr.substring(start, attr.length);
            var end = res.indexOf('">');
            var fa = res.substring(1, end);
            $("#icon").val(fa);
            $("#modal_1").modal('hide');
            //   console.log("An element was clicked.")
        });
    });

    function modal_icon() {
        $("#modal_1_body").html("@include('master_menu.fa_icons')");
        $("#modal_1_title").html("Icon Menu");
        $('#modal_1').modal({
            backdrop: 'static'
        });
        $("#modal_1").modal('show');
    }
    
</script>
