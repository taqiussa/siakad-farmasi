@extends('main.layout')
@section('content')
    <script type="text/javascript">
        function simpan_akses(id_master_modul) {
            var akses = document.getElementById(id_master_modul).checked;
            var id_master_group = document.getElementById('id_master_group').value;
            var id_master_aplikasi = document.getElementById('id_master_aplikasi').value;

            $.ajax({
                type: "post",
                // headers: {
                //     'X-CSRF-TOKEN': $('meta[name="_token"]').attr('content')
                // },
                url: "{{ URL::to('/' . $submit) }}",
                data: {
                    "id_master_aplikasi": id_master_aplikasi,
                    "id_master_group": id_master_group,
                    "id_master_modul": id_master_modul,
                    "akses": akses,
                    '_token': "{{ csrf_token() }}"
                },
                beforeSend: function() {},
                success: function(resp) {
                    var obj = jQuery.parseJSON(resp);
                    if (obj.state === "1") {
                        toastr.success(obj.msg, obj.title);
                        document.getElementById("msg-" + id_master_modul).innerHTML = obj.msg;
                    } else {
                        toastr.error(obj.msg, obj.title);
                        document.getElementById("msg-" + id_master_modul).innerHTML = obj.msg;

                    }



                },
                error: function(event, textStatus, errorThrown) {
                    console.log('Pesan: ' + textStatus + ' , HTTP: ' + errorThrown);
                }
            });

        }
    </script>
    <form class="form">
        @csrf
        <div class="card">
            <div class="card-header">
                <div class="card-title fs-3 fw-bolder">{{ $master_group->nama_aplikasi }} - {{ $master_group->nama_group }}
                </div>
                <div class="card-toolbar">
                    <div class="example-tools justify-content-center">
                        <a href="{{ URL::to('/' . $reload) }} " type="button" class="btn font-weight-bold btn-warning mr-2"> <i class="bi bi-box-arrow-in-left"></i> Kembali</a>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <input type="hidden" id="id_master_group" name="id_master_group" value="{{ $master_group->id_master_group }}">
                <input type="hidden" id="id_master_aplikasi" name="id_master_aplikasi"
                    value="{{ $master_group->id_master_aplikasi }}">
                <div class="row">
                    <div class="col-xl-3">
                        <div class="fs-6 fw-bold mt-2 mb-3">Nama Modul</div>
                    </div>
                    <div class="col-xl-9">
                        <div class="fs-6 fw-bold mt-2 mb-3">Aksi</div>
                    </div>
                </div>
                @foreach ($list as $item)
                    <div class="row">
                        <div class="col-xl-3">
                            <div class="fs-6 fw-bold mt-2 mb-3">{{ $item->nama_modul }}</div>
                        </div>
                        <div class="col-xl-9">
                            <div class="form-check form-switch form-check-custom form-check-solid">
                                <input class="form-check-input" type="checkbox"
                                    onchange="simpan_akses('{{ $item->id_master_modul }}');"
                                    name="{{ $item->id_master_modul }}" id="{{ $item->id_master_modul }}"
                                    @if ($item->akses) checked="checked" @endif>
                                <label class="form-check-label fw-bold text-gray-400 ms-3"
                                    name="msg-{{ $item->id_master_modul }}" id="msg-{{ $item->id_master_modul }}"
                                    for="allowchanges"></label>
                            </div>
                        </div>
                    </div>
                @endforeach
            </div>
            <div class="card-footer d-flex justify-content-end py-6">
            </div>
        </div>
    </form>
@endsection
