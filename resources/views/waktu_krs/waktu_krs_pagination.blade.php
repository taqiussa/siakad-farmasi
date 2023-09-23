<table id="kt_datatable_zero_configuration" class="table table-row-bordered gy-5">
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
                    <button class="btn btn-danger btn-xs  tombol-{{ $item->id_waktu_krs }}"
                        id="aksi-delete-{{ $item->id_waktu_krs }}" onclick="delete_data('{{ $item->id_waktu_krs }}')">
                        <i class="fa-solid fa-trash"></i>
                        Hapus</a>
                </td>
            </tr>
        @endforeach
    </tbody>
    <tfoot>

    </tfoot>

</table>

{{ $list->links() }}
<div>


</div>
