<script>
    $(document).ready(function() {
        $('.numberonly').keypress(function(e) {

            var charCode = (e.which) ? e.which : event.keyCode
            if (String.fromCharCode(charCode).match(/[^0-9]/g))

                return false;

        });

        $('.currency').keyup(function(e) {
            $(this).val(format($(this).val()));
        });
    });
</script>
@foreach ($forminput as $item)
    @include('main.form')
@endforeach
<a onclick="simpan_tagihan()" type="button" class="btn font-weight-bold btn-primary mr-2"> <i
        class="bi bi-database-add"></i> Tambah
    tagihan</a>

<table id="kt_datatable_zero_configuration" class="table table-row-bordered gy-5">
    <thead>
        <tr class="fw-semibold fs-6 text-muted">
            <th>Kode Rekening</th>
            <th>Nama Rekening</th>
            <th>Biaya</th>
            <th>Aksi</th>
        </tr>
    </thead>
    <tbody>
        @foreach ($list as $item)
            <tr>
                <td>{{ $item->kode_rekening }} </td>
                <td>{{ $item->nama_rekening }} </td>
                <td>{{ $item->biaya }} </td>
                <td>
                    <button class="btn btn-danger btn-xs  tombol-{{ $item->id_tagihan_angkatan }}"
                        id="aksi-delete-{{ $item->id_tagihan_angkatan }}"
                        onclick="delete_data('{{ $item->id_tagihan_angkatan }}')"> <i class="fa-solid fa-trash"></i>
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
