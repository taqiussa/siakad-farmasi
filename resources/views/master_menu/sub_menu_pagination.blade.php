<table id="kt_datatable_zero_configuration" class="table table-row-bordered gy-5">
    <thead>
        <tr class="fw-semibold fs-6 text-muted">
            <th>Nama Modul</th>
            <th>Deskripsi</th>
            <th>Path</th>
            <th>Urutan</th>
            <th>Icon</th>
            <th>Status Data</th>
            <th>Aksi</th>
        </tr>
    </thead>
    <tbody>
        @foreach ($list as $item)
            <tr>
                <td>{{ $item->nama_modul }} </td>
                <td>{{ $item->deskripsi }} </td>
                <td>{{ $item->path }} </td>
                <td>{{ $item->order }} </td>
                <td> <i class='fa {{ $item->icon }} '></i> </td>
                <td> {{ $item->status_data }} </td>
                <td>
                    <a class="btn btn-warning btn-xs  tombol-$i" id="aksi-{{ $item->id_master_modul }}"
                        href="{{ URL::to('/master_menu/edit_sub_menu/' . $item->id_master_modul) }}"> <i class="fa-solid fa-pencil"></i> Edit</a>
                    <button class="btn btn-danger btn-xs  tombol-{{ $item->id_master_modul }}"
                        id="aksi-delete-{{ $item->id_master_modul }}"
                        onclick="delete_data('{{ $item->id_master_modul }}')"> <i class="fa-solid fa-trash"></i>
                        Delete</button>
                </td>
            </tr>
        @endforeach
    </tbody>
    <tfoot>

    </tfoot>

</table>

{{ $list->links() }}