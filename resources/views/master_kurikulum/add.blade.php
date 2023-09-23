@extends('main.layout')
@section('content')
    <script type="text/javascript">
        var CSRF_TOKEN = document.getElementsByName("_token")[0].value;
        $(document).ready(function() {

            $('.skstotal').keyup(function(e) {
                var jumlah_sks_wajib   = parseInt(document.getElementById('jumlah_sks_wajib').value)|| 0;
                var jumlah_sks_pilihan = parseInt(document.getElementById('jumlah_sks_pilihan').value)|| 0;

                var sks_total = jumlah_sks_wajib + jumlah_sks_pilihan;
                document.getElementById("jumlah_sks_lulus").value = sks_total; 

            });

        });

    
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
