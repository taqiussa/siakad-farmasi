<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;


class MasterKurikulum extends Model
{
    use HasFactory;
    protected $connection = 'akademik';
    protected $table = 'siakad.master_kurikulum';
    protected $guarded=[];

    public static function getMaster(){

        $data =DB::connection('akademik')->table('siakad.kurikulum')
        // ->select()
        ->paginate(10);

        return $data;
    }


}
