@extends('main.layout')
@section('content')
    <script type="text/javascript">
        var CSRF_TOKEN = document.getElementsByName("_token")[0].value;
        $(document).ready(function() {

            getkurikulum();

        });


        function getkurikulum() {
            var id_prodi = document.getElementById('id_prodi').value;
            $.ajax({
                url: "{{ url('master_data/get_kurikulum') }}",
                type: "post",
                dataType: 'json',
                delay: 250,
                data: {
                    _token: CSRF_TOKEN,
                    id_prodi: id_prodi // search term
                },
                success: function(response) {
                    $('#id_kurikulum').empty();
                    $('#id_kurikulum').append($("<option/>", {
                        value: '',
                        text: 'Pilih Program Studi'
                    }));
                    $.each(response, function(key, value) {
                        $('#id_kurikulum').append($("<option/>", {
                            value: value.id,
                            text: value.text
                        }));
                    });
                },
                cache: true
            })
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
