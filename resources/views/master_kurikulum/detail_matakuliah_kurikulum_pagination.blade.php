<table id="kt_datatable_zero_configuration" class="table table-row-bordered gy-5">
    <thead>
        <tr class="fw-semibold fs-6 text-muted">
            <th>Kode Matakuliah</th>
            <th>Nama Matakuliah Studi</th>
            <th>Total SKS</th>
            <th>SKS Teori </th>
            <th>SKS Praktek </th>
            <th>SKS Praktek Lapangan</th>
            <th>SKS Simulasi </th>
            <th>Semester</th>
            <th>Jenis</th>
            <th>Aksi</th>
        </tr>
    </thead>
    <tbody>
        @foreach ($list as $item)
            <tr>
                <td>{{ $item->kode_mata_kuliah }} </td>
                <td>{{ $item->nama_mata_kuliah }} </td>
                <td>{{ $item->sks_mata_kuliah }} </td>
                <td>{{ $item->sks_tatap_muka }} </td>
                <td>{{ $item->sks_praktek }} </td>
                <td>{{ $item->sks_praktek_lapangan }} </td>
                <td>{{ $item->sks_simulasi }} </td>
                <td>{{ $item->semester }} </td>
                <td>{{ $item->apakah_wajib }} </td>
                <td>
                    <button class="btn btn-danger btn-xs  tombol-{{$item->id_matakuliah_kurikulum}}" id="aksi-delete-{{ $item->id_matakuliah_kurikulum }}"
                        onclick="delete_data('{{ $item->id_matakuliah_kurikulum }}')"> <i class="fa-solid fa-trash"></i> Hapus</a>
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
