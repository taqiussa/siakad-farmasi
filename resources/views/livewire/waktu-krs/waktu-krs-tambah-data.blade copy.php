<form wire:submit.prevent="simpan" class="card card-custom example example-compact">
    <div class="card-header">
        <h3 class="card-title"></h3>
        <div class="card-toolbar">
            <div class="example-tools justify-content-center">
                <a href="{{ route('waktu_krs') }} " type="button" class="btn font-weight-bold btn-warning mr-2">
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
                        <div class="row mb-8">
                            <div class="col-xl-4">
                                <div class="fs-6 fw-bold mt-2 mb-3 ">Nama KRS <span class="text-danger">*</span></div>
                            </div>
                            <div class="col-lg-8">
                                <input wire:model="nama_krs" type="text" class="form-control"
                                    placeholder="Masukan Nama KRS. Contoh: KRS Online 2022/2023 Genap"
                                    name="nama_krs" />
                                @error('nama_krs')
                                    <div class="fv-plugins-message-container invalid-feedback">
                                        <div>* {{ $message }}</div>
                                    </div>
                                @enderror
                            </div>
                        </div>
                        <div class="row mb-8">
                            <div class="col-xl-4">
                                <div class="fs-6 fw-bold mt-2 mb-3 ">Program Studi KRS <span
                                        class="text-danger">*</span></div>
                            </div>
                            <div class="col-lg-8">
                                <select wire:model="id_prodi" name="id_prodi" class="form-select">
                                    <option value="">Pilih Program Studi</option>
                                    @foreach ($listProdi as $prodi)
                                        <option value="{{ $prodi->id }}">{{ $prodi->value }}</option>
                                    @endforeach
                                </select>
                                @error('id_prodi')
                                    <div class="fv-plugins-message-container invalid-feedback">
                                        <div>* {{ $message }}</div>
                                    </div>
                                @enderror
                            </div>
                        </div>
                        <div class="row mb-8">
                            <div class="col-xl-4">
                                <div class="fs-6 fw-bold mt-2 mb-3 ">Mulai Berlaku <span class="text-danger">*</span>
                                </div>
                            </div>
                            <div class="col-lg-8">
                                <select wire:model="id_tahun_akademik" name="id_tahun_akademik" class="form-select">
                                    <option value="">Pilih Tahun Akademik</option>
                                    @foreach ($listTahun as $tahun)
                                        <option value="{{ $tahun->id }}">{{ $tahun->value }}</option>
                                    @endforeach
                                </select>
                                @error('id_tahun_akademik')
                                    <div class="fv-plugins-message-container invalid-feedback">
                                        <div>* {{ $message }}</div>
                                    </div>
                                @enderror
                            </div>
                        </div>
                        <div class="row mb-8">
                            <div class="col-xl-4">
                                <div class="fs-6 fw-bold mt-2 mb-3 ">Tanggal Mulai <span class="text-danger">*</span>
                                </div>
                            </div>
                            <div class="col-lg-8">
                                <input wire:model="tgl_mulai" type="datetime-local" class="form-control"
                                    name="tgl_mulai" />
                                @error('tgl_mulai')
                                    <div class="fv-plugins-message-container invalid-feedback">
                                        <div>* {{ $message }}</div>
                                    </div>
                                @enderror
                            </div>
                        </div>
                        <div class="row mb-8">
                            <div class="col-xl-4">
                                <div class="fs-6 fw-bold mt-2 mb-3 ">Tanggal Selesai <span class="text-danger">*</span>
                                </div>
                            </div>
                            <div class="col-lg-8">
                                <input wire:model="tgl_selesai" type="datetime-local" class="form-control"
                                    name="tgl_selesai" />
                                @error('tgl_selesai')
                                    <div class="fv-plugins-message-container invalid-feedback">
                                        <div>* {{ $message }}</div>
                                    </div>
                                @enderror
                            </div>
                        </div>
                        <div class="row mb-8">
                            <div class="col-xl-4">
                                <div class="fs-6 fw-bold mt-2 mb-3 ">Tanggal Toleransi mulai <span
                                        class="text-danger">*</span>
                                </div>
                            </div>
                            <div class="col-lg-8">
                                <input wire:model="tgl_toleransi_mulai" type="datetime-local" class="form-control"
                                    name="tgl_toleransi_mulai" />
                                @error('tgl_toleransi_mulai')
                                    <div class="fv-plugins-message-container invalid-feedback">
                                        <div>* {{ $message }}</div>
                                    </div>
                                @enderror
                            </div>
                        </div>
                        <div class="row mb-8">
                            <div class="col-xl-4">
                                <div class="fs-6 fw-bold mt-2 mb-3 ">Tanggal Toleransi Selesai <span
                                        class="text-danger">*</span>
                                </div>
                            </div>
                            <div class="col-lg-8">
                                <input wire:model="tgl_toleransi_selesai" type="datetime-local" class="form-control"
                                    name="tgl_toleransi_selesai" />
                                @error('tgl_toleransi_selesai')
                                    <div class="fv-plugins-message-container invalid-feedback">
                                        <div>* {{ $message }}</div>
                                    </div>
                                @enderror
                            </div>
                        </div>
                        <div class="row mb-8">
                            <div class="col-xl-4">
                                <div class="fs-6 fw-bold mt-2 mb-3 ">Status Data <span class="text-danger">*</span>
                                </div>
                            </div>
                            <div class="col-lg-8">
                                <select wire:model="status_data" name="status_data" class="form-select">
                                    <option value="">Pilih Status Data</option>
                                    <option value="Aktif">Aktif</option>
                                    <option value="Tidak Aktif">Tidak Aktif</option>
                                </select>
                                @error('status_data')
                                    <div class="fv-plugins-message-container invalid-feedback">
                                        <div>* {{ $message }}</div>
                                    </div>
                                @enderror
                            </div>
                        </div>
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
