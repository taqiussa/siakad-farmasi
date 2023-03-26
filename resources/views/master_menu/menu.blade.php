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
            var id_master_aplikasi = document.getElementById("id_master_aplikasi").value;
            // alert(id_master_menu);
            // return false();
            // loading();
            $.ajax({
                type: "get",
                url: "/master_menu/get_master_menu_pagination/?id_master_aplikasi=" + id_master_aplikasi + "&page=" + page +
                    "&search=" + search,
                success: function(data) {
                    // finish();
                    $('#data_table').html(data);
                }
            });
        }

        function delete_data(id_master_menu) {
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
                        url: "/master_menu/delete_master_menu/" + id_master_menu,
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
    <div class="card">
        <div class="card-body pt-9 pb-0">
            <div class="d-flex flex-wrap flex-sm-nowrap mb-6">
                <div class="d-flex flex-center flex-shrink-0 bg-light rounded w-100px h-100px w-lg-150px h-lg-150px me-7 mb-4">
                    <img class="mw-100px mw-lg-100px" src="{{URL::to('/images/' . $master_aplikasi->image)}}" alt="image">
                </div>
                <div class="flex-grow-1">
                    <div class="d-flex justify-content-between align-items-start flex-wrap mb-2">
                        <div class="d-flex flex-column">
                            <div class="d-flex align-items-center mb-1">
                                <a href="#"
                                    class="text-gray-800 text-hover-primary fs-2 fw-bolder me-3">{{ $master_aplikasi->nama_aplikasi }}</a>
                            </div>
                            <div class="d-flex flex-wrap fw-bold mb-4 fs-5 text-gray-400">{{ $master_aplikasi->deskripsi }}
                            </div>
                        </div>
                        <div class="d-flex mb-4">
                            <a href="{{ URL::to('/' . $reload) }}"
                                class="btn btn-sm btn-warning btn-active-color-primary me-3">
                                <i class="bi bi-box-arrow-in-left"></i>
                                Kembali
                            </a>
                            <a href="{{ URL::to('/' . $add  ) }}"
                                class="btn btn-sm btn-primary me-3"> <i class="bi bi-database-add"></i> Tambah Menu</a>
                        </div>
                    </div>
                    <div class="d-flex flex-wrap justify-content-start">
                        <div class="d-flex flex-wrap">
                            <div class="border border-gray-300 border-dashed rounded min-w-125px py-3 px-4 me-6 mb-3">
                                <div class="d-flex align-items-center">
                                    <div class="fs-4 fw-bolder">
                                        {{ date('j \\ F Y', strtotime($master_aplikasi->tgl_version)) }}</div>
                                </div>
                                <div class="fw-bold fs-6 text-gray-400">Tanggal Versi</div>
                            </div>
                            <div class="border border-gray-300 border-dashed rounded min-w-125px py-3 px-4 me-6 mb-3">
                                <div class="d-flex align-items-center">
                                    <span class="svg-icon svg-icon-3 svg-icon-danger me-2">
                                        <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                                            width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                            <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                                <polygon points="0 0 24 0 24 24 0 24"></polygon>
                                                <rect fill="#000000" opacity="0.5" x="11" y="5"
                                                    width="2" height="14" rx="1"></rect>
                                                <path
                                                    d="M6.70710678,12.7071068 C6.31658249,13.0976311 5.68341751,13.0976311 5.29289322,12.7071068 C4.90236893,12.3165825 4.90236893,11.6834175 5.29289322,11.2928932 L11.2928932,5.29289322 C11.6714722,4.91431428 12.2810586,4.90106866 12.6757246,5.26284586 L18.6757246,10.7628459 C19.0828436,11.1360383 19.1103465,11.7686056 18.7371541,12.1757246 C18.3639617,12.5828436 17.7313944,12.6103465 17.3242754,12.2371541 L12.0300757,7.38413782 L6.70710678,12.7071068 Z"
                                                    fill="#000000" fill-rule="nonzero"></path>
                                            </g>
                                        </svg>
                                    </span>
                                    <div class="fs-4 fw-bolder counted" data-kt-countup="true" data-kt-countup-value="75">
                                        {{ $master_aplikasi->versi_aplikasi }}</div>
                                </div>
                                <div class="fw-bold fs-6 text-gray-400">Versi Aplikasi</div>
                            </div>
                            <div class="border border-gray-300 border-dashed rounded min-w-125px py-3 px-4 me-6 mb-3">
                                <div class="d-flex align-items-center">
                                    <span class="svg-icon svg-icon-3 svg-icon-success me-2">
                                        <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                                            width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                            <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                                <polygon points="0 0 24 0 24 24 0 24"></polygon>
                                                <rect fill="#000000" opacity="0.5" x="11" y="5"
                                                    width="2" height="14" rx="1"></rect>
                                                <path
                                                    d="M6.70710678,18.7071068 C6.31658249,19.0976311 5.68341751,19.0976311 5.29289322,18.7071068 C4.90236893,18.3165825 4.90236893,17.6834175 5.29289322,17.2928932 L11.2928932,11.2928932 C11.6714722,10.9143143 12.2810586,10.9010687 12.6757246,11.2628459 L18.6757246,16.7628459 C19.0828436,17.1360383 19.1103465,17.7686056 18.7371541,18.1757246 C18.3639617,18.5828436 17.7313944,18.6103465 17.3242754,18.2371541 L12.0300757,13.3841378 L6.70710678,18.7071068 Z"
                                                    fill="#000000" fill-rule="nonzero"
                                                    transform="translate(12.000003, 14.999999) scale(1, -1) translate(-12.000003, -14.999999)">
                                                </path>
                                            </g>
                                        </svg>
                                    </span>
                                    <div class="fs-4 fw-bolder counted" data-kt-countup="true" data-kt-countup-value="15000"
                                        data-kt-countup-prefix="$">{{ $master_aplikasi->status_data }}</div>
                                </div>
                                <div class="fw-bold fs-6 text-gray-400">Status Aplikasi</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="card bg-light shadow-sm">
        <div class="card-header">
            <h3 class="card-title"></h3>
        </div>
        <div class="card-body card-scroll">

            <div class="d-flex align-items-center position-relative my-1">
                <input type="text" data-kt-docs-table-filter="search" name="search" id="search"
                    class="form-control form-control-solid w-250px ps-15" placeholder="Cari Nama Menu" />
            </div>
            <input readonly type="hidden" name="page" id="page"
                class="form-control form-control-solid w-250px ps-15" />
            <input readonly type="hidden" name="id_master_aplikasi" id="id_master_aplikasi"
                value="{{ $master_aplikasi->id_master_aplikasi }}"
                class="form-control form-control-solid w-250px ps-15" />
            <div id="data_table">
            </div>

        </div>
        <div class="card-footer">
        </div>
    </div>
@endsection
