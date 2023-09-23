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

class MasterAngkatanMahasiswaController extends Controller
{
    public $search = '';

    public function __construct()
    {

        $this->middleware('auth');

        $this->data = array(
            'msg_main'         => '',
            'msg_detail'       => '',
            'menu_app'         => '',
            'submit'           => 'master_angkatan_mahasiswa/insert_master_angkatan_mahasiswa',
            'submit_mahasiswa' => 'master_angkatan_mahasiswa/insert_mahasiswa',
            'submit_tagihan'   => 'master_angkatan_mahasiswa/insert_tagihan',
            'reload'           => 'master_angkatan_mahasiswa',
        );
    }

    function index()
    {
        return view('master_angkatan_mahasiswa.index',  $this->data);
    }

    function GetMasterAngkatanMahasiswa(Request $request)
    {
        if ($request->ajax()) {

            $mhs = DB::connection('akademik')->table('siakad.mahasiswa_angkatan')
                   ->select('id_angkatan_mahasiswa', DB::raw('count(id_mahasiswa_angkatan) as jml'))
                   ->groupBy('id_angkatan_mahasiswa');


            $data = DB::connection('akademik')->table('siakad.master_angkatan_mahasiswa')
                ->select('siakad.master_angkatan_mahasiswa.id_angkatan_mahasiswa', 'siakad.master_angkatan_mahasiswa.nama_angkatan_mahasiswa', 'siakad.kurikulum.nama_kurikulum', 'siakad.master_prodi.nama_jenjang_pendidikan', 'siakad.master_prodi.nama_program_studi', 'siakad.master_tahun_akademik.nama_semester','mhs.jml')
                ->join('siakad.master_prodi', 'siakad.master_angkatan_mahasiswa.id_prodi', '=', 'siakad.master_prodi.id_prodi')
                ->join('siakad.master_tahun_akademik', 'siakad.master_angkatan_mahasiswa.id_tahun_akademik', '=', 'siakad.master_tahun_akademik.id_tahun_akademik')
                ->join('siakad.kurikulum', 'siakad.master_angkatan_mahasiswa.id_kurikulum', '=', 'siakad.kurikulum.id_kurikulum')
                ->leftJoinSub($mhs,'mhs','master_angkatan_mahasiswa.id_angkatan_mahasiswa' ,'=','mhs.id_angkatan_mahasiswa')
                ->when($request->search,  fn ($query) => $query->where('siakad.master_angkatan_mahasiswa.nama_angkatan_mahasiswa', 'ILIKE', '%' . $request->search . '%'))
                ->orderBy('siakad.master_angkatan_mahasiswa.nama_angkatan_mahasiswa', 'asc')
                ->paginate(10);

            $this->data["list"]    = $data;
            // dd($data);

            return view('master_angkatan_mahasiswa.master_angkatan_mahasiswa_pagination',  $this->data)->render();
        }
    }

    public function AddMasterAngkatanMahasiswa()
    {

        $program_studi  = (new MasterDataController)->GetProgramStudi();
        $tahun_akademik = (new MasterDataController)->GetTahunAkademik();

        $forminput = [
            [
                "caption"       => 'Nama Angkatan',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Angkatan. Contoh : Farmasi Angkatan 2022/2023 Genap Beasiswa',
                "name"          => 'nama_angkatan_mahasiswa',
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
                "property"      => 'onchange=getkurikulum();',
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
                "caption"       => 'Kurikulum Matakuliah',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Kurikulum',
                "name"          => 'id_kurikulum',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ]
        ];

        // \var_dump(\json_encode($forminput));exit();

        $this->data['forminput']     = $forminput;

        return view('master_angkatan_mahasiswa.add', $this->data);
    }

    public function EditMasterAngkatanMahasiswa($request)
    {
        // $agama = DB::connection('akademik')->table("siakad.master_agama")
        $edit =  DB::connection('akademik')->table('siakad.master_angkatan_mahasiswa')
            ->where('id_angkatan_mahasiswa', $request)
            ->first();

        $program_studi        = (new MasterDataController)->GetProgramStudi();
        $tahun_akademik       = (new MasterDataController)->GetTahunAkademik();

        $post['id_prodi'] = $edit->id_prodi;
        $request          = request()->merge($post);
        $kurikulum        = (new MasterDataController)->GetKurikulum($request);

        $forminput = [
            [
                "caption"       => 'ID Angkatan Mahasiswa',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => '',
                "name"          => 'id_angkatan_mahasiswa',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->id_angkatan_mahasiswa,
                "show"          => false
            ], [
                "caption"       => 'Nama Angkatan',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Angkatan. Contoh : Farmasi Angkatan 2022/2023 Genap Beasiswa',
                "name"          => 'nama_angkatan_mahasiswa',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->nama_angkatan_mahasiswa,
                "show"          => true
            ],
            [
                "caption"       => 'Program Studi Matakuliah',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Program Studi ',
                "name"          => 'id_prodi',
                "class"         => '',
                "property"      => 'onchange=getkurikulum();',
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
                "caption"       => 'Kurikulum Matakuliah',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Kurikulum',
                "name"          => 'id_kurikulum',
                "class"         => '',
                "property"      => '',
                "data"          =>  $kurikulum,
                "value"         => $edit->id_kurikulum,
                "show"          => true
            ]
        ];
        $this->data['forminput']     = $forminput;

        return view('master_angkatan_mahasiswa.add', $this->data);
    }

    public function InsertMasterAngkatanMahasiswa(Request $request)
    {
        // $data = array();
        // dd($request);

        $request->validate([
            'nama_angkatan_mahasiswa' => 'required|max:100',
            'id_prodi'                => 'required',
            'id_tahun_akademik'       => 'required',
            'id_kurikulum'            => 'required',
        ]);

        // $post= array();


        if ($request->id_angkatan_mahasiswa) {
            $edit = DB::connection('akademik')->table('siakad.master_angkatan_mahasiswa')
                ->where('id_angkatan_mahasiswa', $request->id_angkatan_mahasiswa)
                ->first();

            if (empty($edit)) {
                return Redirect()->route('master_angkatan_mahasiswa.index')->with('error', 'Data tidak dapat disimpan');
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

        if ($request->id_angkatan_mahasiswa) {
            try {
                $insert = DB::connection('akademik')->table('siakad.master_angkatan_mahasiswa')->where('id_angkatan_mahasiswa', $request->id_angkatan_mahasiswa)->update($data);
                return Redirect()->route('master_angkatan_mahasiswa.index')->with('success', 'Master Angkatan Mahasiswa Berhasil Diubah');
            } catch (Exception $e) {
                $this->res  = $e->getMessage();
                $this->state = "0";
                // dd($this->res);
                return Redirect('master_angkatan_mahasiswa')->with($this->res);
            }
        } else {
            try {
                $insert = DB::connection('akademik')->table('siakad.master_angkatan_mahasiswa')->insert($data);
                return Redirect()->route('master_angkatan_mahasiswa.index')->with('success', 'Master Angkatan Mahasiswa Berhasil Disimpan');
            } catch (Exception $e) {
                $this->res  = $e->getMessage();
                $this->state = "0";
                // dd(  $this->res);
                return Redirect()->route('master_angkatan_mahasiswa.add_master_angkatan_mahasiswa')->with('error', 'Master Angkatan Mahasiswa Gagal Disimpan Hubungi Administrator');
            }
        }
    }

    public function DeleteMasterAngkatanMahasiswa($id)
    {
        try {
            $delete = DB::connection('akademik')->table('siakad.master_angkatan_mahasiswa')->where('id_angkatan_mahasiswa', $id)->delete();
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

    function DetailMahasiswa($id)
    {

        $data = DB::connection('akademik')->table('siakad.master_angkatan_mahasiswa')
            ->select('siakad.master_angkatan_mahasiswa.id_tahun_akademik', 'siakad.master_angkatan_mahasiswa.id_angkatan_mahasiswa', 'siakad.master_angkatan_mahasiswa.nama_angkatan_mahasiswa', 'siakad.kurikulum.nama_kurikulum', 'siakad.master_prodi.nama_jenjang_pendidikan', 'siakad.master_prodi.nama_program_studi', 'siakad.master_prodi.id_prodi', 'siakad.master_tahun_akademik.nama_semester')
            ->join('siakad.master_prodi', 'siakad.master_angkatan_mahasiswa.id_prodi', '=', 'siakad.master_prodi.id_prodi')
            ->join('siakad.master_tahun_akademik', 'siakad.master_angkatan_mahasiswa.id_tahun_akademik', '=', 'siakad.master_tahun_akademik.id_tahun_akademik')
            ->join('siakad.kurikulum', 'siakad.master_angkatan_mahasiswa.id_kurikulum', '=', 'siakad.kurikulum.id_kurikulum')
            ->where('id_angkatan_mahasiswa', $id)
            ->first();

       
        // dd($mahasiswa);
        $this->data["data"]  = $data;

        return view('master_angkatan_mahasiswa.detail_mahasiswa',  $this->data);
    }

    function GetMahasiswaAngkatanPagination(Request $request)
    {
        if ($request->ajax()) {
            $data = DB::connection('akademik')->table('siakad.mahasiswa_angkatan')
                ->select('mahasiswa_angkatan.id_mahasiswa_angkatan', 'biodata_mahasiswa.nama_mahasiswa', 'list_mahasiswa.nim')
                ->join('siakad.list_mahasiswa', 'siakad.mahasiswa_angkatan.id_registrasi_mahasiswa', '=', 'siakad.list_mahasiswa.id_registrasi_mahasiswa')
                ->join('siakad.biodata_mahasiswa', 'siakad.list_mahasiswa.id_mahasiswa', '=', 'siakad.biodata_mahasiswa.id_mahasiswa')
                ->where('siakad.mahasiswa_angkatan.id_angkatan_mahasiswa', $request->id_angkatan_mahasiswa)
                ->when($request->search,  fn ($query) => $query->where('siakad.biodata_mahasiswa.nama_mahasiswa', 'ILIKE', '%' . $request->search . '%')
                    ->orwhere('siakad.list_mahasiswa.nim', 'ILIKE', '%' . $request->search . '%'))
                ->orderBy('list_mahasiswa.nim', 'asc')
                ->paginate(50);

            $this->data["list"]    = $data;

            $angkatan =  DB::connection('akademik')->table('siakad.master_angkatan_mahasiswa')
                ->where('id_angkatan_mahasiswa', $request->id_angkatan_mahasiswa)
                ->first();
            // dd($angkatan);
            // $post['id_prodi']          = $angkatan->id_prodi;
            // $post['id_tahun_akademik'] = $angkatan->id_tahun_akademik;
            // $request                   = request()->merge($post);

            $data = DB::connection('akademik')->table('siakad.list_mahasiswa')
                ->select('list_mahasiswa.id_registrasi_mahasiswa as id',   DB::raw("CONCAT(nim,' - ',list_mahasiswa.nama_mahasiswa)  as value"), 'mahasiswa_angkatan.id_angkatan_mahasiswa')
                ->leftJoin('siakad.mahasiswa_angkatan', 'siakad.list_mahasiswa.id_registrasi_mahasiswa', '=', 'siakad.mahasiswa_angkatan.id_registrasi_mahasiswa')
                ->where('list_mahasiswa.id_prodi', '=',  $angkatan->id_prodi)
                ->where('list_mahasiswa.id_tahun_akademik', '=',  $angkatan->id_tahun_akademik)
                ->where('mahasiswa_angkatan.id_angkatan_mahasiswa', '=',  null)
                ->get();
            // dd($data);
            $mahasiswa = json_decode(json_encode($data), true);


            // $mahasiswa        = (new MasterDataController)->GetListMahasiswa($request);


            $forminput = [
                [
                    "caption"       => 'Pilih Mahasiswa',
                    "type"          => 'select',
                    "required"      => 'required',
                    "placeholder"   => '',
                    "name"          => 'id_registrasi_mahasiswa',
                    "class"         => 'mhs',
                    "property"      => 'multiple=multiple',
                    "data"          => $mahasiswa,
                    "value"         => '',
                    "show"          => true
                ]
            ];

            $this->data['forminput'] = $forminput;
            $this->data['submit'] = 'master_angkatan_mahasiswa/insert_mahasiswa';
            $this->data['reload'] = 'master_angkatan_mahasiswa';

            // dd($this->data);
            return view('master_angkatan_mahasiswa.detail_mahasiswa_pagination',  $this->data);
        }
    }

    public function InsertMahasiswa(Request $request)
    {
        $request->validate([
            'id_angkatan_mahasiswa'   => 'required',
            'id_registrasi_mahasiswa' => 'required',
        ]);

        $data = [];
        foreach ($request->id_registrasi_mahasiswa as $row) {
            $values = array(
                'id_angkatan_mahasiswa'   => $request->id_angkatan_mahasiswa,
                'id_registrasi_mahasiswa' => $row,
            );

            array_push($data, $values);
        }

        try {
            $insert = DB::connection('akademik')->table('siakad.mahasiswa_angkatan')->insert($data);
            $this->resp['state'] = "1";
            $this->resp['msg'] = "Mahasiswa Berhasil Disimpan";
            $this->resp['title'] = "success";
            // return redirect('/master_angkatan_mahasiswa/detail_kurikulum/'.$request->id_kurikulum)->with('success', 'Master Kurikulum Berhasil Disimpan');
        } catch (Exception $e) {
            // $this->resp['msg']  = $e->getMessage();
            $this->resp['msg']  =  'Mahasiswa Gagal Disimpan Hubungi Administrator';
            $this->resp['state'] = "0";
            $this->resp['title'] = "error";
            // return redirect('/master_angkatan_mahasiswa/detail_kurikulum/'.$request->id_kurikulum)->with('error', 'Master Kurikulum Gagal Disimpan Hubungi Administrator');
        }
        echo json_encode($this->resp);
    }

    public function DeleteMahasiswa($id)
    {
        try {
            $delete = DB::connection('akademik')->table('siakad.mahasiswa_angkatan')->where('id_mahasiswa_angkatan', $id)->delete();
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

    function DetailTagihanAngkatan($id)
    {

        $data = DB::connection('akademik')->table('siakad.master_angkatan_mahasiswa')
            ->select('siakad.master_angkatan_mahasiswa.id_tahun_akademik', 'siakad.master_angkatan_mahasiswa.id_angkatan_mahasiswa', 'siakad.master_angkatan_mahasiswa.nama_angkatan_mahasiswa', 'siakad.kurikulum.nama_kurikulum', 'siakad.master_prodi.nama_jenjang_pendidikan', 'siakad.master_prodi.nama_program_studi', 'siakad.master_prodi.id_prodi', 'siakad.master_tahun_akademik.nama_semester')
            ->join('siakad.master_prodi', 'siakad.master_angkatan_mahasiswa.id_prodi', '=', 'siakad.master_prodi.id_prodi')
            ->join('siakad.master_tahun_akademik', 'siakad.master_angkatan_mahasiswa.id_tahun_akademik', '=', 'siakad.master_tahun_akademik.id_tahun_akademik')
            ->join('siakad.kurikulum', 'siakad.master_angkatan_mahasiswa.id_kurikulum', '=', 'siakad.kurikulum.id_kurikulum')
            ->where('id_angkatan_mahasiswa', $id)
            ->first();

       
        // dd($mahasiswa);
        $this->data["data"]  = $data;

        return view('master_angkatan_mahasiswa.detail_tagihan',  $this->data);
    }

    function GetTagihanAngkatanPagination(Request $request)
    {
        if ($request->ajax()) {
            $data = DB::connection('akademik')->table('siakad.master_tagihan_angkatan')
                ->select('master_tagihan_angkatan.id_tagihan_angkatan', 'master_tagihan_angkatan.kode_rekening', 'master_tagihan_angkatan.nama_rekening', 'master_tagihan_angkatan.biaya')
                ->where('siakad.master_tagihan_angkatan.id_angkatan_mahasiswa', $request->id_angkatan_mahasiswa)
                ->when($request->search,  fn ($query) => $query->where('siakad.master_tagihan_angkatan.nama_rekening', 'ILIKE', '%' . $request->search . '%')
                    ->orwhere('siakad.master_tagihan_angkatan.kode_rekening', 'ILIKE', '%' . $request->search . '%'))
                ->orderBy('master_tagihan_angkatan.kode_rekening', 'asc')
                ->paginate(50);

            $this->data["list"]    = $data;

            $angkatan =  DB::connection('akademik')->table('siakad.master_angkatan_mahasiswa')
                ->where('id_angkatan_mahasiswa', $request->id_angkatan_mahasiswa)
                ->first();
            // dd($angkatan);
            // $post['id_prodi']          = $angkatan->id_prodi;
            // $post['id_tahun_akademik'] = $angkatan->id_tahun_akademik;
            // $request                   = request()->merge($post);

            $data = DB::connection('akademik')->table('siakad.master_kode_pembayaran')
                ->select('master_kode_pembayaran.id_kode_pembayaran as id',   DB::raw("CONCAT(master_kode_pembayaran.kode_rekening,' - ',master_kode_pembayaran.nama_rekening)  as value"), 'master_tagihan_angkatan.id_tagihan_angkatan')
                ->leftJoin('siakad.master_tagihan_angkatan', 'siakad.master_kode_pembayaran.id_kode_pembayaran', '=', 'siakad.master_tagihan_angkatan.id_kode_pembayaran')
                ->where('master_kode_pembayaran.id_prodi', '=',  $angkatan->id_prodi)
                ->where('master_tagihan_angkatan.id_tagihan_angkatan', '=',  null)
                ->get();
            // dd($data);
            $kode_tagihan = json_decode(json_encode($data), true);


            // $mahasiswa        = (new MasterDataController)->GetListMahasiswa($request);


            $forminput = [
                [
                    "caption"       => 'Pilih Kode rekening',
                    "type"          => 'select',
                    "required"      => 'required',
                    "placeholder"   => '',
                    "name"          => 'id_kode_pembayaran',
                    "class"         => 'kode_pembayaran',
                    "property"      => '',
                    "data"          => $kode_tagihan,
                    "value"         => '',
                    "show"          => true
                ],
                [
                    "caption"       => 'Biaya',
                    "type"          => 'text',
                    "required"      => 'required',
                    "placeholder"   => '',
                    "name"          => 'biaya',
                    "class"         => 'numberonly currency',
                    "property"      => '',
                    "data"          => '',
                    "value"         => '',
                    "show"          => true
                ]
            ];

            $this->data['forminput'] = $forminput;
            $this->data['submit'] = 'master_angkatan_mahasiswa/insert_tagihan';
            $this->data['reload'] = 'master_angkatan_mahasiswa';

            // dd($this->data);
            return view('master_angkatan_mahasiswa.detail_tagihan_pagination',  $this->data);
        }
    }

    public function InsertTagihan(Request $request)
    {
        $request->validate([
            'id_angkatan_mahasiswa'   => 'required',
            'id_kode_pembayaran' => 'required',
            'biaya' => 'required',
        ]);

       
        if ($request->id_angkatan_mahasiswa) {
            $edit = DB::connection('akademik')->table('siakad.master_angkatan_mahasiswa')
                ->where('id_angkatan_mahasiswa', $request->id_angkatan_mahasiswa)
                ->first();

            if (empty($edit)) {
                return Redirect()->route('master_angkatan_mahasiswa.index')->with('error', 'Data tidak dapat disimpan');
            }
        }


        $data = $request->input();

        $request['id_prodi'] = $edit->id_prodi;
        $program_studi       = (new MasterDataController)->GetProgramStudi($request);

        $request['id_tahun_akademik'] = $edit->id_tahun_akademik;
        $tahun_akademik               = (new MasterDataController)->GetTahunAkademik($request);

        $request['id_kode_pembayaran'] = $request->id_kode_pembayaran;
        $kode_pembayaran               = (new MasterDataController)->GetKodePembayaran($request);


        $data['kode_rekening'] = $kode_pembayaran['kode_rekening'];
        $data['nama_rekening'] = $kode_pembayaran['nama_rekening'];
        $data['id_semester']   = $tahun_akademik['id_semester'];
        // dd($program_studi);
        $data['nama_program_studi'] = $program_studi['nama_program_studi'];

        unset($data['_token']);
        // dd($data);

       

        try {
            $insert = DB::connection('akademik')->table('siakad.master_tagihan_angkatan')->insert($data);
            $this->resp['state'] = "1";
            $this->resp['msg'] = "Mahasiswa Berhasil Disimpan";
            $this->resp['title'] = "success";
            // return redirect('/master_angkatan_mahasiswa/detail_kurikulum/'.$request->id_kurikulum)->with('success', 'Master Kurikulum Berhasil Disimpan');
        } catch (Exception $e) {
            dd($e->getMessage());
            // $this->resp['msg']  = $e->getMessage();
            $this->resp['msg']  =  'Mahasiswa Gagal Disimpan Hubungi Administrator';
            $this->resp['state'] = "0";
            $this->resp['title'] = "error";
            // return redirect('/master_angkatan_mahasiswa/detail_kurikulum/'.$request->id_kurikulum)->with('error', 'Master Kurikulum Gagal Disimpan Hubungi Administrator');
        }
        echo json_encode($this->resp);
    }

    public function DeleteTagihan($id)
    {
        try {
            $delete = DB::connection('akademik')->table('siakad.master_tagihan_angkatan')->where('id_tagihan_angkatan', $id)->delete();
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
