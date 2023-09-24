@extends('main.layout')
@section('content')
    <div class="card bg-light shadow-sm">
        <div class="card-header">
            <h3 class="card-title"></h3>
            <div class="card-toolbar">
                <a href="{{ route('waktu_remidi.tambah_data') }}" type="button" class="btn btn-primary"
                    data-bs-toggle="tooltip" data-bs-original-title="Coming Soon" data-kt-initialized="1">
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

            @livewire('waktu-krs.waktu-krs-table')
            
            {{-- <form method="get" action="/waktu_krs">
                <div class="d-flex align-items-center position-relative my-1">
                    <input type="text" data-kt-docs-table-filter="search" name="search" id="search"
                        class="form-control form-control-solid w-250px ps-15" placeholder="Cari Nama Waktu KRS" />
                </div>
            </form>
            <input readonly type="hidden" name="page" id="page" class="form-control form-control-solid w-250px ps-15" />
            <div id="data_table">
            </div> --}}

        </div>
        <div class="card-footer">
        </div>
    </div>
@endsection
