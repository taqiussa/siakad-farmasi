<script>
    $(document).ready(function() {
        $('#id_registrasi_mahasiswa').select2({

        });
    });
</script>
@foreach ($forminput as $item)
    @include('main.form')
@endforeach
<a onclick="simpan_mahasiswa()" type="button" class="btn font-weight-bold btn-primary mr-2"> <i
        class="bi bi-database-add"></i> Tambah
    Mahasiswa</a>

<table id="kt_datatable_zero_configuration" class="table table-row-bordered gy-5">
    <thead>
        <tr class="fw-semibold fs-6 text-muted">
            <th>NIM</th>
            <th>Nama Mahasiswa</th>
            <th>Aksi</th>
        </tr>
    </thead>
    <tbody>
        @foreach ($list as $item)
            <tr>
                <td>{{ $item->nim }} </td>
                <td>{{ $item->nama_mahasiswa }} </td>
                <td>
                    <button class="btn btn-danger btn-xs  tombol-{{ $item->id_mahasiswa_angkatan }}"
                        id="aksi-delete-{{ $item->id_mahasiswa_angkatan }}"
                        onclick="delete_data('{{ $item->id_mahasiswa_angkatan }}')"> <i class="fa-solid fa-trash"></i>
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
