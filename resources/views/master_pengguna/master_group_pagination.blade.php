<table id="kt_datatable_zero_configuration" class="table table-row-bordered gy-5">
    <thead>
        <tr class="fw-semibold fs-6 text-muted">
            <th>Nama Group</th>
            <th>Deskripsi</th>
            <th>Aksi</th>
        </tr>
    </thead>
    <tbody>
        @foreach ($list as $item)
            <tr>
                <td>{{ $item->nama_group }} </td>
                <td>{{ $item->deskripsi }} </td>
                <td><a class="btn btn-success btn-xs" id="aksi-{{ $item->id_master_group }}"
                    href="{{ URL::to('master_group/get_akses_aplikasi/' . $item->id_master_group) }}"> <i
                        class="fa-solid fa-bars"></i> Akses Aplikasi</a>
                        <a class="btn btn-warning btn-xs  tombol-$i" id="aksi-{{ $item->id_master_group }}"
                        href="{{ URL::to('master_group/edit_master_group/' . $item->id_master_group) }}"> <i class="fa-solid fa-pencil"></i> Edit</a>
                    <button class="btn btn-danger btn-xs  tombol-{{ $item->id_master_group }}"
                        id="aksi-delete-{{ $item->id_master_group }}"
                        onclick="delete_data('{{ $item->id_master_group }}')"> <i class="fa-solid fa-trash"></i>
                        Delete</button>
                </td>
            </tr>
        @endforeach
    </tbody>
    <tfoot>

    </tfoot>

</table>

{{ $list->links() }}