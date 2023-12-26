{{-- @extends('main.layout')
@section('content')
    --}}

    <div id="kt_content_container" class="container">
        <div class="card mb-6">
            <div class="card-header">
                <h3 class="card-title">
                    Matakulih KRS
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
                    <div class="row mb-8 d-none" id="div_id_waktu_krs">
                        <div class="col-xl-4">
                            <div class=" required fs-6 fw-bold mt-2 mb-3 ">ID Waktu Krs</div>
                        </div>
                        <div class="col-lg-8">
                            <input type="text"  wire:model="id_waktu_krs" class="form-control "
                                placeholder="" id="id_waktu_krs"
                                name="id_waktu_krs" readonly value="">
                        </div>
                    </div>

                    <div class="row mb-8 " id="div_nama_krs">
                        <div class="col-xl-4">
                            <div class=" required fs-6 fw-bold mt-2 mb-3 ">Nama Waktu Krs</div>
                        </div>
                        <div class="col-lg-8">
                            <input type="text" wire:model="nama_krs" class="form-control "
                                placeholder="Masukan Nama KRS. Contoh : " id="nama_krs"
                                name="nama_krs" readonly value="">
                        </div>
                    </div>
                    <div class="row mb-8 " id="div_jumlah_sks_wajib">
                        <div class="col-xl-4">
                            <div class=" required fs-6 fw-bold mt-2 mb-3 ">Program Studi</div>
                        </div>
                        <div class="col-lg-8">
                            <input type="text" wire:model="jumlah_sks_wajib" class="form-control numberonly skstotal"
                                placeholder="Masukan SKS Mata Kuliah Wajib. Contoh: 2" id="jumlah_sks_wajib"
                                name="jumlah_sks_wajib" readonly required="" value="">
                        </div>
                    </div>
                    <div class="row mb-8 " id="div_jumlah_sks_wajib">
                        <div class="col-xl-4">
                            <div class=" required fs-6 fw-bold mt-2 mb-3 ">Tahun Akademik</div>
                        </div>
                        <div class="col-lg-8">
                            <input type="text" wire:model="jumlah_sks_wajib" class="form-control numberonly skstotal"
                                placeholder="Masukan SKS Mata Kuliah Wajib. Contoh: 2" id="jumlah_sks_wajib"
                                name="jumlah_sks_wajib" readonly required="" value="">
                        </div>
                    </div>
                    <div class="row mb-8 " id="div_jumlah_sks_wajib">
                        <div class="col-xl-4">
                            <div class=" required fs-6 fw-bold mt-2 mb-3 ">Status Data</div>
                        </div>
                        <div class="col-lg-8">
                            <input type="text" wire:model="jumlah_sks_wajib" class="form-control numberonly skstotal"
                                placeholder="Masukan SKS Mata Kuliah Wajib. Contoh: 2" id="jumlah_sks_wajib"
                                name="jumlah_sks_wajib" readonly required="" value="">
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="row mb-8 " id="div_jumlah_sks_wajib">
                        <div class="col-xl-6">
                            <div class=" required fs-6 fw-bold mt-2 mb-3 ">Tgl Mulai Berlaku</div>
                        </div>
                        <div class="col-lg-6">
                            <input type="text" wire:model="jumlah_sks_wajib" class="form-control numberonly skstotal"
                                placeholder="Masukan SKS Mata Kuliah Wajib. Contoh: 2" id="jumlah_sks_wajib"
                                name="jumlah_sks_wajib" readonly required="" value="">
                        </div>
                    </div>
                    <div class="row mb-8 " id="div_jumlah_sks_pilihan">
                        <div class="col-xl-6">
                            <div class=" required fs-6 fw-bold mt-2 mb-3 ">Tgl Selesai </div>
                        </div>
                        <div class="col-lg-6">
                            <input type="text" wire:model="jumlah_sks_pilihan" class="form-control numberonly skstotal"
                                placeholder="Masukan SKS Mata Kuliah Pilihan. Contoh: 2" id="jumlah_sks_pilihan"
                                name="jumlah_sks_pilihan" readonly required="" value="">
                        </div>
                    </div>
                    <div class="row mb-8 " id="div_jumlah_sks_pilihan">
                        <div class="col-xl-6">
                            <div class=" required fs-6 fw-bold mt-2 mb-3 ">Tgl Mulai Toleransi </div>
                        </div>
                        <div class="col-lg-6">
                            <input type="text" wire:model="jumlah_sks_pilihan" class="form-control numberonly skstotal"
                                placeholder="Masukan SKS Mata Kuliah Pilihan. Contoh: 2" id="jumlah_sks_pilihan"
                                name="jumlah_sks_pilihan" readonly required="" value="">
                        </div>
                    </div>
                    <div class="row mb-8 " id="div_jumlah_sks_pilihan">
                        <div class="col-xl-6">
                            <div class=" required fs-6 fw-bold mt-2 mb-3 ">Tgl Selesai Toleransi</div>
                        </div>
                        <div class="col-lg-6">
                            <input type="text" wire:model="jumlah_sks_pilihan" class="form-control numberonly skstotal"
                                placeholder="Masukan SKS Mata Kuliah Pilihan. Contoh: 2" id="jumlah_sks_pilihan"
                                name="jumlah_sks_pilihan" readonly required="" value="">
                        </div>
                    </div>
                </div>
                <div class="row mb-8 " id="div_button">
                    <div class="col-xl-3">
                        <div class=" fs-6 fw-bold mt-2 mb-3"></div>
                    </div>
                    <div class="col-lg-6">
                        <a href="{{ route('waktu_krs') }} " type="button"
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
            <h3 class="fw-bolder my-2">Daftar Matakuliah KRS Angakatan
            </h3>
            <div class="d-flex align-items-center position-relative my-1">

            </div>
        </div>
        <input readonly type="hidden" name="page" id="page"
            class="form-control form-control-solid w-250px ps-15" />

        <div class="card">
            <div class="card-header">
                <h3 class="card-title">
                   
                    
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
            <div class="card-body">
                <div class="form-group row mt-2">
                    <div class="col-lg-8">
                        {{-- @foreach ($forminput as $item)
                        @include('main.form')
                    @endforeach --}}
                    </div>
                </div>
            </div>

            <div class="card-body" id="data_table">

            </div>
        </div>


    </div>
{{-- @endsection() --}}
