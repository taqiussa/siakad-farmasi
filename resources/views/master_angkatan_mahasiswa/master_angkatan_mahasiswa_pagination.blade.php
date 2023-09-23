<table id="kt_datatable_zero_configuration" class="table table-row-bordered gy-5">
    <thead>
        <tr class="fw-semibold fs-6 text-muted">
            <th>Nama Angakatan</th>
            <th>Program Studi</th>
            <th>Nama Kurikulum</th>
            <th>Mulai Berlaku</th>
            <th>Jumlah Mahasiswa</th>
            <th>Tagihan Mahasiswa</th>
            <th>Aksi</th>
        </tr>
    </thead>
    <tbody>
        @foreach ($list as $item)
            <tr>
                <td>{{ $item->nama_angkatan_mahasiswa }} </td>
                <td>{{ $item->nama_jenjang_pendidikan . ' - ' . $item->nama_program_studi }} </td>
                <td>{{ $item->nama_kurikulum }} </td>
                <td>{{ $item->nama_semester }} </td>
                <td><a class="btn btn-success btn-xs" id="aksi- {{ $item->id_angkatan_mahasiswa }}"
                        href="{{ URL::to('master_angkatan_mahasiswa/detail_mahasiswa/' . $item->id_angkatan_mahasiswa) }}">
                        <i class="fa-solid fa-bars"></i>@if ($item->jml)  {{$item->jml}} @else 0 @endif Mhs</a>
                </td>
                <td><a class="btn btn-info btn-xs" id="aksi- {{ $item->id_angkatan_mahasiswa }}"
                    href="{{ URL::to('master_angkatan_mahasiswa/detail_tagihan_angkatan/' . $item->id_angkatan_mahasiswa) }}">
                    <i class="fa-solid fa-bars"></i>Tagihan</a>
            </td>
                <td style="text-align: center;">
                    <a class="btn btn-warning btn-xs  tombol-$i" id="aksi- {{ $item->id_angkatan_mahasiswa }}"
                        href="{{ URL::to('master_angkatan_mahasiswa/edit_master_angkatan_mahasiswa/' . $item->id_angkatan_mahasiswa) }}">
                        <i class="fa-solid fa-pencil"></i> Edit</a>
                    <button class="btn btn-danger btn-xs  tombol-{{ $item->id_angkatan_mahasiswa }}"
                        id="aksi-delete-{{ $item->id_angkatan_mahasiswa }}"
                        onclick="delete_data('{{ $item->id_angkatan_mahasiswa }}')"> <i class="fa-solid fa-trash"></i>
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
