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
            var id_master_menu = document.getElementById("id_master_menu").value;
            // alert(id_master_menu);
            // return false();
            // loading();
            $.ajax({
                type: "get",
                url: "/master_menu/get_sub_menu_pagination/?id_master_menu=" + id_master_menu + "&page=" + page +
                    "&search=" + search,
                success: function(data) {
                    // finish();
                    $('#data_table').html(data);
                }
            });
        }

        function delete_data(id_master_modul) {
            Swal.fire({
                title: "Konfirmasi Delete",
                text: "Lanjutkan Menghapus data ?",
                icon: "error",
                showCancelButton: true,
                confirmButtonColor: "#c9302c",
                confirmButtonText: "Ya, Lanjutkan",
                cancelButtonText: "Tidak, Batalkan"
            }).then((result) => {
                if (result.value) {
                    $.ajax({
                        type: "get",
                        url: "/master_menu/delete_sub_menu/" + id_master_modul,
                        beforeSend: function() {
                            loading();
                        },
                        success: function(resp) {
                            finish();
                            var obj = jQuery.parseJSON(resp);
                            if (obj.state === "1") {
                                toastr.success(obj.msg, obj.title);
                                fetch_user_data();
                            } else {
                                toastr.error(obj.msg, obj.title);
                            }
                        },
                        error: function(event, textStatus, errorThrown) {
                            console.log('Pesan: ' + textStatus + ' , HTTP: ' + errorThrown);
                        }
                    });
                }
            });
        }
    </script>
    <div class="card bg-light shadow-sm">
        <div class="card-header">
            <div class="card-title m-0">
                <div class="symbol symbol-45px w-45px bg-light me-5">
                    <i class='fa {{ $master_menu->icon }} '></i>
                </div>
                <a href="#" class="fs-4 fw-bold text-hover-primary text-gray-600 m-0">{{ $master_menu->nama_menu }}</a>
            </div>
            <div class="card-toolbar">
                <div class="d-flex mb-4">
                    <a href="{{ URL::to('/get_master_menu/' . $master_menu->id_master_aplikasi) }}"
                        class="btn btn-sm btn-warning btn-active-color-primary me-3">
                        <i class="bi bi-box-arrow-in-left"></i>
                        Kembali
                    </a>
                    <a href="{{ URL::to('/' . $add_submenu . '/' . $master_menu->id_master_menu) }}"
                        class="btn btn-sm btn-primary me-3"> <i class="bi bi-database-add"></i> Tambah Menu Modul</a>
                </div>
            </div>

        </div>
        <div class="card-body card-scroll">

            <div class="d-flex align-items-center position-relative my-1">
                <input type="text" data-kt-docs-table-filter="search" name="search" id="search"
                    class="form-control form-control-solid w-250px ps-15" placeholder="Cari Nama Sub Menu" />
            </div>
            <input readonly type="hidden" name="page" id="page"
                class="form-control form-control-solid w-250px ps-15" />
            <input readonly type="hidden" name="id_master_menu" id="id_master_menu"
                value="{{ $master_menu->id_master_menu }}" class="form-control form-control-solid w-250px ps-15" />
            <div id="data_table">
            </div>

        </div>
        <div class="card-footer">
        </div>
    </div>
@endsection
