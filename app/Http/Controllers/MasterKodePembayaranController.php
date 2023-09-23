<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Controllers\MasterDataController;
use App\Models\MasterKodePembayaran;
use Illuminate\Http\Request;
// use Illuminate\Support\Arr;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Exception;

// use DB;

class MasterKodePembayaranController extends Controller
{
    public $search = '';

    public function __construct()
    {

        $this->middleware('auth');

        $this->data = array(
            'msg_main'      => '',
            'msg_detail'    => '',
            'menu_app'      => '',
            'add'        => 'master_kode_pembayaran/add_master_kode_pembayaran',
            'submit'        => 'master_kode_pembayaran/insert_master_kode_pembayaran',
            'reload'        => 'master_kode_pembayaran',
        );
    }

    function index()
    {
        return view('master_kode_pembayaran.index',  $this->data);
    }

    function GetMasterKodePembayaran(Request $request)
    {

        if ($request->ajax()) {
            $data = DB::connection('akademik')->table('siakad.master_kode_pembayaran')
            ->select('siakad.master_kode_pembayaran.id_kode_pembayaran', 'siakad.master_kode_pembayaran.kode_rekening','siakad.master_kode_pembayaran.nama_rekening', 'siakad.master_kode_pembayaran.nama_program_studi') 
                ->when($request->search,  fn ($query) => $query->where('siakad.master_kode_pembayaran.kode_rekening', 'ILIKE', '%' . $request->search . '%')
                ->orwhere('siakad.master_kode_pembayaran.nama_rekening', 'ILIKE', '%' . $request->search . '%'))
                ->orderBy('siakad.master_kode_pembayaran.kode_rekening', 'asc')
                ->paginate(10);

            $this->data["list"]    = $data;
            // dd($data);

            return view('master_kode_pembayaran.master_kode_pembayaran_pagination',  $this->data)->render();
        }
    }

    public function AddMasterKodePembayaran()
    {

        $program_studi        = (new MasterDataController)->GetProgramStudi();
        // $jenis_matakuliah    = (new MasterDataController)->GetJenisMatakuliah();

        $forminput = [
            [
                "caption"       => 'Kode Rekening',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Kode Matakuliah. Contoh : 32012',
                "name"          => 'kode_rekening',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Nama Rekening',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Matakuliah. Contoh : UKT',
                "name"          => 'nama_rekening',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true

            ],
            [
                "caption"       => 'Program Studi Matakuliah',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Program Studi ',
                "name"          => 'id_prodi',
                "class"         => '',
                "property"      => '',
                "data"          => $program_studi,
                "value"         => '',
                "show"          => true
            ]
        ];

        // \var_dump(\json_encode($forminput));exit();

        $this->data['forminput']     = $forminput;

        return view('master_kode_pembayaran.add', $this->data);
    }

    public function EditMasterKodePembayaran($request)
    {
        // $agama = DB::connection('akademik')->table("siakad.master_agama")
        $edit =  DB::connection('akademik')->table('siakad.master_kode_pembayaran')
            ->where('id_kode_pembayaran', $request)
            ->first();

        $program_studi        = (new MasterDataController)->GetProgramStudi();

        $forminput = [
            [
                "caption"       => 'ID Kode Pembayaran',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => '',
                "name"          => 'id_kode_pembayaran',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->id_kode_pembayaran,
                "show"          => false
            ], [
                "caption"       => 'Kode Rekening',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Kode Matakuliah. Contoh : 32012',
                "name"          => 'kode_rekening',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->kode_rekening,
                "show"          => true
            ],
            [
                "caption"       => 'Nama Rekening',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Matakuliah. Contoh : UKT',
                "name"          => 'nama_rekening',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->nama_rekening,
                "show"          => true

            ],
            [
                "caption"       => 'Program Studi Matakuliah',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Program Studi ',
                "name"          => 'id_prodi',
                "class"         => '',
                "property"      => '',
                "data"          => $program_studi,
                "value"         => $edit->id_prodi,
                "show"          => true
            ],
        ];

        $this->data['forminput']     = $forminput;

        return view('master_kode_pembayaran.add', $this->data);
    }

    public function InsertMasterKodePembayaran(Request $request)
    {
        // $data = array();
        // dd($request);

        $request->validate([
            'kode_rekening'     => 'required',
            'nama_rekening'     => 'required',
            'id_prodi'             => 'required',
        ]);

        // $post= array();


        if ($request->id_kode_pembayaran) {
            $edit = DB::connection('akademik')->table('siakad.master_kode_pembayaran')
                ->where('id_kode_pembayaran', $request->id_kode_pembayaran)
                ->first();

            if (empty($edit)) {
                return Redirect()->route('master_kode_pembayaran.index')->with('error', 'Data tidak dapat disimpan');
            }
        }
        // dd($request);
        
        $data = $request->input();

        $request['id_prodi'] = $request->id_prodi;
        $program_studi        = (new MasterDataController)->GetProgramStudi($request);

        // dd($program_studi);
        $data['nama_program_studi'] = $program_studi['nama_program_studi'];
        unset($data['_token']);

        if ($request->id_kode_pembayaran) {
            try {
                $insert = DB::connection('akademik')->table('siakad.master_kode_pembayaran')->where('id_kode_pembayaran', $request->id_kode_pembayaran)->update($data);
                return Redirect()->route('master_kode_pembayaran.index')->with('success', 'Master Kode Pembayaran Berhasil Diubah');
            } catch (Exception $e) {
                $this->res  = $e->getMessage();
                $this->state = "0";
                dd($this->res);
                return Redirect('master_kode_pembayaran')->with($this->res);
            }
        } else {
            try {
                $insert = DB::connection('akademik')->table('siakad.master_kode_pembayaran')->insert($data);
                return Redirect()->route('master_kode_pembayaran.index')->with('success', 'Master Kode Pembayaran Berhasil Disimpan');
            } catch (Exception $e) {
                // \var_dump( $e->getMessage());exit();
                $this->res  = $e->getMessage();
                $this->state = "0";
                return Redirect()->route('master_kode_pembayaran.add_master_kode_pembayaran')->with('error', 'Master Kode Pembayaran Gagal Disimpan Hubungi Administrator');
            }
        }
    }

    public function DeleteMasterKodePembayaran($id)
    {
        try {
            $delete = DB::connection('akademik')->table('siakad.master_kode_pembayaran')->where('id_kode_pembayaran', $id)->delete();
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
