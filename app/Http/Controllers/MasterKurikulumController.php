<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Controllers\MasterDataController;
use App\Models\MasterKurikulum;
use Illuminate\Http\Request;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Exception;

// use DB;

class MasterKurikulumController extends Controller
{
    public $search = '';

    public function __construct()
    {

        $this->middleware('auth');

        $this->data = array(
            'msg_main'      => '',
            'msg_detail'    => '',
            'menu_app'      => '',
            'submit'        => 'master_kurikulum/insert_master_kurikulum',
            'submit_matkul' => 'master_kurikulum/insert_matakuliah_kurikulum',
            'reload'        => 'master_kurikulum',
        );
    }

    function index()
    {
        return view('master_kurikulum.index',  $this->data);
    }

    function GetMasterKurikulum(Request $request)
    {

        if ($request->ajax()) {
            $data = DB::connection('akademik')->table('siakad.kurikulum')
                ->select('siakad.kurikulum.id_kurikulum', 'siakad.kurikulum.nama_kurikulum', 'siakad.kurikulum.jumlah_sks_lulus', 'siakad.kurikulum.jumlah_sks_wajib',  'siakad.kurikulum.jumlah_sks_pilihan', 'siakad.master_prodi.nama_jenjang_pendidikan', 'siakad.master_prodi.nama_program_studi', 'siakad.master_tahun_akademik.nama_semester')
                ->join('siakad.master_prodi', 'siakad.kurikulum.id_prodi', '=', 'siakad.master_prodi.id_prodi')
                ->join('siakad.master_tahun_akademik', 'siakad.kurikulum.id_tahun_akademik', '=', 'siakad.master_tahun_akademik.id_tahun_akademik')
                ->when($request->search,  fn ($query) => $query->where('siakad.kurikulum.nama_kurikulum', 'ILIKE', '%' . $request->search . '%'))
                ->orderBy('siakad.kurikulum.nama_kurikulum', 'asc')
                ->paginate(10);

            $this->data["list"]    = $data;
            // dd($data);

            return view('master_kurikulum.master_kurikulum_pagination',  $this->data)->render();
        }
    }

    public function AddMasterKurikulum()
    {

        $program_studi        = (new MasterDataController)->GetProgramStudi();
        $tahun_akademik       = (new MasterDataController)->GetTahunAkademik();

        $forminput = [
            [
                "caption"       => 'Nama Kurikulum',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Kurikulum. Contoh : Kurikulum 2021',
                "name"          => 'nama_kurikulum',
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
                "caption"       => 'Mulai Berlaku',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Tahun Akademik',
                "name"          => 'id_tahun_akademik',
                "class"         => '',
                "property"      => '',
                "data"          => $tahun_akademik,
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Jumlah Bobot Mata Kuliah Wajib',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan SKS Mata Kuliah Wajib. Contoh: 2',
                "name"          => 'jumlah_sks_wajib',
                "class"         => 'numberonly skstotal',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Jumlah Bobot Mata Kuliah Pilihan',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan SKS Mata Kuliah Pilihan. Contoh: 2',
                "name"          => 'jumlah_sks_pilihan',
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
                "placeholder"   => '',
                "name"          => 'jumlah_sks_lulus',
                "class"         => 'numberonly',
                "property"      => 'readonly',
                "data"          => '',
                "value"         => 0,
                "show"          => true
            ]
        ];

        // \var_dump(\json_encode($forminput));exit();

        $this->data['forminput']     = $forminput;

        return view('master_kurikulum.add', $this->data);
    }

    public function EditMasterKurikulum($request)
    {
        // $agama = DB::connection('akademik')->table("siakad.master_agama")
        $edit =  DB::connection('akademik')->table('siakad.kurikulum')
            ->where('id_kurikulum', $request)
            ->first();

        $program_studi        = (new MasterDataController)->GetProgramStudi();
        $tahun_akademik       = (new MasterDataController)->GetTahunAkademik();

        $forminput = [
            [
                "caption"       => 'ID Kurikulum',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Kurikulum. Contoh : Kurikulum 2021',
                "name"          => 'id_kurikulum',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->id_kurikulum,
                "show"          => false
            ],
            [
                "caption"       => 'Nama Kurikulum',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Kurikulum. Contoh : Kurikulum 2021',
                "name"          => 'nama_kurikulum',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->nama_kurikulum,
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
                "caption"       => 'Mulai Berlaku',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Tahun Akademik',
                "name"          => 'id_tahun_akademik',
                "class"         => '',
                "property"      => '',
                "data"          => $tahun_akademik,
                "value"         => $edit->id_tahun_akademik,
                "show"          => true
            ],
            [
                "caption"       => 'Jumlah Bobot Mata Kuliah Wajib',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan SKS Mata Kuliah Wajib. Contoh: 2',
                "name"          => 'jumlah_sks_wajib',
                "class"         => 'numberonly skstotal',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->jumlah_sks_wajib,
                "show"          => true
            ],
            [
                "caption"       => 'Jumlah Bobot Mata Kuliah Pilihan',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan SKS Mata Kuliah Pilihan. Contoh: 2',
                "name"          => 'jumlah_sks_pilihan',
                "class"         => 'numberonly skstotal',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->jumlah_sks_wajib,
                "show"          => true
            ],
            [
                "caption"       => 'Bobot SKS Total',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => '',
                "name"          => 'jumlah_sks_lulus',
                "class"         => 'numberonly',
                "property"      => 'readonly',
                "data"          => '',
                "value"         => $edit->jumlah_sks_lulus,
                "show"          => true
            ]
        ];
        $this->data['forminput']     = $forminput;

        return view('master_kurikulum.add', $this->data);
    }

    public function InsertMasterKurikulum(Request $request)
    {
        // $data = array();
        // dd($request);

        $request->validate([
            'nama_kurikulum'     => 'required',
            'id_prodi'           => 'required',
            'id_prodi'           => 'required',
            'id_tahun_akademik'  => 'required',
            'jumlah_sks_wajib'   => 'required',
            'jumlah_sks_pilihan' => 'required',
            'jumlah_sks_lulus'   => 'required'
        ]);

        // $post= array();


        if ($request->id_kurikulum) {
            $edit = DB::connection('akademik')->table('siakad.kurikulum')
                ->where('id_kurikulum', $request->id_kurikulum)
                ->first();

            if (empty($edit)) {
                return Redirect()->route('master_kurikulum.index')->with('error', 'Data tidak dapat disimpan');
            }
        }


        $data = $request->input();

        $request['id_prodi'] = $request->id_prodi;
        $program_studi       = (new MasterDataController)->GetProgramStudi($request);

        $request['id_tahun_akademik'] = $request->id_tahun_akademik;
        $tahun_akademik               = (new MasterDataController)->GetTahunAkademik($request);

        $data['id_semester'] = $tahun_akademik['id_semester'];
        // dd($program_studi);
        $data['nama_program_studi'] = $program_studi['nama_program_studi'];

        unset($data['_token']);
        // dd($data);

        if ($request->id_kurikulum) {
            try {
                $insert = DB::connection('akademik')->table('siakad.kurikulum')->where('id_kurikulum', $request->id_kurikulum)->update($data);
                return Redirect()->route('master_kurikulum.index')->with('success', 'Master Kurikulum Berhasil Diubah');
            } catch (Exception $e) {
                $this->res  = $e->getMessage();
                $this->state = "0";
                dd($this->res);
                return Redirect('master_kurikulum')->with($this->res);
            }
        } else {
            try {
                $insert = DB::connection('akademik')->table('siakad.kurikulum')->insert($data);
                return Redirect()->route('master_kurikulum.index')->with('success', 'Master Kurikulum Berhasil Disimpan');
            } catch (Exception $e) {
                $this->res  = $e->getMessage();
                $this->state = "0";
                return Redirect()->route('master_kurikulum.add_master_kurikulum')->with('error', 'Master Kurikulum Gagal Disimpan Hubungi Administrator');
            }
        }
    }

    public function DeleteMasterKurikulum($id)
    {
        try {
            $delete = DB::connection('akademik')->table('siakad.kurikulum')->where('id_kurikulum', $id)->delete();
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

    function DetailKurikulum($id)
    {

        $data = DB::connection('akademik')->table('siakad.kurikulum')
            ->join('siakad.master_tahun_akademik', 'siakad.kurikulum.id_tahun_akademik', '=', 'siakad.master_tahun_akademik.id_tahun_akademik')
            ->where('id_kurikulum', $id)
            ->first();

        $this->data["data"]  = $data;

        return view('master_kurikulum.detail_kurikulum',  $this->data);
    }

    function GetMatakuliahKurikulumPagination(Request $request)
    {
        if ($request->ajax()) {
            $data = DB::connection('akademik')->table('siakad.matakuliah_kurikulum')
                ->select('matakuliah_kurikulum.id_matakuliah_kurikulum','master_matakuliah.kode_mata_kuliah', 'master_matakuliah.nama_mata_kuliah', 'master_matakuliah.sks_mata_kuliah', 'master_matakuliah.sks_tatap_muka', 'master_matakuliah.sks_praktek', 'master_matakuliah.sks_praktek_lapangan', 'master_matakuliah.sks_simulasi', 'siakad.matakuliah_kurikulum.semester', 'siakad.matakuliah_kurikulum.apakah_wajib')
                ->join('siakad.master_matakuliah', 'siakad.matakuliah_kurikulum.id_matkul', '=', 'siakad.master_matakuliah.id_matkul')
                ->where('siakad.matakuliah_kurikulum.id_kurikulum', $request->id_kurikulum)
                ->when($request->search,  fn ($query) => $query->where('siakad.master_matakuliah.kode_mata_kuliah', 'ILIKE', '%' . $request->search . '%')
                    ->orwhere('siakad.master_matakuliah.nama_mata_kuliah', 'ILIKE', '%' . $request->search . '%'))
                ->orderBy('master_matakuliah.nama_mata_kuliah', 'asc')
                ->paginate(100);

            $this->data["list"]    = $data;

            // dd($this->data);
            return view('master_kurikulum.detail_matakuliah_kurikulum_pagination',  $this->data);
        }
    }

    function AddMatakuliahKurikulum(Request $request)
    {
        $kurikulum =  DB::connection('akademik')->table('siakad.kurikulum')
            ->where('id_kurikulum', $request->id_kurikulum)
            ->first();
        // dd($kurikulum);
        $post['id_prodi'] =  $kurikulum->id_prodi;
        $request        = request()->merge($post);

        $matakuliah        = (new MasterDataController)->GetMatakuliah($request);

        // \dd($matakuliah);
        $status = array(
            array('id' => '1', 'value' => 'Wajib'),
            array('id' => '0', 'value' => 'Pilihan')
        );

        $semester = array(
            array('id' => '1', 'value' => '1'),
            array('id' => '2', 'value' => '2'),
            array('id' => '3', 'value' => '3'),
            array('id' => '4', 'value' => '4'),
            array('id' => '5', 'value' => '5'),
            array('id' => '6', 'value' => '6'),
            array('id' => '7', 'value' => '7')
        );
        // dd( $matakuliah   );
        $forminput = [
            [
                "caption"       => 'ID Kurikulum',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => '',
                "name"          => 'id_kurikulum',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $request->id_kurikulum,
                "show"          => false

            ],
            [
                "caption"       => 'Pilih Matakuliah',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Matakuliah',
                "name"          => 'id_matkul',
                "class"         => '',
                "property"      => '',
                "data"          => $matakuliah,
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Semester',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Masukan Semester',
                "name"          => 'semester',
                "class"         => '',
                "property"      => '',
                "data"          => $semester,
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Pilih Status',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Status',
                "name"          => 'apakah_wajib',
                "class"         => '',
                "property"      => '',
                "data"          => $status,
                "value"         => 1,
                "show"          => true
            ],
        ];

        $this->data['forminput'] = $forminput;
        $this->data['submit'] = 'master_kurikulum/insert_matakuliah_kurikulum';
        $this->data['reload'] = 'master_kurikulum';

        return view('master_kurikulum.add_modal', $this->data);
    }


    public function InsertMatakuliahKurikulum(Request $request)
    {
        // $data = array();
        // dd($request);

        $request->validate([
            'id_kurikulum' => 'required',
            'id_matkul'    => 'required',
            'semester'     => 'required',
            'apakah_wajib' => 'required',
        ]);

        // $post= array();


        if ($request->id_kurikulum) {
            $kurikulum = DB::connection('akademik')->table('siakad.kurikulum')
                ->where('id_kurikulum', $request->id_kurikulum)
                ->first();

            if (empty($kurikulum)) {
                return Redirect()->route('master_kurikulum.index')->with('error', 'Data tidak dapat disimpan');
            }
        }
        if ($request->id_matkul) {
            $matakuliah = DB::connection('akademik')->table('siakad.master_matakuliah')
                ->where('id_matkul', $request->id_matkul)
                ->first();

            if (empty($matakuliah)) {
                return Redirect()->route('master_kurikulum.index')->with('error', 'Data tidak dapat disimpan');
            }
        }

        $data = $request->input();

        $request['id_prodi'] = $kurikulum->id_prodi;
        $program_studi       = (new MasterDataController)->GetProgramStudi($request);

        $request['id_tahun_akademik'] = $kurikulum->id_tahun_akademik;
        $tahun_akademik               = (new MasterDataController)->GetTahunAkademik($request);

        // $data['id_semester'] = $tahun_akademik['id_semester'];
        // dd($program_studi);
        $data['nama_program_studi'] = $program_studi['nama_program_studi'];

        unset($data['_token']);
        // dd($data);
        $data['nama_kurikulum']         = $kurikulum->id_semester;
        $data['nama_matkul']            = $matakuliah->nama_mata_kuliah;
        $data['id_semester']            = $kurikulum->id_semester;
        $data['semester_mulai_berlaku'] = $tahun_akademik['nama_semester'];
        $data['sks_mata_kuliah']        = $matakuliah->sks_mata_kuliah;
        $data['sks_tatap_muka']         = $matakuliah->sks_tatap_muka;
        $data['sks_praktek']            = $matakuliah->sks_praktek;
        $data['sks_praktek_lapangan']   = $matakuliah->sks_praktek_lapangan;
        $data['sks_simulasi']           = $matakuliah->sks_simulasi;
        $data['id_prodi']               = $kurikulum->id_prodi;
        $data['id_tahun_akademik']      = $kurikulum->id_tahun_akademik;

        try {
            $insert = DB::connection('akademik')->table('siakad.matakuliah_kurikulum')->insert($data);
            $this->resp['state'] = "1";
            $this->resp['msg'] = "Matakuliah Kurikulum Berhasil Disimpan";
            $this->resp['title'] = "success";
            // return redirect('/master_kurikulum/detail_kurikulum/'.$request->id_kurikulum)->with('success', 'Master Kurikulum Berhasil Disimpan');
        } catch (Exception $e) {
            // $this->resp['msg']  = $e->getMessage();
            $this->resp['msg']  =  'Matakuliah Kurikulum Gagal Disimpan Hubungi Administrator';
            $this->resp['state'] = "0";
            $this->resp['title'] = "error";
            // return redirect('/master_kurikulum/detail_kurikulum/'.$request->id_kurikulum)->with('error', 'Master Kurikulum Gagal Disimpan Hubungi Administrator');
        }
        echo json_encode($this->resp);
    }

    public function DeleteMatakuliahKurikulum($id)
    {
        try {
            $delete = DB::connection('akademik')->table('siakad.matakuliah_kurikulum')->where('id_matakuliah_kurikulum', $id)->delete();
            if ($delete) {
                $this->res      = "Berhasil Menghapus Data";
                $this->state    = "1";
                $this->title    = "success";
            } else {
                $this->res      = "Gagal Menghapus Data";
                $this->state    = "0";
                $this->title    = "error";
            }
        } catch (Exception $e) {
            $this->res      = $e->getMessage();
            $this->state    = "0";
        }

        $arr = array(
            'state' => $this->state,
            'msg'   => $this->res,
            'title' => $this->title,
        );

        echo json_encode($arr);
    }
}
