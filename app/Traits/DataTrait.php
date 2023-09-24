<?php

namespace App\Traits;

use Illuminate\Support\Facades\DB;

trait DataTrait
{
    function GetProgramStudi()
    {
        return DB::connection('akademik')->table("siakad.master_prodi")
            ->select(
                'id_prodi as id',
                DB::raw("CONCAT(kode_program_studi,' - ',nama_jenjang_pendidikan, ' - ', nama_program_studi)  as value")
            )
            ->get();
    }

    function GetTahunAkademik()
    {
        return DB::connection('akademik')->table("siakad.master_tahun_akademik")
            ->select('id_tahun_akademik as id', 'nama_semester as value')
            ->get();
    }
}
