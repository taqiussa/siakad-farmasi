<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\MasterAplikasi;
use App\Models\MasterMenu;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Exception;
// use DB;

class MasterMenuController extends Controller
{
    public $search = '';

    public function __construct()
    {
        $this->middleware('auth');

        $this->data = array(
            'msg_main' => '',
            'msg_detail' => '',
            'menu_app' => '',
            'submit' => 'insert_master_menu',
            'add_menu' => 'add_master_menu',
            'add_submenu' => 'add_sub_menu',
            'reload' => 'master_menu',
        );
    }

    function index()
    {
        return view('master_menu.index', $this->data);
    }

    function GetMasterAplikasi(Request $request)
    {
        if ($request->ajax()) {
            $list   = ["list" => MasterAplikasi::when($request->search,  fn ($query) => $query->where('nama_aplikasi', 'ILIKE', '%' . $request->search . '%'))
                ->paginate(10)];
            return view('master_menu.master_aplikasi_pagination', $list)->render();
        }
    }

    function GetMasterMenu($id)
    {

        $master_aplikasi = DB::table('master_aplikasi')
            ->where('id_master_aplikasi', $id)
            ->first();

        $this->data["master_aplikasi"]  = $master_aplikasi;

        $this->data['reload'] = 'master_menu' ;
        $this->data['add'] = 'master_menu/add_master_menu/'.$id ;


        return view('master_menu.menu',  $this->data);
    }

    function GetMasterMenuPagination(Request $request)
    {
        $data = DB::table('master_menu')
            ->select('id_master_menu', 'nama_menu', 'deskripsi', 'order', 'icon')
            ->where('id_master_aplikasi', $request->id_master_aplikasi)
            ->when($request->search,  fn ($query) => $query->where('nama_menu', 'ILIKE', '%' . $request->search . '%'))
            ->orderBy('order', 'asc')
            ->paginate(10);

        $this->data["list"]    = $data;
        return view('master_menu.master_menu_pagination',  $this->data);
    }

    public function AddMasterMenu($id)
    {
        $master_aplikasi = DB::table('master_aplikasi')
            ->where('id_master_aplikasi', $id)
            ->first();

            
        $forminput = [
            [
                "caption"       => 'Id Master Aplikasi',
                "type"          => 'hidden',
                "required"      => 'required',
                "placeholder"   => '',
                "name"          => 'id_master_aplikasi',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $master_aplikasi->id_master_aplikasi,

            ],
            [
                "caption"       => 'Nama Menu',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Menu. Contoh : Master Menu',
                "name"          => 'nama_menu',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',

            ],
            [
                "caption"       => 'Deskripsi',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Deskripsi. Contoh : Master Menu Utama',
                "name"          => 'deskripsi',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',
            ],
            [
                "caption"       => 'Urutan Menu',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Urutan Menu. Contoh : 1',
                "name"          => 'order',
                "class"         => 'numberonly',
                "property"      => '',
                "data"          => '',
                "value"         => '',
            ],
            [
                "caption"       => 'Icon',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Icon',
                "name"          => 'icon',
                "class"         => '',
                "property"      => 'onfocus=modal_icon()',
                "data"          => '',
                "value"         => '',
            ]
        ];

        $this->data['forminput'] = $forminput;
        $this->data['submit'] = 'master_menu/insert_master_menu';
        $this->data['reload'] =  'master_menu/get_master_menu/'.$id ;
       
        return view('master_menu.add', $this->data);
    }

    public function EditMasterMenu($id)
    {
        $edit = DB::table('master_menu')
            ->where('id_master_menu', $id)
            ->first();

        $forminput = [
            [
                "caption"       => 'Id Master Menu',
                "type"          => 'hidden',
                "required"      => 'required',
                "placeholder"   => '',
                "name"          => 'id_master_menu',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->id_master_menu,

            ],
            [
                "caption"       => 'Id Master Aplikasi',
                "type"          => 'hidden',
                "required"      => 'required',
                "placeholder"   => '',
                "name"          => 'id_master_aplikasi',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->id_master_aplikasi,

            ],
            [
                "caption"       => 'Nama Menu',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Menu. Contoh : Master Menu',
                "name"          => 'nama_menu',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->nama_menu,

            ],
            [
                "caption"       => 'Deskripsi',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Deskripsi. Contoh : Master Menu Utama',
                "name"          => 'deskripsi',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->deskripsi,
            ],
            [
                "caption"       => 'Urutan Menu',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Urutan Menu. Contoh : 1',
                "name"          => 'order',
                "class"         => 'numberonly',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->order,
            ],
            [
                "caption"       => 'Icon',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Icon',
                "name"          => 'icon',
                "class"         => '',
                "property"      => 'onfocus=modal_icon()',
                "data"          => '',
                "value"         => $edit->icon,
            ]
        ];

        $this->data['submit'] = 'master_menu/insert_master_menu';
        $this->data['reload'] =  'master_menu/get_master_menu/'.$edit->id_master_aplikasi ;

        $this->data['forminput'] = $forminput;
        return view('master_menu.add', $this->data);
    }

    public function InsertMasterMenu(Request $request)
    {

        $data = array();

        $request->validate([
            'id_master_aplikasi'    => 'required',
            'nama_menu'             => 'required|max:255',
            'deskripsi'             => 'required',
            'order'                 => 'required',
            'icon'                  => 'required',
        ]);

        $cek = DB::table('master_aplikasi')
            ->where('id_master_aplikasi', $request->id_master_aplikasi)
            ->first();

        if (empty($cek)) {
            return Redirect()->route('master_menu.index')->with('error', 'Data tidak dapat disimpan');
        }

        if ($request->id_master_menu) {
            $edit = DB::table('master_menu')
                ->where('id_master_menu', $request->id_master_menu)
                ->first();

            if (empty($edit)) {
                return Redirect()->route('master_menu.index')->with('error', 'Data tidak dapat disimpan');
            }
        }

        $data['id_master_aplikasi'] = $request->id_master_aplikasi;
        $data['nama_menu']          = $request->nama_menu;
        $data['deskripsi']          = $request->deskripsi;
        $data['order']              = $request->order;
        $data['icon']               = $request->icon;

        if ($request->id_master_menu) {
            try {
                $insert = DB::table('master_menu')->where('id_master_menu', $request->id_master_menu)->update($data);
                if ($insert) {
                    return redirect('/master_menu/get_master_menu/' . $request->id_master_aplikasi)->with('success', 'Master Menu Berhasil Diubah');
                } else {
                    $notification = array(
                        'message' => 'error ',
                        'alert-type' => 'error'
                    );
                    return Redirect('/master_menu/get_master_menu/' . $request->id_master_aplikasi)->with($notification);
                }
            } catch (Exception $e) {
                $this->res  = $e->getMessage();
                $this->state = "0";
                return Redirect('/master_menu/get_master_menu/' . $request->id_master_aplikasi)->with($this->res);
            }
        } else {
            try {
                $insert = DB::table('master_menu')->insert($data);
                if ($insert) {
                    return redirect('/master_menu/get_master_menu/' . $request->id_master_aplikasi)->with('success', 'Master Menu Berhasil Disimpan');
                } else {
                    $notification = array(
                        'message' => 'error ',
                        'alert-type' => 'error'
                    );
                    return Redirect('/master_menu/get_master_menu/' . $request->id_master_aplikasi)->with($notification);
                }
            } catch (Exception $e) {
                $this->res  = $e->getMessage();
                $this->state = "0";
                return Redirect('/get_master_menu/' . $request->id_master_aplikasi)->with($this->res);
            }
        }
    }

    public function DeleteMasterMenu($id)
    {

        try {
            $delete = DB::table('master_menu')->where('id_master_menu', $id)->delete();
            if ($delete) {
                $this->res      = "Berhasil Menghapus Data";
                $this->state    = "1";
            } else {
                $this->res      = "Gagal Menghapus Data";
                $this->state    = "0";
            }
        } catch (Exception $e) {
            $this->res      = $e->getMessage();
            $this->state    = "0";
        }

        $arr = array(
            'state' => $this->state,
            'msg'   => $this->res,
        );

        echo json_encode($arr);
    }

    function GetSubMasterMenu($id)
    {

        $master_menu = DB::table('master_menu')
            ->where('id_master_menu', $id)
            ->first();

        $this->data["master_menu"]  = $master_menu;

        $this->data['add'] = 'master_menu/add_sub_menu/'.$id;
        $this->data['reload'] =  'master_menu/get_master_menu/'.$master_menu->id_master_aplikasi ;

        return view('master_menu.sub_menu',  $this->data);
    }

    function GetSubMenuPagination(Request $request)
    {
        $data = DB::table('master_modul')
            ->select('id_master_modul', 'nama_modul', 'deskripsi', 'order', 'icon', 'path','status_data')
            ->where('id_master_menu', $request->id_master_menu)
            ->when($request->search,  fn ($query) => $query->where('nama_modul', 'ILIKE', '%' . $request->search . '%'))
            ->orderBy('order', 'asc')
            ->paginate(10);

        $this->data["list"]    = $data;

        return view('master_menu.sub_menu_pagination',  $this->data);
    }

    public function AddSubModul($id)
    {
        $master_menu = DB::table('master_menu')
            ->where('id_master_menu', $id)
            ->first();

            $status = array(
                array('id' => 'aktif', 'value' => 'Aktif'),
                array('id' => 'tidak aktif', 'value' => 'Tidak Aktif')
            );


        $forminput = [
            [
                "caption"       => 'Id Master Aplikasi',
                "type"          => 'hidden',
                "required"      => 'required',
                "placeholder"   => '',
                "name"          => 'id_master_aplikasi',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $master_menu->id_master_aplikasi,

            ],
            [
                "caption"       => 'Id Master Menu',
                "type"          => 'hidden',
                "required"      => 'required',
                "placeholder"   => '',
                "name"          => 'id_master_menu',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $master_menu->id_master_menu,

            ],
            [
                "caption"       => 'Nama Modul',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Menu. Contoh : Master Menu',
                "name"          => 'nama_modul',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',

            ],
            [
                "caption"       => 'Path Modul',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Menu. Contoh : Master_Menu',
                "name"          => 'path',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',

            ],
            [
                "caption"       => 'Deskripsi',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Deskripsi. Contoh : Master Menu Utama',
                "name"          => 'deskripsi',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',
            ],
            [
                "caption"       => 'Urutan Menu Modul',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Urutan Menu Modul. Contoh : 1',
                "name"          => 'order',
                "class"         => 'numberonly',
                "property"      => '',
                "data"          => '',
                "value"         => '',
            ],
            [
                "caption"       => 'Icon',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Icon',
                "name"          => 'icon',
                "class"         => '',
                "property"      => 'onfocus=modal_icon()',
                "data"          => '',
                "value"         => '',
            ],
            [
                "caption"       => 'Status Data',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Status Data',
                "name"          => 'status_data',
                "class"         => 'virtual',
                "property"      => '',
                "data"          => $status,
                "value"         => '',
            ],
        ];

        $this->data['forminput'] = $forminput;
        $this->data['submit'] = 'master_menu/insert_sub_menu';
        $this->data['reload'] = 'master_menu/get_submaster_menu/' .  $master_menu->id_master_menu;

        return view('master_menu.add', $this->data);
    }

    public function EditSubModul($id)
    {
        $master_modul = DB::table('master_modul')
            ->where('id_master_modul', $id)
            ->first();

            $status = array(
                array('id' => 'aktif', 'value' => 'Aktif'),
                array('id' => 'tidak aktif', 'value' => 'Tidak Aktif')
            );


        $forminput = [
            [
                "caption"       => 'Id Master Aplikasi',
                "type"          => 'hidden',
                "required"      => 'required',
                "placeholder"   => '',
                "name"          => 'id_master_aplikasi',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $master_modul->id_master_aplikasi,

            ],
            [
                "caption"       => 'Id Master Menu',
                "type"          => 'hidden',
                "required"      => 'required',
                "placeholder"   => '',
                "name"          => 'id_master_menu',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $master_modul->id_master_menu,

            ],
            [
                "caption"       => 'Id Master Modul',
                "type"          => 'hidden',
                "required"      => 'required',
                "placeholder"   => '',
                "name"          => 'id_master_modul',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $master_modul->id_master_modul,

            ],
            [
                "caption"       => 'Nama Modul',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Menu. Contoh : Master Menu',
                "name"          => 'nama_modul',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $master_modul->nama_modul,

            ],
            [
                "caption"       => 'Path Modul',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Menu. Contoh : Master_Menu',
                "name"          => 'path',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $master_modul->path,

            ],
            [
                "caption"       => 'Deskripsi',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Deskripsi. Contoh : Master Menu Utama',
                "name"          => 'deskripsi',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $master_modul->deskripsi,
            ],
            [
                "caption"       => 'Urutan Menu Modul',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Urutan Menu Modul. Contoh : 1',
                "name"          => 'order',
                "class"         => 'numberonly',
                "property"      => '',
                "data"          => '',
                "value"         => $master_modul->order,
            ],
            [
                "caption"       => 'Icon',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Icon',
                "name"          => 'icon',
                "class"         => '',
                "property"      => 'onfocus=modal_icon()',
                "data"          => '',
                "value"         => $master_modul->icon,
            ],
            [
                "caption"       => 'Status Data',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Status Data',
                "name"          => 'status_data',
                "class"         => 'virtual',
                "property"      => '',
                "data"          => $status,
                "value"         => $master_modul->status_data,
            ],
        ];

        $this->data['forminput'] = $forminput;
        $this->data['submit'] = 'master_menu/insert_sub_menu';
        $this->data['reload'] = 'master_menu/get_submaster_menu/' .  $master_modul->id_master_menu;

        return view('master_menu.add', $this->data);
    }

    public function InsertSubMenu(Request $request)
    {

        $data = array();

        $request->validate([
            'id_master_aplikasi'    => 'required',
            'id_master_menu'        => 'required',
            'nama_modul'            => 'required|max:255',
            'path'                  => 'required|max:255',
            'deskripsi'             => 'required',
            'order'                 => 'required',
            'icon'                  => 'required',
            'status_data'           => 'required',
        ]);

        $cek = DB::table('master_menu')
            ->where('id_master_menu', $request->id_master_menu)
            ->first();

        if (empty($cek)) {
            return redirect('/master_menu/get_submaster_menu/' . $request->id_master_menu)->with('error', 'Data tidak dapat disimpan');
        }

        if ($request->id_master_modul) {
            $edit = DB::table('master_modul')
                ->where('id_master_modul', $request->id_master_modul)
                ->first();

            if (empty($edit)) {
                return redirect('/master_menu/get_master_menu/' . $request->id_master_aplikasi)->with('error', 'Data tidak dapat disimpan');
            }
        }


        $data['id_master_aplikasi'] = $request->id_master_aplikasi;
        $data['id_master_menu']     = $request->id_master_menu;
        $data['nama_modul']         = $request->nama_modul;
        $data['deskripsi']          = $request->deskripsi;
        $data['path']               = $request->path;
        $data['order']              = $request->order;
        $data['icon']               = $request->icon;
        $data['status_data']        = $request->status_data;

        if ($request->id_master_modul) {
           
            try {
                $insert = DB::table('master_modul')->where('id_master_modul', $request->id_master_modul)->update($data);
                if ($insert) {
                    return redirect('/master_menu/get_submaster_menu/' . $request->id_master_menu)->with('success', 'Master Menu Modul Berhasil Diubah');
                } else {
                    $notification = array(
                        'message' => 'error ',
                        'alert-type' => 'error'
                    );
                    return redirect('/master_menu/get_submaster_menu/' . $request->id_master_menu)->with($notification);
                }
            } catch (Exception $e) {
                $this->res  = $e->getMessage();
                $this->state = "0";
                return redirect('/master_menu/get_submaster_menu/' . $request->id_master_menu)->with($this->res);
            }
        } else {
           
            try {
                $insert = DB::table('master_modul')->insert($data);
                if ($insert) {
                    return redirect('/master_menu/get_submaster_menu/' . $request->id_master_menu)->with('success', 'Master Menu Modul Berhasil Disimpan');
                } else {
                    $notification = array(
                        'message' => 'error ',
                        'alert-type' => 'error'
                    );
                    return redirect('/master_menu/get_submaster_menu/' . $request->id_master_menu)->with($notification);
                }
            } catch (Exception $e) {
                $this->res  = $e->getMessage();
                $this->state = "0";
                return redirect('/master_menu/get_submaster_menu/' . $request->id_master_menu)->with($this->res);
            }
        }
    }

    public function DeleteSubMenu($id)
    {

        try {
            $delete = DB::table('master_modul')->where('id_master_modul', $id)->delete();
            if ($delete) {
                $this->res      = "Berhasil Menghapus Data";
                $this->state    = "1";
            } else {
                $this->res      = "Gagal Menghapus Data";
                $this->state    = "0";
            }
        } catch (Exception $e) {
            $this->res      = $e->getMessage();
            $this->state    = "0";
        }

        $arr = array(
            'state' => $this->state,
            'msg'   => $this->res,
        );

        echo json_encode($arr);
    }
}
