<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;


class MasterAplikasi extends Model
{
    use HasFactory;
    protected $table = 'master_aplikasi';
    protected $guarded=[];

    public static function getMaster(){

        $data = DB::table('master_aplikasi')
        ->select('id_master_aplikasi, nama_aplikasi, deskripsi, versi_aplikasi, status_data, tgl_version, url, image')
        ->paginate(10);

        return $data;
    }


}
