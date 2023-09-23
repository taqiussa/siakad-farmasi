@extends('main.layout')
@section('content')
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
                            <h3 class="card-title"> Data Mahasiswa </h3>
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
                <div class="card shadow-sm">
                    <div class="card-header card-header-stretch">
                        <h3 class="card-title"> Informasi Detail Mahasiswa </h3>
                        <div class="card-toolbar">
                            <ul class="nav nav-tabs nav-line-tabs nav-stretch fs-6 border-0">
                               {{-- {{$forminputtabs->keys();}}  --}}
                               {{-- {{dd(array_keys($forminputtabs))}} --}}
                                @foreach (array_keys($forminputtabs) as $item)
                                <li class="nav-item">
                                    <a class="nav-link  @if ($defaulttabs=="$item") active @endif " data-bs-toggle="tab" href="#{{$item}}">{{$item}}</a>
                                </li>
                                @endforeach
                            </ul>
                        </div>
                    </div>
                    <div class="card-body">
                        @foreach (array_keys($forminputtabs) as $forminput)
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade @if ($defaulttabs=="$forminput") active @endif show" id="{{$forminput}}" role="tabpanel">
                                {{-- {{dd($forminputtabs[$forminput])}} --}}
                                @foreach ($forminputtabs[$forminput] as $item)
                                    @include('main.form')
                                @endforeach
                            </div>
                        </div>
                        @endforeach
                    </div>
                </div>
                {{-- </div> --}}
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
