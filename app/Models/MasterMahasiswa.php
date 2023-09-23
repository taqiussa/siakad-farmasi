<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;


class MasterMahasiswa extends Model
{
    use HasFactory;
    protected $connection = 'akademik';
    protected $table = 'siakad.biodata_mahasiswa';
    protected $guarded=[];

    public static function getMaster(){

        $data =DB::connection('akademik')->table('siakad.biodata_mahasiswa')
        ->select('SELECT id_mahasiswa, nama_mahasiswa, jenis_kelamin, tempat_lahir, tanggal_lahir, id_agama, nama_agama, nik, nisn, npwp, id_negara, kewarganegaraan, jalan, dusun, rt, rw, kelurahan, kode_pos, id_wilayah, nama_jenis_tinggal, id_alat_transportasi, nama_alat_transportasi, telepon, handphone, email, penerima_kps, nik_ayah, nama_ayah, tanggal_lahir_ayah, id_pendidikan_ayah, nama_pendidikan_ayah, id_pekerjaan_ayah, nama_pekerjaan_ayah, id_penghasilan_ayah, nama_penghasilan_ayah, nik_ibu, nama_ibu_kandung, tanggal_lahir_ibu, id_pendidikan_ibu, nama_pendidikan_ibu, id_pekerjaan_ibu, nama_pekerjaan_ibu, id_penghasilan_ibu, nama_penghasilan_ibu, nama_wali, tanggal_lahir_wali, id_pekerjaan_wali, nama_pekerjaan_wali, id_penghasilan_wali, nama_penghasilan_wali, id_kebutuhan_khusus_mahasiswa, nama_kebutuhan_khusus_mahasiswa, id_kebutuhan_khusus_ayah, nama_kebutuhan_khusus_ayah, id_kebutuhan_khusus_ibu, nama_kebutuhan_khusus_ibu')
        ->paginate(10);

        return $data;
    }


}
