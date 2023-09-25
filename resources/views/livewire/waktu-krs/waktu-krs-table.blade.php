<div class="card bg-light shadow-sm">
    <div class="card-header">
        <h3 class="card-title"></h3>
        <div class="card-toolbar">
            <a href="{{ route('waktu_krs.add_waktu_krs') }}" type="button" class="btn btn-primary" data-bs-toggle="tooltip"
                data-bs-original-title="Coming Soon" data-kt-initialized="1">
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

        <table class="table table-row-bordered gy-5">
            <thead>
                <tr class="fw-semibold fs-6 text-muted">
                    <th>Nama KRS</th>
                    <th>Program Studi</th>
                    <th>Tahun Akademik</th>
                    <th>Tgl Mulai</th>
                    <th>Tgl selesai</th>
                    <th>Tgl Mulai Toleransi</th>
                    <th>Tgl Selesai Toleransi</th>
                    <th>Status</th>
                    <th>Matakuliah</th>
                    <th>Aksi</th>
                </tr>
            </thead>
            <tbody>
                @foreach ($list as $item)
                    <tr>
                        <td>{{ $item->nama_krs }} </td>
                        <td>{{ $item->nama_program_studi }} </td>
                        <td>{{ $item->nama_semester }} </td>
                        <td>{{ $item->tgl_mulai }} </td>
                        <td>{{ $item->tgl_selesai }} </td>
                        <td>{{ $item->tgl_toleransi_mulai }} </td>
                        <td>{{ $item->tgl_toleransi_selesai }} </td>
                        <td>{{ $item->status_data }} </td>
                        <td><a class="btn btn-success btn-xs" id="aksi- {{ $item->id_waktu_krs }}"
                                href="{{ URL::to('waktu_krs/detail_matakuliah/' . $item->id_waktu_krs) }}">
                                <i class="fa-solid fa-bars"></i>Matakuliah</a>
                        </td>
                        </td>
                        <td style="text-align: center;">
                            <a class="btn btn-warning btn-xs  tombol-$i" id="aksi- {{ $item->id_waktu_krs }}"
                                href="{{ URL::to('waktu_krs/edit_waktu_krs/' . $item->id_waktu_krs) }}">
                                <i class="fa-solid fa-pencil"></i> Edit</a>
                            <button class="btn btn-danger btn-xs"
                                wire:click="confirm({{ "'" . $item->id_waktu_krs . "'" }})">
                                <i class="fa-solid fa-trash"></i>
                                Hapus</a>
                                {{-- wire:click="confirm({{ "'" . $item->id_waktu_krs . "'" }})" --}}
                                {{-- perhatikan di atas, itu confirm di akali supaya menangkap uuid sebagai string --}}
                        </td>
                    </tr>
                @endforeach
            </tbody>
            <tfoot>

            </tfoot>

        </table>

        {{ $list->links() }}

    </div>
    <div class="card-footer">
    </div>
</div>
