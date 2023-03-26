<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\MasterAplikasi;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Exception;
// use DB;

class MasterAplikasiController extends Controller
{
    public $search = '';

    public function __construct()
    {
        $this->middleware('auth');

        $this->data = array(
            'msg_main'      => '',
            'msg_detail'    => '',
            'menu_app'      => '',
            'submit'        => 'insert_master_aplikasi',
            'reload'        => 'master_aplikasi',
        );
    }

    function index()
    {
        return view('master_aplikasi.index',  $this->data);
    }

    function GetMasterAplikasi(Request $request)
    {
        if ($request->ajax()) {
            $list   = ["list" => MasterAplikasi::when($request->search,  fn ($query) => $query->where('nama_aplikasi', 'ILIKE', '%' . $request->search . '%'))
                ->paginate(10)];
            return view('master_aplikasi.master_aplikasi_pagination', $list)->render();
        }
    }

    public function AddMasterAplikasi()
    {
        $status = array(
            array('id' => 'aktif', 'value' => 'aktif'),
            array('id' => 'maintenance', 'value' => 'Maintenance')
        );

        $forminput = [
            [
                "caption"       => 'Nama Aplikasi',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Aplikasi. Contoh : SSO',
                "name"          => 'nama_aplikasi',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',

            ],
            [
                "caption"       => 'Deskripsi',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Deskripsi. Contoh : Single Sign On',
                "name"          => 'deskripsi',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',
            ],
            [
                "caption"       => 'Versi Aplikasi',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Versi Aplikasi. Contoh : 2.0',
                "name"          => 'versi_aplikasi',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',
            ],
            [
                "caption"       => 'Tanggal Versi',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Tanggal Versi. Contoh : 31-01-2022',
                "name"          => 'tgl_version',
                "class"         => 'date',
                "property"      => '',
                "data"          => '',
                "value"         => '',
            ],
            [
                "caption"       => 'Url',
                "type"          => 'url',
                "required"      => 'required',
                "placeholder"   => 'Masukan Url. Contoh : Https://sso-farmasi.unissula.ac.id',
                "name"          => 'url',
                "class"         => '',
                "property"      => '',
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
            [
                "caption"       => 'Logo Aplikasi',
                "type"          => 'upload',
                "required"      => 'required',
                "placeholder"   => '* File format JPG,JPEG,PNG Max 1 Mb',
                "name"          => 'image',
                "class"         => '',
                "property"      => 'accept=".jpg,.png,.jpeg"',
                "data"          => '',
                "value"         => '',
            ]
        ];

        $this->data['forminput'] = $forminput;

        return view('master_aplikasi.add', $this->data);
    }

    public function EditMasterAplikasi($id)
    {
        $edit = DB::table('master_aplikasi')
            ->where('id_master_aplikasi', $id)
            ->first();

        $status = array(
            array('id' => 'aktif', 'value' => 'aktif'),
            array('id' => 'maintenance', 'value' => 'Maintenance')
        );

        $forminput = [
            [
                "caption"       => 'Id Master Aplikasi',
                "type"          => 'hidden',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Aplikasi. Contoh : SSO',
                "name"          => 'id_master_aplikasi',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         =>  $edit->id_master_aplikasi,
            ],
            [
                "caption"       => 'Nama Aplikasi',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Aplikasi. Contoh : SSO',
                "name"          => 'nama_aplikasi',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->nama_aplikasi,
            ],
            [
                "caption"       => 'Deskripsi',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Deskripsi. Contoh : Single Sign On',
                "name"          => 'deskripsi',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->deskripsi,
            ],
            [
                "caption"       => 'Versi Aplikasi',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Versi Aplikasi. Contoh : 2.0',
                "name"          => 'versi_aplikasi',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->versi_aplikasi,
            ],
            [
                "caption"       => 'Tanggal Versi',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Tanggal Versi. Contoh : 31-01-2022',
                "name"          => 'tgl_version',
                "class"         => 'date',
                "property"      => '',
                "data"          => '',
                "value"         => Carbon::createFromFormat('Y-m-d', $edit->tgl_version)->format('d-m-Y'),
            ],
            [
                "caption"       => 'Url',
                "type"          => 'url',
                "required"      => 'required',
                "placeholder"   => 'Masukan Url. Contoh : Https://sso-farmasi.unissula.ac.id',
                "name"          => 'url',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->url,
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
                "value"         => $edit->status_data,
            ],
            [
                "caption"       => 'Logo Aplikasi',
                "type"          => 'upload',
                "required"      => '',
                "placeholder"   => '* File format JPG,JPEG,PNG Max 1 Mb',
                "name"          => 'image',
                "class"         => '',
                "property"      => 'accept=".jpg,.png,.jpeg"',
                "data"          => '',
                "value"         => $edit->image,
            ]
        ];

        $this->data['forminput'] = $forminput;

        return view('master_aplikasi.add', $this->data);
    }

    public function InsertMasterAplikasi(Request $request)
    {
        $data = array();

        $request->validate([
            'nama_aplikasi'     => 'required',
            'deskripsi'         => 'required|max:255',
            'versi_aplikasi'    => 'required',
            'status_data'       => 'required',
            'tgl_version'       => 'required|date',
            'url'               => 'required',
            'image'             => 'image|mimes:jpeg,png,jpg,gif,svg|max:1024',
        ]);

        if ($request->id_master_aplikasi) {
            $edit = DB::table('master_aplikasi')
                ->where('id_master_aplikasi', $request->id_master_aplikasi)
                ->first();

            if (empty($edit)) {
                return Redirect()->route('master_aplikasi.index')->with('error', 'Data tidak dapat disimpan');
            }
        }

        if ($request->image) {
            $imageName = time() . '.' . $request->image->extension();
            $request->image->move(public_path('images'), $imageName);
            $data['image']  = $imageName;
        }

        $data['nama_aplikasi']  = $request->nama_aplikasi;
        $data['deskripsi']      = $request->deskripsi;
        $data['versi_aplikasi'] = $request->versi_aplikasi;
        $data['status_data']    = $request->status_data;
        $data['tgl_version']    = Carbon::createFromFormat('d-m-Y', $request->tgl_version)
            ->format('Y-m-d');
        $data['url']            = $request->url;

        if ($request->id_master_aplikasi) {
            try {
                $insert = DB::table('master_aplikasi')->where('id_master_aplikasi', $request->id_master_aplikasi)->update($data);
                return Redirect()->route('master_aplikasi.index')->with('success', 'Master Aplikasi Berhasil Diubah');
            } catch (Exception $e) {
                $this->res  = $e->getMessage();
                $this->state = "0";
                return Redirect()->route('master_aplikasi')->with($this->res);
            }
        } else {
            try {
                $insert = DB::table('master_aplikasi')->insert($data);
                return Redirect()->route('master_aplikasi.index')->with('success', 'Master Aplikasi Berhasil Disimpan');
            } catch (Exception $e) {
                $this->res  = $e->getMessage();
                $this->state = "0";
                return Redirect()->route('master_aplikasi')->with($this->res);
            }
        }
    }

    public function DeleteMasterAplikasi($id)
    {
        try {
            $delete = DB::table('master_aplikasi')->where('id_master_aplikasi', $id)->delete();
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
