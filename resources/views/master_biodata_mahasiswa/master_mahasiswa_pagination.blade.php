<table id="kt_datatable_zero_configuration" class="table table-row-bordered gy-5">
    <thead>
        <tr class="fw-semibold fs-6 text-muted">
            <th>Nama Mahasiswa</th>
            <th>Jenis Kelamin</th>
            <th>Agama </th>
            <th>Tgl Lahir</th>
            <th>Program Studi</th>
            <th>Aksi</th>
        </tr>
    </thead>
    <tbody>
        @foreach ($list as $item)
            <tr>
                <td>{{ $item->nama_mahasiswa }} </td>
                <td>{{ $item->jenis_kelamin }} </td>
                <td>{{ $item->nama_agama }} </td>
                <td>{{ $item->tanggal_lahir }} </td>
                <td>{{ $item->nama_program_studi }} </td>
                <td><a class="btn btn-warning btn-xs  tombol-$i" id="aksi- {{ $item->id_mahasiswa }}"
                        href="{{ URL::to('master_biodata_mahasiswa/edit_master_biodata_mahasiswa/' . $item->id_mahasiswa) }}">  <i class="fa-solid fa-pencil"></i> Edit</a>
                    <button class="btn btn-danger btn-xs  tombol-{{$item->id_mahasiswa}}" id="aksi-delete-{{ $item->id_mahasiswa }}"
                        onclick="delete_data('{{ $item->id_mahasiswa }}')"> <i class="fa-solid fa-trash"></i> Hapus</a>
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
