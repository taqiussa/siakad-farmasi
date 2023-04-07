<?php

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Request;
use Illuminate\Support\Facades\Auth;

if (!function_exists('getMenus')) {
    function getMenus()
    {
        // $menu = Auth::user()->id_user;
        $menu = DB::table('trans_user_group')
            ->join('group_akses', 'trans_user_group.id_master_group', '=', 'group_akses.id_master_group')
            ->join('master_modul', 'group_akses.id_master_modul', '=', 'master_modul.id_master_modul')
            ->join('master_menu', 'master_modul.id_master_menu', '=', 'master_menu.id_master_menu')
            ->select('master_menu.id_master_aplikasi', 'master_menu.nama_menu', 'master_menu.order', 'master_menu.icon', 'master_modul.nama_modul', 'master_modul.order as order_modul', 'master_modul.path', 'master_modul.status_data', 'master_modul.icon as icon_modul', 'trans_user_group.id_user')
            ->groupBy('master_menu.id_master_aplikasi', 'master_menu.nama_menu', 'master_menu.order', 'master_menu.icon', 'master_modul.nama_modul', 'master_modul.order', 'master_modul.path', 'master_modul.status_data', 'master_modul.icon', 'trans_user_group.id_user')
            ->where('trans_user_group.id_user', Auth::user()->id_user)
            ->where('master_menu.id_master_aplikasi', '6d920eeb-5be8-4346-a6cd-edcd26c95780')
            ->get();

        $menu = group_by('nama_menu', json_decode(json_encode($menu), true));
        return $menu;
    }
}

function getDetailMenus()
{
    //    $path =  Request::segment(1);
    if (Request::segment(1) != "home") {

        $menu = DB::table('master_modul')
            ->where('path', Request::segment(1))
            ->first();
    } else {
        $arr = array(
            "nama_modul" => "Home",
            "deskripsi" => "Dashboard",
            "path" => "home",
        );
        $menu = (object) $arr;
    }
    return $menu;
}


// membuat array menjadi key 
function group_by($key, $data)
{
    $result = array();

    foreach ($data as $val) {
        if (array_key_exists($key, $val)) {
            $result[$val[$key]][] = $val;
        } else {
            $result[""][] = $val;
        }
    }

    return $result;
}

function getApplikasi()
{
    $aplikasi = DB::table('master_aplikasi')
        ->where('id_master_aplikasi', '6d920eeb-5be8-4346-a6cd-edcd26c95780')
        ->first();
        
    return   $aplikasi;
}
