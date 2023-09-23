<table id="kt_datatable_zero_configuration" class="table table-row-bordered gy-5">
    <thead>
        <tr class="fw-semibold fs-6 text-muted">
            <th>Kode Rekening</th>
            <th>Nama Rekening</th>
            <th>Program Studi</th>
            <th>Aksi</th>
        </tr>
    </thead>
    <tbody>
        @foreach ($list as $item)
            <tr>
                <td>{{ $item->kode_rekening }} </td>
                <td>{{ $item->nama_rekening }} </td>
                <td>{{ $item->nama_program_studi }} </td>
                <td><a class="btn btn-warning btn-xs  tombol-$i" id="aksi- {{ $item->id_kode_pembayaran }}"
                        href="{{ URL::to('master_kode_pembayaran/edit_master_kode_pembayaran/' . $item->id_kode_pembayaran) }}">  <i class="fa-solid fa-pencil"></i> Edit</a>
                    <button class="btn btn-danger btn-xs  tombol-{{$item->id_kode_pembayaran}}" id="aksi-delete-{{ $item->id_kode_pembayaran }}"
                        onclick="delete_data('{{ $item->id_kode_pembayaran }}')"> <i class="fa-solid fa-trash"></i> Hapus</a>
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
