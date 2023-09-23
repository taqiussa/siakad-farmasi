<table id="kt_datatable_zero_configuration" class="table table-row-bordered gy-5">
    <thead>
        <tr class="fw-semibold fs-6 text-muted">
            <th>Nama Kurikulum</th>
            <th>Program Studi</th>
            <th>Mulai Berlaku</th>
            <th>SKS Lulus </th>
            <th>SKS Wajib </th>
            <th>SKS Pilihan</th>
            {{-- <th>SKS Silabus </th>
            <th>Jenis MK</th> --}}
            <th>Detail</th>
            <th>Aksi</th>
        </tr>
    </thead>
    <tbody>
        @foreach ($list as $item)
            <tr>
                <td>{{ $item->nama_kurikulum }} </td>
                <td>{{ $item->nama_jenjang_pendidikan ." - ". $item->nama_program_studi}} </td>
                <td>{{ $item->nama_semester }} </td>
                <td>{{ $item->jumlah_sks_lulus }} </td>
                <td>{{ $item->jumlah_sks_wajib }} </td>
                <td>{{ $item->jumlah_sks_pilihan }} </td>
                {{-- <td>{{ $item->sks_simulasi }} </td>
                <td>{{ $item->nama_jenis_mata_kuliah }} </td>
                <td>{{ $item->nama_program_studi }} </td> --}}
                <td><a class="btn btn-success btn-xs" id="aksi- {{ $item->id_kurikulum }}"
                    href="{{ URL::to('master_kurikulum/detail_kurikulum/' . $item->id_kurikulum) }}"> <i
                        class="fa-solid fa-bars"></i>Detail</a>
            </td>
                <td><a class="btn btn-warning btn-xs  tombol-$i" id="aksi- {{ $item->id_kurikulum }}"
                        href="{{ URL::to('master_kurikulum/edit_master_kurikulum/' . $item->id_kurikulum) }}">  <i class="fa-solid fa-pencil"></i> Edit</a>
                    <button class="btn btn-danger btn-xs  tombol-{{$item->id_kurikulum}}" id="aksi-delete-{{ $item->id_kurikulum }}"
                        onclick="delete_data('{{ $item->id_kurikulum }}')"> <i class="fa-solid fa-trash"></i> Hapus</a>
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
