@extends('main.layout')
@section('content')
    <script>
        $(document).ready(function() {

            $(document).on('click', '.pagination a', function(event) {
                event.preventDefault();
                var page = $(this).attr('href').split('page=')[1];
                document.getElementById("page").value = page;
                fetch_user_data();
            });

            const filterSearch = document.querySelector('[data-kt-docs-table-filter="search"]');

            filterSearch.addEventListener('keyup', delay(function(e) {
                fetch_user_data();
            }, 1000));

            fetch_user_data();

        });

        function delay(callback, ms) {
            var timer = 0;
            return function() {
                var context = this,
                    args = arguments;
                clearTimeout(timer);
                timer = setTimeout(function() {
                    callback.apply(context, args);
                }, ms || 0);
            };
        }

        function fetch_user_data() {
            var page = document.getElementById("page").value;
            var search = document.getElementById("search").value;
            $.ajax({
                type: "get",
                url: "/master_menu/get_master_aplikasi?page=" + page + "&search=" + search,
                success: function(data) {
                    $('#data_table').html(data);
                }
            });
        }
    </script>

    <div class="card bg-light shadow-sm">
        <div class="card-header">
            <h3 class="card-title"></h3>
        </div>
        <div class="card-body card-scroll">
            <div class="d-flex align-items-center position-relative my-1">
                <input type="text" data-kt-docs-table-filter="search" name="search" id="search"
                    class="form-control form-control-solid w-250px ps-15" placeholder="Cari Nama Aplikasi" />
            </div>
            <input readonly type="hidden" name="page" id="page"
                class="form-control form-control-solid w-250px ps-15" />
            <div id="data_table">
            </div>
        </div>
        <div class="card-footer">
        </div>
    </div>
@endsection
