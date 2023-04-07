<?php

namespace App\Http\Middleware;

use Closure;
// use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
// use Illuminate\Support\Facades\Request;
use Illuminate\Http\Request;

class AksesModul
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next)
    {
        $menu = DB::table('trans_user_group')
            ->join('group_akses', 'trans_user_group.id_master_group', '=', 'group_akses.id_master_group')
            ->join('master_modul', 'group_akses.id_master_modul', '=', 'master_modul.id_master_modul')
            ->join('master_menu', 'master_modul.id_master_menu', '=', 'master_menu.id_master_menu')
            ->select('master_menu.id_master_aplikasi', 'master_menu.nama_menu', 'master_menu.order', 'master_menu.icon', 'master_modul.nama_modul', 'master_modul.order as order_modul', 'master_modul.path', 'master_modul.status_data', 'master_modul.icon as icon_modul', 'trans_user_group.id_user')
            ->groupBy('master_menu.id_master_aplikasi', 'master_menu.nama_menu', 'master_menu.order', 'master_menu.icon', 'master_modul.nama_modul', 'master_modul.order', 'master_modul.path', 'master_modul.status_data', 'master_modul.icon', 'trans_user_group.id_user')
            ->where('trans_user_group.id_user', Auth::user()->id_user)
            ->where('master_menu.id_master_aplikasi', '6d920eeb-5be8-4346-a6cd-edcd26c95780')
            ->where('master_modul.path', $request->segment(1)) 
            ->first();
            
        if(empty($menu)){
            return redirect('404');
            return false;
        }
 
        return $next($request);
        
    }
}
