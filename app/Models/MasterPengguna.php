<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;


class MasterPengguna extends Model
{
    use HasFactory;
    protected $table = 'users';
    protected $guarded=[];

    public static function getMasterMenu(){

        $data = DB::table('master_menu')
        ->select('id_master_aplikasi, nama_aplikasi, deskripsi, versi_aplikasi, status_data, tgl_version, url, image')
        ->paginate(10);

        return $data;
    }


}
