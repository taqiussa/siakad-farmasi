@extends('main.layout')
@section('content')
    <div class="card card-custom example example-compact">
        <div class="card-header">
            <h3 class="card-title"></h3>
            <div class="card-toolbar">
                <div class="example-tools justify-content-center">
                    <a href="{{ route('waktu_remidi') }} " type="button" class="btn font-weight-bold btn-warning mr-2">
                        <i class="bi bi-box-arrow-in-left"></i> Kembali</a>
                </div>
            </div>
        </div>
        @livewire('waktu-krs.waktu-krs-tambah-data')
    </div>
@endsection
