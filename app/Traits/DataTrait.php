<?php

namespace App\Traits;

use Illuminate\Support\Facades\DB;

trait DataTrait
{
    function GetProgramStudi($id = null)
    {
        if (!$id) {
            return DB::connection('akademik')->table("siakad.master_prodi")
                ->select(
                    'id_prodi as id',
                    DB::raw("CONCAT(kode_program_studi,' - ',nama_jenjang_pendidikan, ' - ', nama_program_studi)  as value")
                )
                ->get();
        } else {
            return DB::connection('akademik')->table("siakad.master_prodi")
                ->where('id_prodi', '=',  $id)
                ->first();
        }
    }

    function GetTahunAkademik($id = null)
    {
        if (!$id) {
            return DB::connection('akademik')->table("siakad.master_tahun_akademik")
                ->select('id_tahun_akademik as id', 'nama_semester as value')
                ->get();
        } else {
            return DB::connection('akademik')->table("siakad.master_tahun_akademik")
                ->where('id_tahun_akademik', '=',  $id)
                ->first();
        }
    }

    function GetStatus()
    {
        $status = (object) [
            (object)  ['id' => 'Aktif', 'value' => 'aktif'],
            (object)  ['id' => 'Tidak Aktif', 'value' => 'Tidak Aktif']
        ];
        return $status;
    }
}
