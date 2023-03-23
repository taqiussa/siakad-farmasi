<table id="kt_datatable_zero_configuration" class="table table-row-bordered gy-5">
    <thead>
        <tr class="fw-semibold fs-6 text-muted">
            <th>Nama Aplikasi</th>
            <th>Deskripsi</th>
            <th>Versi Aplikasi </th>
            <th>url</th>
            <th>Image</th>
            <th>Aksi</th>
        </tr>
    </thead>
    <tbody>
        @foreach ($list as $item)
            <tr>
                <td>{{ $item->nama_aplikasi }} </td>
                <td>{{ $item->deskripsi }} </td>
                <td>{{ $item->versi_aplikasi }} </td>
                <td>{{ $item->url }} </td>
                <td>
                    @if ($item->image)
                        <div class="image-input-wrapper w-125px h-125px ">
                            <img src="/images/{{ $item->image }}" width="125" height="125" />
                        </div>
                    @endif
                </td>
                <td><a class="btn btn-warning btn-xs  tombol-$i" id="aksi- {{ $item->id_master_aplikasi }}"
                        href="{{ URL::to('/edit_master_aplikasi/' . $item->id_master_aplikasi) }}">Edit</a>
                    <button class="btn btn-danger btn-xs  tombol-{{$item->id_master_aplikasi}}" id="aksi-delete-{{ $item->id_master_aplikasi }}"
                        onclick="delete_data('{{ $item->id_master_aplikasi }}')">Hapus</a>
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
