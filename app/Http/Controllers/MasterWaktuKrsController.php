<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Controllers\MasterDataController;
use App\Models\MasterWaktuKrs;
use Illuminate\Http\Request;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Exception;

// use DB;

class MasterWaktuKrsController extends Controller
{
    public $search = '';

    public function __construct()
    {

        $this->middleware('auth');

        $this->data = array(
            'msg_main'         => '',
            'msg_detail'       => '',
            'menu_app'         => '',
            'submit'           => 'waktu_krs/insert_waktu_krs',
            'submit_mahasiswa' => 'waktu_krs/insert_mahasiswa',
            'reload'           => 'waktu_krs',
        );
    }

    function index()
    {
        return view('waktu_krs.index',  $this->data);
    }

    function GetMasterWaktuKrs(Request $request)
    {
        if ($request->ajax()) {


            $data = DB::connection('akademik')->table('siakad.waktu_krs')
                ->select('siakad.waktu_krs.id_waktu_krs', 'siakad.waktu_krs.nama_krs', 'siakad.waktu_krs.nama_program_studi', 'siakad.waktu_krs.nama_semester', 'siakad.waktu_krs.tgl_mulai', 'siakad.waktu_krs.tgl_selesai','siakad.waktu_krs.tgl_toleransi_mulai','siakad.waktu_krs.tgl_toleransi_selesai','siakad.waktu_krs.status_data')
                ->when($request->search,  fn ($query) => $query->where('siakad.waktu_krs.nama_krs', 'ILIKE', '%' . $request->search . '%'))
                ->orderBy('siakad.waktu_krs.nama_semester', 'desc')
                ->paginate(10);

            $this->data["list"]    = $data;
            // dd($data);

            return view('waktu_krs.waktu_krs_pagination',  $this->data)->render();
        }
    }

    public function AddMasterAngkatanMahasiswa()
    {

        $program_studi  = (new MasterDataController)->GetProgramStudi();
        $tahun_akademik = (new MasterDataController)->GetTahunAkademik();
        $status = array(
            array('id' => 'Aktif' , 'value' => 'aktif'),
            array('id' => 'Tidak Aktif' , 'value' => 'Tidak Aktif')
        );
        

        $forminput = [
            [
                "caption"       => 'Nama KRS',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama KRS. Contoh : KRS Online 2022/2023 Genap',
                "name"          => 'nama_krs',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Program Studi KRS',
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
                "caption"       => 'Tanggal Mulai',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => '',
                "name"          => 'tgl_mulai',
                "class"         => 'datetime',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Tanggal Selesai',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => '',
                "name"          => 'tgl_selesai',
                "class"         => 'datetime',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Tanggal Toleransi Mulai',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => '',
                "name"          => 'tgl_toleransi_mulai',
                "class"         => 'datetime',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Tanggal Toleransi Selesai',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => '',
                "name"          => 'tgl_toleransi_selesai',
                "class"         => 'datetime',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Status Data',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Status Data',
                "name"          => 'status_data',
                "class"         => '',
                "property"      => '',
                "data"          => $status,
                "value"         => '',
                "show"          => true
            ]
        ];

        // \var_dump(\json_encode($forminput));exit();

        $this->data['forminput']     = $forminput;

        return view('waktu_krs.add', $this->data);
    }

    public function EditMasterWaktuKrs($request)
    {
        // $agama = DB::connection('akademik')->table("siakad.master_agama")
        $edit =  DB::connection('akademik')->table('siakad.waktu_krs')
            ->where('id_waktu_krs', $request)
            ->first();

        $program_studi        = (new MasterDataController)->GetProgramStudi();
        $tahun_akademik       = (new MasterDataController)->GetTahunAkademik();
        $status = array(
            array('id' => 'Aktif' , 'value' => 'aktif'),
            array('id' => 'Tidak Aktif' , 'value' => 'Tidak Aktif')
        );

        // dd($edit->status_data);

        $forminput = [
            [
                "caption"       => 'ID Waktu KRS',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => '',
                "name"          => 'id_waktu_krs',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->id_waktu_krs,
                "show"          => false
            ],[
                "caption"       => 'Nama KRS',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama KRS. Contoh : KRS Online 2022/2023 Genap',
                "name"          => 'nama_krs',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->nama_krs,
                "show"          => true
            ],
            [
                "caption"       => 'Program Studi KRS',
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
                "caption"       => 'Tanggal Mulai',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => '',
                "name"          => 'tgl_mulai',
                "class"         => 'datetime',
                "property"      => '',
                "data"          => '',
                "value"         => Carbon::createFromFormat('Y-m-d H:i:s', $edit->tgl_mulai)->format('d-m-Y G:i A'),
                "show"          => true
            ],
            [
                "caption"       => 'Tanggal Selesai',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => '',
                "name"          => 'tgl_selesai',
                "class"         => 'datetime',
                "property"      => '',
                "data"          => '',
                "value"         => Carbon::createFromFormat('Y-m-d H:i:s', $edit->tgl_selesai)->format('d-m-Y G:i A'),
                "show"          => true
            ],
            [
                "caption"       => 'Tanggal Toleransi Mulai',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => '',
                "name"          => 'tgl_toleransi_mulai',
                "class"         => 'datetime',
                "property"      => '',
                "data"          => '',
                "value"         => Carbon::createFromFormat('Y-m-d H:i:s', $edit->tgl_toleransi_mulai)->format('d-m-Y G:i A'),
                "show"          => true
            ],
            [
                "caption"       => 'Tanggal Toleransi Selesai',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => '',
                "name"          => 'tgl_toleransi_selesai',
                "class"         => 'datetime',
                "property"      => '',
                "data"          => '',
                "value"         => Carbon::createFromFormat('Y-m-d H:i:s', $edit->tgl_toleransi_selesai)->format('d-m-Y G:i A'),
                "show"          => true
            ],
            [
                "caption"       => 'Status Data',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Status Data',
                "name"          => 'status_data',
                "class"         => '',
                "property"      => '',
                "data"          => $status,
                "value"         => $edit->status_data,
                "show"          => true
            ]
        ];
        $this->data['forminput']     = $forminput;

        return view('waktu_krs.add', $this->data);
    }

    public function InsertMasterWaktuKrs(Request $request)
    {
        // $data = array();
        // dd($request);

        $request->validate([
            'nama_krs'              => 'required|max:100',
            'id_prodi'              => 'required',
            'id_tahun_akademik'     => 'required',
            'tgl_mulai'             => 'required',
            'tgl_selesai'           => 'required',
            'tgl_toleransi_mulai'   => 'required',
            'tgl_toleransi_selesai' => 'required',
        ]);

        // $post= array();


        if ($request->id_waktu_krs) {
            $edit = DB::connection('akademik')->table('siakad.waktu_krs')
                ->where('id_waktu_krs', $request->id_waktu_krs)
                ->first();

            if (empty($edit)) {
                return Redirect()->route('waktu_krs.index')->with('error', 'Data tidak dapat disimpan');
            }
        }


        $data = $request->input();

        $request['id_prodi'] = $request->id_prodi;
        $program_studi       = (new MasterDataController)->GetProgramStudi($request);

        $request['id_tahun_akademik'] = $request->id_tahun_akademik;
        $tahun_akademik               = (new MasterDataController)->GetTahunAkademik($request);

        $data['id_semester'] = $tahun_akademik['id_semester'];
        $data['nama_semester'] = $tahun_akademik['nama_semester'];
        // dd($tahun_akademik);
        // dd($program_studi);
        $data['nama_program_studi'] = $program_studi['nama_program_studi'];

        // $date = date($request->tgl_mulai);
        // $dateTime = new DateTime($request->tgl_mulai);
        
        $data['tgl_mulai']             = Carbon::createFromFormat('d-m-Y g:i A', $request->tgl_mulai)->format('Y-m-d H:i');
        $data['tgl_selesai']           = Carbon::createFromFormat('d-m-Y g:i A', $request->tgl_selesai)->format('Y-m-d H:i');
        $data['tgl_toleransi_mulai']   = Carbon::createFromFormat('d-m-Y g:i A', $request->tgl_toleransi_mulai)->format('Y-m-d H:i');
        $data['tgl_toleransi_selesai'] = Carbon::createFromFormat('d-m-Y g:i A', $request->tgl_toleransi_selesai)->format('Y-m-d H:i');
        unset($data['_token']);
        // dd($data);

        if ($request->id_waktu_krs) {
            try {
                $insert = DB::connection('akademik')->table('siakad.waktu_krs')->where('id_waktu_krs', $request->id_waktu_krs)->update($data);
                return Redirect()->route('waktu_krs.index')->with('success', 'Master Waktu KRS Berhasil Diubah');
            } catch (Exception $e) {
                $this->res  = $e->getMessage();
                $this->state = "0";
                // dd($this->res);
                return Redirect('waktu_krs')->with($this->res);
            }
        } else {
            try {
                $insert = DB::connection('akademik')->table('siakad.waktu_krs')->insert($data);
                return Redirect()->route('waktu_krs.index')->with('success', 'Master Waktu KRS Berhasil Disimpan');
            } catch (Exception $e) {
                $this->res  = $e->getMessage();
                $this->state = "0";
                dd(  $this->res);
                return Redirect()->route('waktu_krs.add_waktu_krs')->with('error', 'Master Waktu KRS Gagal Disimpan Hubungi Administrator');
            }
        }
    }

    public function DeleteMasterWaktuKrs($id)
    {
        try {
            $delete = DB::connection('akademik')->table('siakad.waktu_krs')->where('id_waktu_krs', $id)->delete();
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

    function DetailMatakuliah($id)
    {

        $data = DB::connection('akademik')->table('siakad.waktu_krs')
        ->select('siakad.waktu_krs.id_waktu_krs', 'siakad.waktu_krs.nama_krs', 'siakad.waktu_krs.nama_program_studi', 'siakad.waktu_krs.nama_semester', 'siakad.waktu_krs.tgl_mulai', 'siakad.waktu_krs.tgl_selesai','siakad.waktu_krs.tgl_toleransi_mulai','siakad.waktu_krs.tgl_toleransi_selesai','siakad.waktu_krs.status_data')
            ->where('id_waktu_krs', $id)
            ->first();

        $tahun_akademik  = (new MasterDataController)->GetTahunAkademik();
       
        $forminput = [[
            "caption"       => 'Program Tahun Angkatan Mahasiswa',
            "type"          => 'select',
            "required"      => 'required',
            "placeholder"   => 'Pilih Tahun Angkatan Mahasiswa',
            "name"          => 'id_angkatan',
            "class"         => '',
            "property"      => 'onchange=fetch_user_data();',
            "data"          => $tahun_akademik,
            "value"         => '',
            "show"          => true
        ],[
            "caption"       => 'Pencarian',
            "type"          => 'text',
            "required"      => 'required',
            "placeholder"   => 'Cari Nama Matakuliah ',
            "name"          => 'search',
            "class"         => '',
            "property"      => 'data-kt-docs-table-filter=search',
            "data"          => '',
            "value"         => '',
            "show"          => true
        ]];
        $this->data['forminput']     = $forminput;

        // dd($mahasiswa);
        $this->data["data"]  = $data;

        return view('waktu_krs.detail_matakuliah',  $this->data);
    }

    function GetMatakuliahPagination(Request $request)
    {
        if ($request->ajax()) {
            $data = DB::connection('akademik')->table('siakad.matakuliah_krs_ditawarkan')
                ->select('mahasiswa_angkatan.id_mahasiswa_angkatan', 'biodata_mahasiswa.nama_mahasiswa', 'list_mahasiswa.nim')
                ->join('siakad.matakuliah_kurikulum', 'siakad.matakuliah_krs_ditawarkan.id_matakuliah_kurikulum', '=', 'siakad.matakuliah_kurikulum.id_matakuliah_kurikulum')
                ->join('siakad.biodata_mahasiswa', 'siakad.list_mahasiswa.id_mahasiswa', '=', 'siakad.biodata_mahasiswa.id_mahasiswa')
                ->where('siakad.mahasiswa_angkatan.id_angkatan_mahasiswa', $request->id_angkatan_mahasiswa)
                ->when($request->search,  fn ($query) => $query->where('siakad.biodata_mahasiswa.nama_mahasiswa', 'ILIKE', '%' . $request->search . '%')
                    ->orwhere('siakad.list_mahasiswa.nim', 'ILIKE', '%' . $request->search . '%'))
                ->orderBy('list_mahasiswa.nim', 'asc')
                ->paginate(50);

            $this->data["list"]    = $data;

            $angkatan =  DB::connection('akademik')->table('siakad.waktu_krs')
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
                    "data"          => '',
                    "value"         => '',
                    "show"          => true
                ]
            ];

            $this->data['forminput'] = $forminput;
            $this->data['submit'] = 'waktu_krs/insert_mahasiswa';
            $this->data['reload'] = 'waktu_krs';

            // dd($this->data);
            return view('waktu_krs.detail_matakuliah_pagination',  $this->data);
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
            // return redirect('/waktu_krs/detail_kurikulum/'.$request->id_kurikulum)->with('success', 'Master Kurikulum Berhasil Disimpan');
        } catch (Exception $e) {
            // $this->resp['msg']  = $e->getMessage();
            $this->resp['msg']  =  'Mahasiswa Gagal Disimpan Hubungi Administrator';
            $this->resp['state'] = "0";
            $this->resp['title'] = "error";
            // return redirect('/waktu_krs/detail_kurikulum/'.$request->id_kurikulum)->with('error', 'Master Kurikulum Gagal Disimpan Hubungi Administrator');
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

        $data = DB::connection('akademik')->table('siakad.waktu_krs')
            ->select('siakad.waktu_krs.id_tahun_akademik', 'siakad.waktu_krs.id_angkatan_mahasiswa', 'siakad.waktu_krs.nama_angkatan_mahasiswa', 'siakad.kurikulum.nama_kurikulum', 'siakad.master_prodi.nama_jenjang_pendidikan', 'siakad.master_prodi.nama_program_studi', 'siakad.master_prodi.id_prodi', 'siakad.master_tahun_akademik.nama_semester')
            ->join('siakad.master_prodi', 'siakad.waktu_krs.id_prodi', '=', 'siakad.master_prodi.id_prodi')
            ->join('siakad.master_tahun_akademik', 'siakad.waktu_krs.id_tahun_akademik', '=', 'siakad.master_tahun_akademik.id_tahun_akademik')
            ->join('siakad.kurikulum', 'siakad.waktu_krs.id_kurikulum', '=', 'siakad.kurikulum.id_kurikulum')
            ->where('id_angkatan_mahasiswa', $id)
            ->first();

       
        // dd($mahasiswa);
        $this->data["data"]  = $data;

        return view('waktu_krs.detail_tagihan',  $this->data);
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

            $angkatan =  DB::connection('akademik')->table('siakad.waktu_krs')
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
            $this->data['submit'] = 'waktu_krs/insert_tagihan';
            $this->data['reload'] = 'waktu_krs';

            // dd($this->data);
            return view('waktu_krs.detail_tagihan_pagination',  $this->data);
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
            $edit = DB::connection('akademik')->table('siakad.waktu_krs')
                ->where('id_angkatan_mahasiswa', $request->id_angkatan_mahasiswa)
                ->first();

            if (empty($edit)) {
                return Redirect()->route('waktu_krs.index')->with('error', 'Data tidak dapat disimpan');
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
            // return redirect('/waktu_krs/detail_kurikulum/'.$request->id_kurikulum)->with('success', 'Master Kurikulum Berhasil Disimpan');
        } catch (Exception $e) {
            dd($e->getMessage());
            // $this->resp['msg']  = $e->getMessage();
            $this->resp['msg']  =  'Mahasiswa Gagal Disimpan Hubungi Administrator';
            $this->resp['state'] = "0";
            $this->resp['title'] = "error";
            // return redirect('/waktu_krs/detail_kurikulum/'.$request->id_kurikulum)->with('error', 'Master Kurikulum Gagal Disimpan Hubungi Administrator');
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
