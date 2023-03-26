<table id="kt_datatable_zero_configuration" class="table table-row-bordered gy-5">
    <thead>
        <tr class="fw-semibold fs-6 text-muted">
            <th>Nama Menu</th>
            <th>Deskripsi</th>
            <th>Urutan</th>
            <th>Icon</th>
            <th>Aksi</th>
        </tr>
    </thead>
    <tbody>
        @foreach ($list as $item)
            <tr>
                <td>{{ $item->nama_menu }} </td>
                <td>{{ $item->deskripsi }} </td>
                <td>{{ $item->order }} </td>
                <td> <i class='fa {{ $item->icon }} '></i> </td>
                <td><a class="btn btn-success btn-xs" id="aksi-{{ $item->id_master_menu }}"
                        href="{{ URL::to('/master_menu/get_submaster_menu/' . $item->id_master_menu) }}"> <i
                            class="fa-solid fa-bars"></i> Sub Menu</a>
                    <a class="btn btn-warning btn-xs  tombol-$i" id="aksi-{{ $item->id_master_menu }}"
                        href="{{ URL::to('/master_menu/edit_master_menu/' . $item->id_master_menu) }}"> <i class="fa-solid fa-pencil"></i> Edit</a>
                    <button class="btn btn-danger btn-xs  tombol-{{ $item->id_master_menu }}"
                        id="aksi-delete-{{ $item->id_master_menu }}"
                        onclick="delete_data('{{ $item->id_master_menu }}')"> <i class="fa-solid fa-trash"></i>
                        Delete</button>
                </td>
            </tr>
        @endforeach
    </tbody>
    <tfoot>

    </tfoot>

</table>

{{ $list->links() }}