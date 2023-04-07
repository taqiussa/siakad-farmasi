<table id="kt_datatable_zero_configuration" class="table table-row-bordered gy-5">
    <thead>
        <tr class="fw-semibold fs-6 text-muted">
            <th>Nama User</th>
            <th>Email</th>
            <th>Username</th>
            <th>Akses</th>
            <th>Aksi</th>
        </tr>
    </thead>
    <tbody>
        @foreach ($list as $item)
            <tr>
                <td>{{ $item->name }} </td>
                <td>{{ $item->email }} </td>
                <td>{{ $item->username }} </td>
                <td><a class="btn btn-success btn-xs" id="aksi- {{ $item->id }}"
                        href="{{ URL::to('master_pengguna/get_master_group/' . $item->id) }}"> <i
                            class="fa-solid fa-bars"></i> Group Pengguna</a>
                </td>
                <td>
                    <button class="btn btn-info btn-xs " id="aksi-reset-{{ $item->id_user }}"
                        onclick="reset_password('{{ $item->id_user }}')"><i class="fa-solid fa-rotate-right"></i>
                        Reset</button>
                    <a class="btn btn-warning btn-xs " id="aksi-edit-{{ $item->id_user }}"
                        href="{{ URL::to('/master_pengguna/edit_pengguna/' . $item->id_user) }}"> <i class="fa-solid fa-pencil"></i> Edit</a>
                    <button class="btn btn-danger btn-xs "
                        id="aksi-delete-{{ $item->id_user }}" onclick="delete_data('{{ $item->id_user }}')"> <i
                            class="fa-solid fa-trash"></i>
                        Delete</button>
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
