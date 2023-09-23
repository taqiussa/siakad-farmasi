<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Controllers\MasterDataController;
use App\Models\MasterMatakuliah;
use Illuminate\Http\Request;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Exception;

// use DB;

class MasterMatakuliahController extends Controller
{
    public $search = '';

    public function __construct()
    {

        $this->middleware('auth');

        $this->data = array(
            'msg_main'      => '',
            'msg_detail'    => '',
            'menu_app'      => '',
            'submit'        => 'master_matakuliah/insert_master_matakuliah',
            'reload'        => 'master_matakuliah',
        );
    }

    function index()
    {
        return view('master_matakuliah.index',  $this->data);
    }

    function GetMasterMatakuliah(Request $request)
    {

        if ($request->ajax()) {
            $data = DB::connection('akademik')->table('siakad.master_matakuliah')
            ->select('siakad.master_matakuliah.id_matkul', 'siakad.master_matakuliah.kode_mata_kuliah','siakad.master_matakuliah.nama_mata_kuliah', 'siakad.master_matakuliah.nama_program_studi',  'siakad.master_matakuliah.sks_mata_kuliah', 'siakad.master_matakuliah.sks_tatap_muka', 'siakad.master_matakuliah.sks_praktek', 'siakad.master_matakuliah.sks_praktek_lapangan', 'siakad.master_matakuliah.sks_simulasi', 'siakad.master_matakuliah.metode_kuliah', 'siakad.master_jenis_matakuliah.nama_jenis_mata_kuliah') 
            ->join('siakad.master_jenis_matakuliah','siakad.master_matakuliah.id_jenis_mata_kuliah','=','siakad.master_jenis_matakuliah.id_jenis_mata_kuliah')
                ->when($request->search,  fn ($query) => $query->where('siakad.master_matakuliah.kode_mata_kuliah', 'ILIKE', '%' . $request->search . '%')
                ->orwhere('siakad.master_matakuliah.nama_mata_kuliah', 'ILIKE', '%' . $request->search . '%'))
                ->orderBy('siakad.master_matakuliah.kode_mata_kuliah', 'asc')
                ->paginate(10);

            $this->data["list"]    = $data;
            // dd($data);

            return view('master_matakuliah.master_matakuliah_pagination',  $this->data)->render();
        }
    }

    public function AddMasterMatakuliah()
    {

        $program_studi        = (new MasterDataController)->GetProgramStudi();
        $jenis_matakuliah    = (new MasterDataController)->GetJenisMatakuliah();

        $forminput = [
            [
                "caption"       => 'Kode Matakuliah',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Kode Matakuliah. Contoh : FF342102',
                "name"          => 'kode_mata_kuliah',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Nama Matakuliah',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Matakuliah. Contoh : Berfikir Kritis',
                "name"          => 'nama_mata_kuliah',
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
            ],
            [
                "caption"       => 'Jenis Mata Kuliah',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Jenis Matakuliah',
                "name"          => 'id_jenis_mata_kuliah',
                "class"         => '',
                "property"      => '',
                "data"          => $jenis_matakuliah,
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Bobot SKS Teori',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan SKS Tatap Muka. Contoh: 2',
                "name"          => 'sks_tatap_muka',
                "class"         => 'numberonly skstotal',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Bobot SKS Praktikum',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan SKS Praktikum. Contoh: 2',
                "name"          => 'sks_praktek',
                "class"         => 'numberonly skstotal',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Bobot SKS Praktikum lapangan',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan SKS Praktikum Lapangan. Contoh: 2',
                "name"          => 'sks_praktek_lapangan',
                "class"         => 'numberonly skstotal',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Bobot SKS Simulasi',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan SKS Simulasi. Contoh: 2',
                "name"          => 'sks_simulasi',
                "class"         => 'numberonly skstotal',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Bobot SKS Total',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => '( sks Tatap Muka + sks Praktikum + sks Praktek Lapangan + sks Simulasi )',
                "name"          => 'sks_mata_kuliah',
                "class"         => 'numberonly',
                "property"      => 'readonly',
                "data"          => '',
                "value"         => 0,
                "show"          => true
            ],
            [
                "caption"       => 'Metode Pembelajaran',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => 'Masukan Metode Pembelajaran. Contoh: SGD',
                "name"          => 'metode_kuliah',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Tanggal Mulai Efektif',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => 'Masukan Tanggal Mulai Efektif. Contoh : dd-mm-yyyy',
                "name"          => 'tanggal_mulai_efektif',
                "class"         => 'date',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Tanggal Akhir Efektif',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => 'Masukan Tanggal Akhir Efektif. Contoh : dd-mm-yyyy',
                "name"          => 'tanggal_akhir_efektif',
                "class"         => 'date',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ]
        ];

        // \var_dump(\json_encode($forminput));exit();

        $this->data['forminput']     = $forminput;

        return view('master_matakuliah.add', $this->data);
    }

    public function EditMasterMatakuliah($request)
    {
        // $agama = DB::connection('akademik')->table("siakad.master_agama")
        $edit =  DB::connection('akademik')->table('siakad.master_matakuliah')
            ->where('id_matkul', $request)
            ->first();

        $program_studi        = (new MasterDataController)->GetProgramStudi();
        $jenis_matakuliah    = (new MasterDataController)->GetJenisMatakuliah();

        $forminput = [
            [
                "caption"       => 'ID Matakuliah',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => '',
                "name"          => 'id_matkul',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->id_matkul,
                "show"          => false
            ], [
                "caption"       => 'Kode Matakuliah',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Kode Matakuliah. Contoh : FF342102',
                "name"          => 'kode_mata_kuliah',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->kode_mata_kuliah,
                "show"          => true
            ],
            [
                "caption"       => 'Nama Matakuliah',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Matakuliah. Contoh : Berfikir Kritis',
                "name"          => 'nama_mata_kuliah',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->nama_mata_kuliah,
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
            [
                "caption"       => 'Jenis Mata Kuliah',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Jenis Matakuliah',
                "name"          => 'id_jenis_mata_kuliah',
                "class"         => '',
                "property"      => '',
                "data"          => $jenis_matakuliah,
                "value"         => $edit->id_jenis_mata_kuliah,
                "show"          => true
            ],
            [
                "caption"       => 'Bobot SKS Teori',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan SKS Tatap Muka. Contoh: 2',
                "name"          => 'sks_tatap_muka',
                "class"         => 'numberonly skstotal',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->sks_tatap_muka,
                "show"          => true
            ],
            [
                "caption"       => 'Bobot SKS Praktikum',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan SKS Praktikum. Contoh: 2',
                "name"          => 'sks_praktek',
                "class"         => 'numberonly skstotal',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->sks_praktek,
                "show"          => true
            ],
            [
                "caption"       => 'Bobot SKS Praktikum lapangan',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan SKS Praktikum Lapangan. Contoh: 2',
                "name"          => 'sks_praktek_lapangan',
                "class"         => 'numberonly skstotal',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->sks_praktek_lapangan,
                "show"          => true
            ],
            [
                "caption"       => 'Bobot SKS Simulasi',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan SKS Simulasi. Contoh: 2',
                "name"          => 'sks_simulasi',
                "class"         => 'numberonly skstotal',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->sks_simulasi,
                "show"          => true
            ],
            [
                "caption"       => 'Bobot SKS Total',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => '( sks Tatap Muka + sks Praktikum + sks Praktek Lapangan + sks Simulasi )',
                "name"          => 'sks_mata_kuliah',
                "class"         => 'numberonly',
                "property"      => 'readonly',
                "data"          => '',
                "value"         => $edit->sks_mata_kuliah,
                "show"          => true
            ],
            [
                "caption"       => 'Metode Pembelajaran',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => 'Masukan Metode Pembelajaran. Contoh: SGD',
                "name"          => 'metode_kuliah',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->metode_kuliah,
                "show"          => true
            ],
            [
                "caption"       => 'Tanggal Mulai Efektif',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => 'Masukan Tanggal Mulai Efektif. Contoh : dd-mm-yyyy',
                "name"          => 'tanggal_mulai_efektif',
                "class"         => 'date',
                "property"      => '',
                "data"          => '',
                "value"         => Carbon::createFromFormat('Y-m-d', $edit->tanggal_mulai_efektif)->format('d-m-Y'),
                "show"          => true
            ],
            [
                "caption"       => 'Tanggal Akhir Efektif',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => 'Masukan Tanggal Akhir Efektif. Contoh : dd-mm-yyyy',
                "name"          => 'tanggal_akhir_efektif',
                "class"         => 'date',
                "property"      => '',
                "data"          => '',
                "value"         => Carbon::createFromFormat('Y-m-d', $edit->tanggal_akhir_efektif)->format('d-m-Y'),
                "show"          => true
            ]
        ];

        $this->data['forminput']     = $forminput;

        return view('master_matakuliah.add', $this->data);
    }

    public function InsertMasterMatakuliah(Request $request)
    {
        // $data = array();
        // dd($request);

        $request->validate([
            'kode_mata_kuliah'     => 'required',
            'nama_mata_kuliah'     => 'required',
            'id_prodi'             => 'required',
            'id_jenis_mata_kuliah' => 'required',
            'sks_tatap_muka'       => 'required',
            'sks_praktek'          => 'required',
            'sks_praktek_lapangan' => 'required',
            'sks_simulasi'         => 'required'
        ]);

        // $post= array();


        if ($request->id_matkul) {
            $edit = DB::connection('akademik')->table('siakad.master_matakuliah')
                ->where('id_matkul', $request->id_matkul)
                ->first();

            if (empty($edit)) {
                return Redirect()->route('master_mahasiswa.index')->with('error', 'Data tidak dapat disimpan');
            }
        }
        // dd($request);
        $request['tanggal_mulai_efektif']  = Carbon::createFromFormat('d-m-Y', $request->tanggal_mulai_efektif)
            ->format('Y-m-d');
        $request['tanggal_akhir_efektif']  = Carbon::createFromFormat('d-m-Y', $request->tanggal_akhir_efektif)
            ->format('Y-m-d');

        $data = $request->input();

        $request['id_prodi'] = $request->id_prodi;
        $program_studi        = (new MasterDataController)->GetProgramStudi($request);

        // dd($program_studi);
        $data['nama_program_studi'] = $program_studi['nama_program_studi'];
        unset($data['_token']);

        if ($request->id_matkul) {
            try {
                $insert = DB::connection('akademik')->table('siakad.master_matakuliah')->where('id_matkul', $request->id_matkul)->update($data);
                return Redirect()->route('master_matakuliah.index')->with('success', 'Master Matakuliah Berhasil Diubah');
            } catch (Exception $e) {
                $this->res  = $e->getMessage();
                $this->state = "0";
                dd($this->res);
                return Redirect('master_matakuliah')->with($this->res);
            }
        } else {
            try {
                $insert = DB::connection('akademik')->table('siakad.master_matakuliah')->insert($data);
                return Redirect()->route('master_matakuliah.index')->with('success', 'Master Matakuliah Berhasil Disimpan');
            } catch (Exception $e) {
                // \var_dump( $e->getMessage());exit();
                $this->res  = $e->getMessage();
                $this->state = "0";
                return Redirect()->route('master_matakuliah.add_master_matakuliah')->with('error', 'Master Matakuliah Gagal Disimpan Hubungi Administrator');
            }
        }
    }

    public function DeleteMasterMatakuliah($id)
    {
        try {
            $delete = DB::connection('akademik')->table('siakad.master_matakuliah')->where('id_matkul', $id)->delete();
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
