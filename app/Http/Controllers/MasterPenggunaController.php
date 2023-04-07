<?php

namespace App\Http\Controllers;

// use App\Http\Controllers\Controller;
// use App\Models\MasterAplikasi;
use App\Models\MasterPengguna;
// use App\Models\MasterMenu;
// use App\Models\MasterModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
// use Carbon\Carbon;
use Exception;
use Illuminate\Database\Query\JoinClause;
use Illuminate\Support\Facades\Hash;
// use DB;

class MasterPenggunaController extends Controller
{
    public $search = '';

    public function __construct()
    {
    
        $this->middleware(['auth']);

        $this->data = array(
            'msg_main' => '',
            'msg_detail' => '',
            'menu_app' => '',
            'submit' => 'master_pengguna/insert_master_group',
            'add' => 'master_pengguna/add_master_group',
            'reload' => 'master_pengguna',
        );
    }

    function index()
    {
        // dd(session());
        $this->data['add'] =  'master_pengguna/add_pengguna';
        return view('master_pengguna.index', $this->data);
    }

    function GetPenggunaPagination(Request $request)
    {
        if ($request->ajax()) {
            $list   = ["list" => MasterPengguna::when(
                $request->search,
                fn ($query) => $query->where(
                    'name',
                    'ILIKE',
                    '%' . $request->search . '%'
                )
                    ->orWhere('username', 'ILIKE', '%' . $request->search . '%')
                    ->orWhere('email', 'ILIKE', '%' . $request->search . '%')
            )
                ->paginate(10)];
            return view('master_pengguna.master_pengguna_pagination', $list)->render();
        }
    }

    public function AddPengguna()
    {

        $status = array(
            array('id' => 'aktif', 'value' => 'Aktif'),
            array('id' => 'tidak aktif', 'value' => 'Tidak Aktif')
        );

        $forminput = [
            [
                "caption"       => 'Username',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Username. Contoh : admin',
                "name"          => 'username',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',

            ],
            [
                "caption"       => 'Nama Lengkap',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Lengkap. Contoh : adminis trator',
                "name"          => 'name',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',

            ],
            [
                "caption"       => 'Email',
                "type"          => 'email',
                "required"      => 'required',
                "placeholder"   => 'Masukan Email. Contoh : admin@email.com',
                "name"          => 'email',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',
            ],
            [
                "caption"       => 'Password',
                "type"          => 'password',
                "required"      => 'required',
                "placeholder"   => 'Masukan Password. Contoh : 12345678',
                "name"          => 'password',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',
            ],
            [
                "caption"       => 'Status Pengguna',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Status Pengguna',
                "name"          => 'status_data',
                "class"         => 'virtual',
                "property"      => '',
                "data"          => $status,
                "value"         => '',
            ],
        ];

        $this->data['forminput'] = $forminput;
        $this->data['submit'] = 'master_pengguna/insert_pengguna';
        $this->data['reload'] = 'master_pengguna';

        return view('master_pengguna.add', $this->data);
    }

    public function EditPengguna($id)
    {
        $master_pengguna = DB::table('users')
            ->where('id_user', $id)
            ->first();

        // dd($master_pengguna->id_user);

        $status = array(
            array('id' => 'aktif', 'value' => 'Aktif'),
            array('id' => 'tidak aktif', 'value' => 'Tidak Aktif')
        );

        $forminput = [
            [
                "caption"       => 'ID User',
                "type"          => 'hidden',
                "required"      => 'required',
                "placeholder"   => '',
                "name"          => 'id_user',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $master_pengguna->id_user,

            ],
            [
                "caption"       => 'Username',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Username. Contoh : admin',
                "name"          => 'username',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $master_pengguna->username,

            ],
            [
                "caption"       => 'Nama Lengkap',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Lengkap. Contoh : adminis trator',
                "name"          => 'name',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $master_pengguna->name,

            ],
            [
                "caption"       => 'Email',
                "type"          => 'email',
                "required"      => 'required',
                "placeholder"   => 'Masukan Email. Contoh : admin@email.com',
                "name"          => 'email',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $master_pengguna->email,
            ],
            [
                "caption"       => 'Password',
                "type"          => 'password',
                "required"      => '',
                "placeholder"   => 'Masukan Password. Contoh : 12345678',
                "name"          => 'password',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',
            ],
            [
                "caption"       => 'Status Pengguna',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Status Pengguna',
                "name"          => 'status_data',
                "class"         => 'virtual',
                "property"      => '',
                "data"          => $status,
                "value"         => $master_pengguna->status_data,
            ],
        ];

        $this->data['forminput'] = $forminput;
        $this->data['submit'] = 'master_pengguna/insert_pengguna';
        $this->data['reload'] = 'master_pengguna';

        return view('master_pengguna.add', $this->data);
    }

    public function InsertPengguna(Request $request)
    {

        $data = array();

        $request->validate([
            'username'      => 'required',
            'name'          => 'required|max:255',
            'email'         => 'required',
            'password'      => '',
            'status_data'   => 'required',
        ]);


        $data['username']       = $request->username;
        $data['name']           = $request->name;
        $data['email']          = $request->email;
        $data['status_data']    = $request->status_data;

        if ($request->password) {
            $data['password']       = Hash::make($request->password);
        }
        if ($request->id_user) {
            try {
                $insert = DB::table('users')->where('id_user', $request->id_user)->update($data);
                if ($insert) {
                    return redirect('/master_pengguna/')->with('success', 'Pengguna Berhasil Diubah');
                } else {
                    $notification = array(
                        'message' => 'error ',
                        'alert-type' => 'error'
                    );
                    return Redirect('/master_pengguna/')->with($notification);
                }
            } catch (Exception $e) {
                $this->res  = $e->getMessage();
                $this->state = "0";
                return Redirect('/master_pengguna/')->with($this->res);
            }
        } else {
            try {
                $insert = DB::table('users')->insert($data);
                dd($insert);
                if ($insert) {
                    return redirect('/master_pengguna/')->with('success', 'Pengguna Berhasil Disimpan');
                } else {
                    $notification = array(
                        'message' => 'error ',
                        'alert-type' => 'error'
                    );
                    return Redirect('/master_pengguna/')->with('error', $notification);
                }
            } catch (Exception $e) {
                $this->res  = $e->getMessage();
                $this->state = "0";
                return Redirect('/master_pengguna/')->with('error', json_encode($this->res));
            }
        }
    }

    public function DeletePengguna($id)
    {

        try {
            $delete = DB::table('users')
                ->where('id_user', $id)
                ->delete();
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

    function GetAksesPengguna($id)
    {
        $master_pengguna = DB::table('users')
            ->where('id', $id)
            ->first();
        $this->data['master_pengguna'] = $master_pengguna;
        $this->data['reload'] = 'master_pengguna';
        $this->data['submit'] = 'master_pengguna/insert_trans_user_group';
        return view('master_pengguna.group_pengguna',  $this->data);
    }

    function GetGroupPenggunaPagination(Request $request)
    {
        $data = DB::table('trans_user_group')
            ->join('master_group', 'trans_user_group.id_master_group', '=', 'master_group.id_master_group')
            ->join('master_aplikasi', 'trans_user_group.id_master_aplikasi', '=', 'master_aplikasi.id_master_aplikasi')
            ->select('master_aplikasi.nama_aplikasi', 'master_aplikasi.image', 'master_aplikasi.versi_aplikasi', 'master_aplikasi.deskripsi', 'master_aplikasi.url', 'master_group.nama_group', 'master_group.deskripsi as deskripsi_group', 'trans_user_group.id_trans_user_group', 'trans_user_group.status_data')
            ->where('trans_user_group.id_user', $request->id_user)
            ->when($request->search,  fn ($query) => $query->where('master_aplikasi.nama_aplikasi', 'ILIKE', '%' . $request->search . '%'))
            ->orderBy('master_aplikasi.nama_aplikasi', 'asc')
            ->paginate(9);

        $this->data["list"]    = $data;

        return view('master_pengguna.group_pengguna_pagination',  $this->data);
    }

    function AddAkses(Request $request)
    {
        // var_dump($request->id_user);exit();
        $master_aplikasi = DB::table('master_aplikasi')
            ->select('id_master_aplikasi as id', 'nama_aplikasi as value')
            ->get();
        $master_aplikasi = json_decode(json_encode($master_aplikasi), true);

        $this->data['id_user'] = $request->id_user;

        $forminput = [
            [
                "caption"       => 'ID User',
                "type"          => 'hidden',
                "required"      => 'required',
                "placeholder"   => '',
                "name"          => 'id_user',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $request->id_user,

            ],
            [
                "caption"       => 'Pilih Nama Aplikasi',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Status Aplikasi',
                "name"          => 'id_master_aplikasi',
                "class"         => 'virtual',
                "property"      => '',
                "data"          => $master_aplikasi,
                "value"         => '',
            ],
            [
                "caption"       => 'Pilih Master Group',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Master Group',
                "name"          => 'id_master_group',
                "class"         => 'virtual',
                "property"      => '',
                "data"          => '',
                "value"         => '',
            ],
        ];

        $this->data['forminput'] = $forminput;
        $this->data['submit'] = 'master_pengguna/insert_trans_user_group';
        $this->data['reload'] = 'master_pengguna';

        return view('master_pengguna.add_modal', $this->data);
    }

    function GetMasterGroup(Request $request)
    {
        // dd($request->id_master_aplikasi);

        $master_group = DB::table('master_group')
            ->where('id_master_aplikasi', $request->id_master_aplikasi)
            ->get();

        // $master_group = json_decode(json_encode($master_group), true);

        echo json_encode($master_group);
    }

    public function InsertTransUserGroup(Request $request)
    {
        $data = array();

        if ($request->id_trans_user_group) {
            if ($request->status_data == "true") {
                $data['status_data']        = 'Aktif';
            } else {
                $data['status_data']        = 'Tidak Aktif';
            }

            try {
                $insert = DB::table('trans_user_group')->where('id_trans_user_group', $request->id_trans_user_group)->update($data);
                if ($insert) {
                    $this->res      = "Berhasil Menyimpan Data";
                    $this->state    = "1";
                } else {
                    $this->res      = "Gagal Menyimpan Data";
                    $this->state    = "0";
                }
            } catch (Exception $e) {
                $this->res  = $e->getMessage();
                $this->state = "0";
            }
        } else {

            $request->validate([
                'id_master_aplikasi'    => 'required',
                'id_master_group'       => 'required',
                'id_user'               => 'required',
            ]);

            $data['id_master_aplikasi'] = $request->id_master_aplikasi;
            $data['id_master_group']    = $request->id_master_group;
            $data['id_user']            = $request->id_user;
            $data['status_data']        = 'Aktif';

            $cek = DB::table('trans_user_group')
                ->where('id_master_aplikasi',  $request->id_master_aplikasi)
                ->where('id_master_group',  $request->id_master_group)
                ->where('id_user', $request->id_user)
                ->first();
            if ($cek) {
                $this->res      = "Data Sudah Pernah Tersimpan Pada User";
                $this->state    = "0";
            } else {
                try {
                    $insert = DB::table('trans_user_group')->insert($data);
                    if ($insert) {
                        $this->res      = "Berhasil Menyimpan Data";
                        $this->state    = "1";
                    } else {
                        $this->res      = "Gagal Menyimpan Data";
                        $this->state    = "0";
                    }
                } catch (Exception $e) {
                    $this->res  = $e->getMessage();
                    $this->state = "0";
                }
            }
        }
        $arr = array(
            'state' => $this->state,
            'msg'   => $this->res,
        );

        echo json_encode($arr);
    }

    public function UpdatePassword(Request $request)
    {
        $data = array();
        $master_pengguna = DB::table('users')
            ->where('id_user', $request->id_user)
            ->first();

        $data['password']       = Hash::make($master_pengguna->username);

        try {
            $insert = DB::table('users')->where('id_user', $request->id_user)->update($data);
            if ($insert) {
                $this->res      = "Berhasil Mereset Password";
                $this->state    = "1";
            } else {
                $this->res      = "Gagal Mereset Password";
                $this->state    = "0";
            }
        } catch (Exception $e) {
            $this->res  = $e->getMessage();
            $this->state = "0";
        }

        $arr = array(
            'state' => $this->state,
            'msg'   => $this->res,
        );

        echo json_encode($arr);
    }



    // =============

    function GetMasterGroupPagination(Request $request)
    {
        $data = DB::table('master_group')
            ->select('id_master_group', 'nama_group', 'deskripsi', 'id_master_aplikasi')
            ->where('id_master_aplikasi', $request->id_master_aplikasi)
            ->when($request->search,  fn ($query) => $query->where('nama_group', 'ILIKE', '%' . $request->search . '%'))
            ->orderBy('nama_group', 'asc')
            ->paginate(10);

        $this->data["list"]    = $data;

        return view('master_pengguna.master_group_pagination',  $this->data);
    }

    public function AddMasterGroup($id)
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
                "caption"       => 'Nama Group',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Group. Contoh : Administrator',
                "name"          => 'nama_group',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',

            ],
            [
                "caption"       => 'Deskripsi',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Deskripsi. Contoh : Pengguna Administrator',
                "name"          => 'deskripsi',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',
            ],
        ];

        $this->data['forminput'] = $forminput;
        $this->data['submit'] = 'master_pengguna/insert_master_group';
        $this->data['reload'] = 'master_pengguna/get_master_group' .  $master_aplikasi->id_master_aplikasi;

        return view('master_pengguna.add', $this->data);
    }

    public function EditMasterGroup($id)
    {
        $edit = DB::table('master_group')
            ->where('id_master_group', $id)
            ->first();

        $forminput = [
            [
                "caption"       => 'Id Master Group',
                "type"          => 'hidden',
                "required"      => 'required',
                "placeholder"   => '',
                "name"          => 'id_master_group',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->id_master_group,

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
                "caption"       => 'Nama Group',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Menu. Contoh : Administrator',
                "name"          => 'nama_group',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->nama_group,

            ],
            [
                "caption"       => 'Deskripsi',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Deskripsi. Contoh : Pengguna Administrator',
                "name"          => 'deskripsi',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->deskripsi,
            ],
        ];

        $this->data['forminput'] = $forminput;

        $this->data['submit'] = 'master_pengguna/insert_master_group';
        $this->data['reload'] = 'master_pengguna/get_master_group' .  $edit->id_master_aplikasi;

        return view('master_pengguna.add', $this->data);
    }

    public function InsertMasterGroup(Request $request)
    {

        $data = array();

        $request->validate([
            'id_master_aplikasi'    => 'required',
            'nama_group'            => 'required|max:255',
            'deskripsi'             => 'required',
        ]);

        $cek = DB::table('master_aplikasi')
            ->where('id_master_aplikasi', $request->id_master_aplikasi)
            ->first();

        if (empty($cek)) {
            return Redirect()->route('master_pengguna.index')->with('error', 'Data tidak dapat disimpan');
        }

        if ($request->id_master_menu) {
            $edit = DB::table('master_group')
                ->where('id_master_group', $request->id_master_group)
                ->first();

            if (empty($edit)) {
                return Redirect()->route('master_pengguna.index')->with('error', 'Data tidak dapat disimpan');
            }
        }

        $data['id_master_aplikasi'] = $request->id_master_aplikasi;
        $data['nama_group']          = $request->nama_group;
        $data['deskripsi']          = $request->deskripsi;

        if ($request->id_master_group) {
            try {
                $insert = DB::table('master_group')->where('id_master_group', $request->id_master_group)->update($data);
                if ($insert) {
                    return redirect('/master_pengguna/get_master_group/' . $request->id_master_aplikasi)->with('success', 'Master Menu Berhasil Diubah');
                } else {
                    $notification = array(
                        'message' => 'error ',
                        'alert-type' => 'error'
                    );
                    return Redirect('/master_pengguna/get_master_group/' . $request->id_master_aplikasi)->with($notification);
                }
            } catch (Exception $e) {
                $this->res  = $e->getMessage();
                $this->state = "0";
                return Redirect('/master_pengguna/get_master_group/' . $request->id_master_aplikasi)->with($this->res);
            }
        } else {
            try {
                $insert = DB::table('master_group')->insert($data);
                if ($insert) {
                    return redirect('/master_pengguna/get_master_group/' . $request->id_master_aplikasi)->with('success', 'Master Menu Berhasil Disimpan');
                } else {
                    $notification = array(
                        'message' => 'error ',
                        'alert-type' => 'error'
                    );
                    return Redirect('/master_pengguna/get_master_group/' . $request->id_master_aplikasi)->with($notification);
                }
            } catch (Exception $e) {
                $this->res  = $e->getMessage();
                $this->state = "0";
                return Redirect('/master_pengguna/get_master_menu/' . $request->id_master_aplikasi)->with($this->res);
            }
        }
    }

    public function DeleteMastergroup($id)
    {

        try {
            $delete = DB::table('master_group')->where('id_master_group', $id)->delete();
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

    function GetAksesAplikasi($id)
    {

        $master_group = DB::table('master_group')
            ->join('master_aplikasi', 'master_pengguna.id_master_aplikasi', '=', 'master_aplikasi.id_master_aplikasi')
            ->select('master_aplikasi.id_master_aplikasi', 'master_aplikasi.nama_aplikasi', 'master_pengguna.id_master_group', 'master_pengguna.nama_group')
            ->where('id_master_group', $id)
            ->first();

        $joinmaster_group = DB::table('master_group')
            ->join('group_akses', 'master_pengguna.id_master_group', '=', 'group_akses.id_master_group')
            ->select('master_pengguna.nama_group', 'group_akses.id_master_modul', 'group_akses.akses', 'group_akses.id_group_akses')
            ->where('master_pengguna.id_master_group', $id);


        $aplikasi = DB::table('master_modul')
            ->leftjoinSub($joinmaster_group, 'master_group', function (JoinClause $join) {
                $join->on('master_modul.id_master_modul', '=', 'master_pengguna.id_master_modul');
            })->select('master_modul.id_master_modul', 'master_modul.nama_modul', 'master_pengguna.akses', 'master_pengguna.id_group_akses')
            ->where('id_master_aplikasi', $master_group->id_master_aplikasi)
            ->get();

        // dd($aplikasi);


        $this->data["list"]  = $aplikasi;
        $this->data["master_group"]  = $master_group;

        $this->data['submit'] = 'master_pengguna/insert_akses';
        $this->data['reload'] = 'master_pengguna/get_master_group/' .  $master_group->id_master_aplikasi;



        return view('master_pengguna.group_akses',  $this->data);
    }

    function GetSubMenuPagination(Request $request)
    {
        $data = DB::table('master_modul')
            ->select('id_master_modul', 'nama_modul', 'deskripsi', 'order', 'icon', 'path', 'status_data')
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
        $this->data['submit'] = 'insert_sub_menu';
        $this->data['reload'] = 'get_submaster_menu/' .  $master_menu->id_master_menu;

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
        $this->data['submit'] = 'insert_sub_menu';
        $this->data['reload'] = 'get_submaster_menu/' .  $master_modul->id_master_menu;

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
            return redirect('/get_submaster_menu/' . $request->id_master_menu)->with('error', 'Data tidak dapat disimpan');
        }

        if ($request->id_master_modul) {
            $edit = DB::table('master_modul')
                ->where('id_master_modul', $request->id_master_modul)
                ->first();

            if (empty($edit)) {
                return redirect('/get_master_menu/' . $request->id_master_aplikasi)->with('error', 'Data tidak dapat disimpan');
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
                    return redirect('/get_submaster_menu/' . $request->id_master_menu)->with('success', 'Master Menu Modul Berhasil Diubah');
                } else {
                    $notification = array(
                        'message' => 'error ',
                        'alert-type' => 'error'
                    );
                    return redirect('/get_submaster_menu/' . $request->id_master_menu)->with($notification);
                }
            } catch (Exception $e) {
                $this->res  = $e->getMessage();
                $this->state = "0";
                return redirect('/get_submaster_menu/' . $request->id_master_menu)->with($this->res);
            }
        } else {

            try {
                $insert = DB::table('master_modul')->insert($data);
                if ($insert) {
                    return redirect('/get_submaster_menu/' . $request->id_master_menu)->with('success', 'Master Menu Modul Berhasil Disimpan');
                } else {
                    $notification = array(
                        'message' => 'error ',
                        'alert-type' => 'error'
                    );
                    return redirect('/get_submaster_menu/' . $request->id_master_menu)->with($notification);
                }
            } catch (Exception $e) {
                $this->res  = $e->getMessage();
                $this->state = "0";
                return redirect('/get_submaster_menu/' . $request->id_master_menu)->with($this->res);
            }
        }
    }
}
