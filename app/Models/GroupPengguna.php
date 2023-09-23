<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;


class GroupPengguna extends Model
{
    use HasFactory;
    protected $table = 'master_menu';
    protected $guarded=[];

    public static function getMasterMenu(){

        $data = DB::table('master_menu')
        ->select('id_master_aplikasi, nama_aplikasi, deskripsi, versi_aplikasi, status_data, tgl_version, url, image')
        ->where('id_master_aplikasi', env('APP_ID')) 
        ->paginate(10);

        return $data;
    }


}
