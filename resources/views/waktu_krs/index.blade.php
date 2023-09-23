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

            // document.getElementById("search").addEventListener("keyup",setTimeout(fetch_user_data(),1000));

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
                url: "waktu_krs/get_waktu_krs?page=" + page + "&search=" + search,
                success: function(data) {
                    $('#data_table').html(data);
                }
            });
        }

        function delete_data(id_angkatan_mahasiswa) {
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
                        url: "/waktu_krs/delete_waktu_krs/" + id_angkatan_mahasiswa,
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
            <h3 class="card-title"></h3>
            <div class="card-toolbar">
                <a href="{{ URL::to('/waktu_krs/add_waktu_krs') }}" type="button" class="btn btn-primary" data-bs-toggle="tooltip"
                    data-bs-original-title="Coming Soon" data-kt-initialized="1">
                    <!--begin::Svg Icon | path: icons/duotune/arrows/arr075.svg-->
                    <span class="svg-icon svg-icon-2"><svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                            xmlns="http://www.w3.org/2000/svg">
                            <rect opacity="0.5" x="11.364" y="20.364" width="16" height="2" rx="1"
                                transform="rotate(-90 11.364 20.364)" fill="currentColor"></rect>
                            <rect x="4.36396" y="11.364" width="16" height="2" rx="1"
                                fill="currentColor"></rect>
                        </svg></span>
                    Tambah Master Waktu KRS
                </a>
            </div>
        </div>
        <div class="card-body card-scroll">
            <form method="get" action="/waktu_krs">
                <div class="d-flex align-items-center position-relative my-1">
                    <input type="text" data-kt-docs-table-filter="search" name="search" id="search"
                        class="form-control form-control-solid w-250px ps-15" placeholder="Cari Nama Waktu KRS" />
                </div>
            </form>
            <input readonly type="hidden" name="page" id="page" class="form-control form-control-solid w-250px ps-15" />
            <div id="data_table">
            </div>

        </div>
        <div class="card-footer">
        </div>
    </div>
@endsection
