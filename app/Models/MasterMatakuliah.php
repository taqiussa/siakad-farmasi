<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;


class MasterMatakuliah extends Model
{
    use HasFactory;
    protected $connection = 'akademik';
    protected $table = 'siakad.master_matakuliah';
    protected $guarded=[];

    public static function getMaster(){

        $data =DB::connection('akademik')->table('siakad.master_matakuliah')
        // ->select()
        ->paginate(10);

        return $data;
    }


}
