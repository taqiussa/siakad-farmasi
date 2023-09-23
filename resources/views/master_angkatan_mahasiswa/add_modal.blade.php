{{-- @extends('main.layout') --}}
@section('content')
<div class="card card-custom example example-compact">
    <div class="card-body">
        <form role="form" action="{{ URL::to('/' . $submit) }}" method="post" enctype="multipart/form-data">
            @csrf
            <div class="row">
                <div class="col-lg-12">
                    @foreach ($forminput as $item)
                        @include('main.form')
                    @endforeach
                    <br>
                    <div class="row mb-8">
                        <div class="col-xl-4">
                            <div class="fs-6 fw-bold mt-2 mb-3"></div>
                        </div>
                        <div class="col-lg-8">
                            <button type="button" onclick="simpan_matakuliah();" class="btn font-weight-bold btn-success mr-2 btn-simpan"><i
                                    class="la la-save"></i>Simpan</span></button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
