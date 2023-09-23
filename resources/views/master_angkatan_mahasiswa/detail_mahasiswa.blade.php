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
            var id_angkatan_mahasiswa = document.getElementById("id_angkatan_mahasiswa").value;
            $.ajax({
                type: "get",
                url: "/master_angkatan_mahasiswa/get_mahasiswa_angkatan_pagination?id_angkatan_mahasiswa=" +
                    id_angkatan_mahasiswa +
                    "&page=" + page +
                    "&search=" + search,
                success: function(data) {
                    $('#data_table').html(data);
                }
            });
        }

        function add_mahasiswa(id_angkatan_mahasiswa) {
            $.ajax({
                type: "post",
                url: "{{ URL::to('/master_angkatan_mahasiswa/add_mahasiswa/') }} ",
                data: {
                    "id_angkatan_mahasiswa": id_angkatan_mahasiswa,
                    '_token': "{{ csrf_token() }}"
                },
                beforeSend: function() {
                    loading()
                },
                success: function(resp) {
                    finish()
                    $("#modal_1_body").html(resp);
                    $("#modal_1_title").html("Tambah Matakuliah Kurikulum");
                    $('#modal_1').modal({
                        backdrop: 'static'
                    });
                    $("#modal_1").modal('show');
                },
                error: function(event, textStatus, errorThrown) {
                    console.log('Pesan: ' + textStatus + ' , HTTP: ' + errorThrown);
                }
            });
        }

        function simpan_mahasiswa() {
            var id_angkatan_mahasiswa = document.getElementById('id_angkatan_mahasiswa').value;
            var id_kode_pembayaran    = document.getElementById('id_kode_pembayaran').value;
            var biaya                 = document.getElementById('biaya').value;

            $.ajax({
                type: "post",
                url: "{{ URL::to('/' . $submit_tagihan) }}",
                data: {
                    "id_angkatan_mahasiswa": id_angkatan_mahasiswa,
                    "id_kode_pembayaran": id_kode_pembayaran,
                    "biaya":biaya,
                    '_token': "{{ csrf_token() }}"
                },
                beforeSend: function() {
                    loading();
                },
                success: function(resp) {
                    finish();
                    var obj = jQuery.parseJSON(resp);
                    fetch_user_data();
                    if (obj.state === "1") {
                        $('#modal_1').modal('hide');
                        toastr.success(obj.msg, obj.title);
                    } else {
                        toastr.error(obj.msg, obj.title);
                    }
                },
                error: function(event, textStatus, errorThrown) {
                    console.log('Pesan: ' + textStatus + ' , HTTP: ' + errorThrown);
                }
            });

        }

        function delete_data(id_mahasiswa_angkatan) {
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
                        url: "{{ URL::to('/master_angkatan_mahasiswa/delete_mahasiswa') }}/" + id_mahasiswa_angkatan,
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

    <div id="kt_content_container" class="container">
        <div class="card mb-6">
            <div class="card-header">
                <h3 class="card-title">
                    Kurikulum Kuliah
                </h3>
                <div class="card-toolbar">
                    <div class="example-tools justify-content-center">
                        <span class="example-toggle" data-toggle="tooltip" title=""
                            data-original-title="View code"></span>
                        <span class="example-copy" data-toggle="tooltip" title=""
                            data-original-title="Copy code"></span>
                    </div>
                </div>
            </div>
            <div class="card-body row">
                <div class="col-lg-6">
                    <div class="row mb-8 d-none" id="div_id_angkatan_mahasiswa">
                        <div class="col-xl-4">
                            <div class=" required fs-6 fw-bold mt-2 mb-3 ">ID Angkatan</div>
                        </div>
                        <div class="col-lg-8">
                            <input type="text" class="form-control "
                                placeholder="Masukan Nama Kurikulum. Contoh : Kurikulum 2021" id="id_angkatan_mahasiswa"
                                name="id_angkatan_mahasiswa" readonly value="{{ $data->id_angkatan_mahasiswa }}">
                        </div>
                    </div>

                    <div class="row mb-8 " id="div_nama_kurikulum">
                        <div class="col-xl-4">
                            <div class=" required fs-6 fw-bold mt-2 mb-3 ">Nama Angkatan</div>
                        </div>
                        <div class="col-lg-8">
                            <input type="text" class="form-control "
                                placeholder="Masukan Nama Kurikulum. Contoh : Kurikulum 2021" id="nama_kurikulum"
                                name="nama_kurikulum" readonly value="{{ $data->nama_angkatan_mahasiswa }}">
                        </div>
                    </div>
                    <div class="row mb-8 " id="div_jumlah_sks_wajib">
                        <div class="col-xl-4">
                            <div class=" required fs-6 fw-bold mt-2 mb-3 ">Program Studi</div>
                        </div>
                        <div class="col-lg-8">
                            <input type="text" class="form-control numberonly skstotal"
                                placeholder="Masukan SKS Mata Kuliah Wajib. Contoh: 2" id="jumlah_sks_wajib"
                                name="jumlah_sks_wajib" readonly required="" value="{{ $data->nama_program_studi }}">
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="row mb-8 " id="div_jumlah_sks_wajib">
                        <div class="col-xl-6">
                            <div class=" required fs-6 fw-bold mt-2 mb-3 ">Mulai Berlaku</div>
                        </div>
                        <div class="col-lg-6">
                            <input type="text" class="form-control numberonly skstotal"
                                placeholder="Masukan SKS Mata Kuliah Wajib. Contoh: 2" id="jumlah_sks_wajib"
                                name="jumlah_sks_wajib" readonly required="" value="{{ $data->nama_semester }}">
                        </div>
                    </div>
                    <div class="row mb-8 " id="div_jumlah_sks_pilihan">
                        <div class="col-xl-6">
                            <div class=" required fs-6 fw-bold mt-2 mb-3 ">Kurikulum Matakuliah</div>
                        </div>
                        <div class="col-lg-6">
                            <input type="text" class="form-control numberonly skstotal"
                                placeholder="Masukan SKS Mata Kuliah Pilihan. Contoh: 2" id="jumlah_sks_pilihan"
                                name="jumlah_sks_pilihan" readonly required="" value="{{ $data->nama_kurikulum }}">
                        </div>
                    </div>
                </div>
                <div class="row mb-8 " id="div_button">
                    <div class="col-xl-3">
                        <div class=" fs-6 fw-bold mt-2 mb-3"></div>
                    </div>
                    <div class="col-lg-6">
                        <a href="{{ URL::to('/' . $reload) }} " type="button"
                            class="btn font-weight-bold btn-warning mr-2"> <i class="bi bi-box-arrow-in-left"></i>
                            Kembali</a>
                        
                    </div>
                </div>
            </div>

        </div>
        <!--end::Navbar-->
        <!--begin::Toolbar-->
        <div class="d-flex flex-wrap flex-stack mb-6">
            <!--begin::Heading-->
            <h3 class="fw-bolder my-2">Daftar Mahasiswa Angakatan
            </h3>
            <div class="d-flex align-items-center position-relative my-1">

            </div>
        </div>
        <input readonly type="hidden" name="page" id="page"
            class="form-control form-control-solid w-250px ps-15" />

        <div class="card">
            <div class="card-header">
                <h3 class="card-title">
                    <input type="text" data-kt-docs-table-filter="search" name="search" id="search"
                        class="form-control form-control-solid w-350px ps-15" placeholder="Cari NIM/Nama Mahasiswa" />
                </h3>
                <div class="card-toolbar">
                    <div class="example-tools justify-content-center">
                        <span class="example-toggle" data-toggle="tooltip" title=""
                            data-original-title="View code"></span>
                        <span class="example-copy" data-toggle="tooltip" title=""
                            data-original-title="Copy code"></span>
                    </div>
                </div>
            </div>

            <div class="card-body" id="data_table">

            </div>
        </div>


    </div>
@endsection()