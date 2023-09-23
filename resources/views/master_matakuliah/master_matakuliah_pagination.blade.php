<table id="kt_datatable_zero_configuration" class="table table-row-bordered gy-5">
    <thead>
        <tr class="fw-semibold fs-6 text-muted">
            <th>Kode Matakuliah</th>
            <th>Nama Matakuliah</th>
            <th>SKS Total</th>
            {{-- <th>SKS Teori </th>
            <th>SKS Praktikum </th>
            <th>SKS Praktek Lapangan </th>
            <th>SKS Silabus </th> --}}
            <th>Jenis MK</th>
            <th>Program Studi</th>
            <th>Aksi</th>
        </tr>
    </thead>
    <tbody>
        @foreach ($list as $item)
            <tr>
                <td>{{ $item->kode_mata_kuliah }} </td>
                <td>{{ $item->nama_mata_kuliah }} </td>
                <td>{{ $item->sks_mata_kuliah }} </td>
                {{-- <td>{{ $item->sks_tatap_muka }} </td>
                <td>{{ $item->sks_praktek }} </td>
                <td>{{ $item->sks_praktek_lapangan }} </td>
                <td>{{ $item->sks_simulasi }} </td> --}}
                <td>{{ $item->nama_jenis_mata_kuliah }} </td>
                <td>{{ $item->nama_program_studi }} </td>
                <td><a class="btn btn-warning btn-xs  tombol-$i" id="aksi- {{ $item->id_matkul }}"
                        href="{{ URL::to('master_matakuliah/edit_master_matakuliah/' . $item->id_matkul) }}">  <i class="fa-solid fa-pencil"></i> Edit</a>
                    <button class="btn btn-danger btn-xs  tombol-{{$item->id_matkul}}" id="aksi-delete-{{ $item->id_matkul }}"
                        onclick="delete_data('{{ $item->id_matkul }}')"> <i class="fa-solid fa-trash"></i> Hapus</a>
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
