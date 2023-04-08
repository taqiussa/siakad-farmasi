<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth');
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function index()
    {
        $master_pengguna = DB::table('users')
            ->where('id_user', Auth::user()->id_user)
            ->first();

        $this->data['master_pengguna'] = $master_pengguna;
        return view('home.index',  $this->data);
    }


    function GetGroupPenggunaPagination(Request $request)
    {
        $data = DB::table('trans_user_group')
            ->join('master_group', 'trans_user_group.id_master_group', '=', 'master_group.id_master_group')
            ->join('master_aplikasi', 'trans_user_group.id_master_aplikasi', '=', 'master_aplikasi.id_master_aplikasi')
            ->select('master_aplikasi.nama_aplikasi', 'master_aplikasi.image', 'master_aplikasi.versi_aplikasi', 'master_aplikasi.deskripsi', 'master_aplikasi.url', 'master_group.nama_group', 'master_group.deskripsi as deskripsi_group', 'trans_user_group.id_trans_user_group', 'trans_user_group.status_data')
            ->where('trans_user_group.id_user', $request->id_user)
            ->where('trans_user_group.status_data', 'Aktif')
            ->when($request->search,  fn ($query) => $query->where('master_aplikasi.nama_aplikasi', 'ILIKE', '%' . $request->search . '%'))
            ->orderBy('master_aplikasi.nama_aplikasi', 'asc')
            ->paginate(9);

        $this->data["list"]    = $data;

        return view('home.group_pengguna_pagination',  $this->data);
    }
}
