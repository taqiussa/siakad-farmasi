@extends('main.layout')
@section('content')
    {{-- @extends('master_mahasiswa.js') --}}


    <script type="text/javascript">
        var CSRF_TOKEN = document.getElementsByName("_token")[0].value;
        $(document).ready(function() {

            $('.skstotal').keyup(function(e) {
                var sks_tatap_muka       = parseInt(document.getElementById('sks_tatap_muka').value)|| 0;
                var sks_praktek          = parseInt(document.getElementById('sks_praktek').value)|| 0;
                var sks_praktek_lapangan = parseInt(document.getElementById('sks_praktek_lapangan').value)|| 0;
                var sks_simulasi         = parseInt(document.getElementById('sks_simulasi').value)|| 0;

                var sks_total = sks_tatap_muka + sks_praktek + sks_simulasi + sks_praktek_lapangan;
                document.getElementById("sks_mata_kuliah").value = sks_total; 

            });

        });

        function getprogramstudi() {
            var search = document.getElementById('id_perguruan_tinggi_asal').value;
            $.ajax({
                url: "{{ url('master_data/get_prodi_universitas') }}",
                type: "post",
                dataType: 'json',
                delay: 250,
                data: {
                    _token: CSRF_TOKEN,
                    search: search // search term
                },
                success: function(response) {
                    $('#id_prodi_asal').empty();
                    $('#id_prodi_asal').append($("<option/>", {
                        value: '',
                        text: 'Pilih Program Studi'
                    }));
                    $.each(response, function(key, value) {
                        $('#id_prodi_asal').append($("<option/>", {
                            value: value.id,
                            text: value.text
                        }));
                    });
                },
                cache: true
            })
        }

        function display_univ() {
            var id_jenis_daftar = document.getElementById('id_jenis_daftar').value;
            // alert(id_jenis_daftar);
            var div_id_perguruan_tinggi_asal = document.getElementById("div_id_perguruan_tinggi_asal");
            var div_id_prodi_asal = document.getElementById("div_id_prodi_asal");
            if (id_jenis_daftar == "1") {
                div_id_perguruan_tinggi_asal.classList.add("d-none");
                div_id_prodi_asal.classList.add("d-none");
            } else {
                div_id_perguruan_tinggi_asal.classList.remove("d-none");
                div_id_prodi_asal.classList.remove("d-none");
            }
        }
    </script>

    <form role="form" action="{{ URL::to('/' . $submit) }}" method="post" enctype="multipart/form-data">
        @csrf
        <div class="card card-custom example example-compact">
            <div class="card-header">
                <h3 class="card-title"></h3>
                <div class="card-toolbar">
                    <div class="example-tools justify-content-center">
                        <a href="{{ URL::to('/' . $reload) }} " type="button" class="btn font-weight-bold btn-warning mr-2">
                            <i class="bi bi-box-arrow-in-left"></i> Kembali</a>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <div class="card shadow-sm p-10 ">
                    <div class="row">
                        <div class="card-header card-header-stretch">
                            <h3 class="card-title"> Tambah Data Matakuliah </h3>
                        </div>
                        <div class="card-body">
                            <div class="col-lg-12">
                                @foreach ($forminput as $item)
                                    @include('main.form')
                                @endforeach
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-footer">
                <div class="row ">

                    <div class="col-lg-12">
                        <div class="row mb-8">
                            <div class="col-xl-4">
                                <div class="fs-6 fw-bold mt-2 mb-3"></div>
                            </div>
                            <div class="col-lg-8">
                                <button type="submit" class="btn font-weight-bold btn-success mr-2 btn-simpan"><i
                                        class="la la-save"></i>Simpan</span></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
@endsection
