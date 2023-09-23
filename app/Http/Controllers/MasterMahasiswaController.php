<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Controllers\MasterDataController;
use App\Models\MasterMahasiswa;
use Illuminate\Http\Request;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Exception;

// use DB;

class MasterMahasiswaController extends Controller
{
    public $search = '';

    public function __construct()
    {

        $this->middleware('auth');

        $this->data = array(
            'msg_main'      => '',
            'msg_detail'    => '',
            'menu_app'      => '',
            'submit'        => 'master_mahasiswa/insert_master_mahasiswa',
            'reload'        => 'master_mahasiswa',
        );
    }

    function index()
    {
        return view('master_mahasiswa.index',  $this->data);
    }

    function GetMasterMahasiswa(Request $request)
    {

        if ($request->ajax()) {
            $data = DB::connection('akademik')->table('siakad.list_mahasiswa')
                
                ->select('siakad.list_mahasiswa.id_registrasi_mahasiswa', 'siakad.list_mahasiswa.nim', 'siakad.list_mahasiswa.nama_mahasiswa', 'siakad.list_mahasiswa.jenis_kelamin', 'siakad.list_mahasiswa.nama_agama', 'siakad.list_mahasiswa.tanggal_lahir', 'siakad.list_mahasiswa.nama_program_studi')
                ->when($request->search,  fn ($query) => $query->where('nama_mahasiswa', 'ILIKE', '%' . $request->search . '%'))
                ->orderBy('siakad.list_mahasiswa.nama_mahasiswa', 'asc')
                ->paginate(10);

            $this->data["list"]    = $data;

            return view('master_mahasiswa.master_mahasiswa_pagination',  $this->data)->render();
        }
    }

    public function AddMasterMahasiswa()
    {

        $jenis_pendaftaran    = (new MasterDataController)->GetJenisPendaftaran();
        $jalur_masuk          = (new MasterDataController)->GetJalurMasuk();
        $tahun_akademik       = (new MasterDataController)->GetTahunAkademik();
        $pembiayaan_mahasiswa = (new MasterDataController)->GetPembiayaanMahasiswa();
        $program_studi        = (new MasterDataController)->GetProgramStudi();

        $forminput = [
            [
                "caption"       => 'Nama Mahasiswa ',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Nama Mahasiswa',
                "name"          => 'id_mahasiswa',
                "class"         => '',
                "property"      => ' data-control="select2" ',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'NIM ',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nomor Induk Mahasiswa. Contoh : 33102100001',
                "name"          => 'nim',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true

            ],
            [
                "caption"       => 'Jenis Pendaftaran Mahasiswa ',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Jenis Pendaftaran',
                "name"          => 'id_jenis_daftar',
                "class"         => '',
                "property"      => 'onchange=display_univ();',
                "data"          => $jenis_pendaftaran,
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Jalur Masuk Mahasiswa ',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Jalur Masuk',
                "name"          => 'id_jalur_daftar',
                "class"         => '',
                "property"      => '',
                "data"          => $jalur_masuk,
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Periode Masuk',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Periode Masuk',
                "name"          => 'id_tahun_akademik',
                "class"         => '',
                "property"      => '',
                "data"          => $tahun_akademik,
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Tanggal Masuk',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Tanggal Masuk. Contoh : dd-mm-yyyy',
                "name"          => 'tanggal_daftar',
                "class"         => 'date',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Pembiayaan Awal',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Pembiayaan Awal.',
                "name"          => 'id_pembiayaan',
                "class"         => '',
                "property"      => '',
                "data"          => $pembiayaan_mahasiswa,
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Biaya Masuk',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Biaya Masuk. Contoh : Rp. 5.000.000',
                "name"          => 'biaya_masuk',
                "class"         => 'numberonly',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Program Studi',
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
                "caption"       => 'Asal Perguruan Tinggi',
                "type"          => 'select',
                "required"      => '',
                "placeholder"   => 'Pilih Perguruan Tinggi',
                "name"          => 'id_perguruan_tinggi_asal',
                "class"         => '',
                "property"      => 'onchange=getprogramstudi();',
                "data"          => '',
                "value"         => '',
                "show"          => false
            ],
            [
                "caption"       => 'Asal Program Studi',
                "type"          => 'select',
                "required"      => '',
                "placeholder"   => 'Pilih Program Studi',
                "name"          => 'id_prodi_asal',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => false
            ]
        ];

        $this->data['forminput']     = $forminput;

        return view('master_mahasiswa.add', $this->data);
    }

    public function EditMasterMahasiswa($request)
    {
        // $agama = DB::connection('akademik')->table("siakad.master_agama")
        $edit =  DB::connection('akademik')->table('siakad.list_mahasiswa')
            ->where('id_registrasi_mahasiswa', $request)
            ->first();

        $post['id_mahasiswa'] = $edit->id_mahasiswa;
        $request              = request()->merge($post);
        $biodata_mahasiswa    = (new MasterDataController)->GetBioMahasiswa($request);
        $biodata_mahasiswa    = array(array("id" => $biodata_mahasiswa['id_mahasiswa'], "value" => $biodata_mahasiswa['nama_mahasiswa']));
        $jenis_pendaftaran    = (new MasterDataController)->GetJenisPendaftaran();
        $jalur_masuk          = (new MasterDataController)->GetJalurMasuk();
        $tahun_akademik       = (new MasterDataController)->GetTahunAkademik();
        $pembiayaan_mahasiswa = (new MasterDataController)->GetPembiayaanMahasiswa();
        $program_studi        = (new MasterDataController)->GetProgramStudi();

        $program_studi_asal = [];
        if ($edit->id_perguruan_tinggi_asal) {
            $id_perguruan_tinggi_asal[] = array(
                "id"    => $edit->id_perguruan_tinggi_asal . "|" . trim($edit->kode_pt) . "|" . trim($edit->nama_perguruan_tinggi_asal),
                "value" => trim($edit->kode_pt) . " - " . trim($edit->nama_perguruan_tinggi_asal)
            );

            $post['search'] =  $id_perguruan_tinggi_asal[0]['id'];
            $request        = request()->merge($post);

            $array_program_studi_asal        = (new MasterDataController)->GetProdiUniversitas($request);
            // echo"<pre>";
            // \var_dump($array_program_studi_asal->original);exit();
            foreach ($array_program_studi_asal->original as $row) {
                $arr = array("id" => $row['id'], "value" => $row['text']);
                array_push($program_studi_asal, $arr);
            }
        }
        // dd($id_perguruan_tinggi_asal,$edit->id_perguruan_tinggi_asal . "|" . trim($edit->kode_pt) . "|" . trim($edit->nama_perguruan_tinggi_asal));

        $forminput = [
            [
                "caption"       => 'Id Registrasi Mahasiswa ',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Pilih Nama Mahasiswa',
                "name"          => 'id_registrasi_mahasiswa',
                "class"         => '',
                "property"      => ' data-control="select2" ',
                "data"          => '',
                "value"         => $edit->id_registrasi_mahasiswa,
                "show"          => false
            ],
            [
                "caption"       => 'Nama Mahasiswa ',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Pilih Nama Mahasiswa',
                "name"          => 'id_mahasiswa',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->id_mahasiswa,
                "show"          => false
            ],
            [
                "caption"       => 'Nama Mahasiswa ',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Nama Mahasiswa',
                "name"          => 'id_mahasiswa_2',
                "class"         => '',
                "property"      => 'disabled',
                "data"          => $biodata_mahasiswa,
                "value"         => $edit->id_mahasiswa,
                "show"          => true
            ],
            [
                "caption"       => 'NIM ',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nomor Induk Mahasiswa. Contoh : 33102100001',
                "name"          => 'nim',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->nim,
                "show"          => true

            ],
            [
                "caption"       => 'Jenis Pendaftaran Mahasiswa ',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Jenis Pendaftaran',
                "name"          => 'id_jenis_daftar',
                "class"         => '',
                "property"      => 'onchange=display_univ();',
                "data"          => $jenis_pendaftaran,
                "value"         => $edit->id_jenis_daftar,
                "show"          => true
            ],
            [
                "caption"       => 'Jalur Masuk Mahasiswa ',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Jalur Masuk',
                "name"          => 'id_jalur_daftar',
                "class"         => '',
                "property"      => '',
                "data"          => $jalur_masuk,
                "value"         => $edit->id_jalur_daftar,
                "show"          => true
            ],
            [
                "caption"       => 'Periode Masuk',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Periode Masuk',
                "name"          => 'id_tahun_akademik',
                "class"         => '',
                "property"      => '',
                "data"          => $tahun_akademik,
                "value"         => $edit->id_tahun_akademik,
                "show"          => true
            ],
            [
                "caption"       => 'Tanggal Masuk',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Tanggal Masuk. Contoh : dd-mm-yyyy',
                "name"          => 'tanggal_daftar',
                "class"         => 'date',
                "property"      => '',
                "data"          => '',
                "value"         => Carbon::createFromFormat('Y-m-d', $edit->tanggal_daftar)->format('d-m-Y'),
                "show"          => true
            ],
            [
                "caption"       => 'Pembiayaan Awal',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Pembiayaan Awal.',
                "name"          => 'id_pembiayaan',
                "class"         => '',
                "property"      => '',
                "data"          => $pembiayaan_mahasiswa,
                "value"         => $edit->id_pembiayaan,
                "show"          => true
            ],
            [
                "caption"       => 'Biaya Masuk',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Biaya Masuk. Contoh : Rp. 5.000.000',
                "name"          => 'biaya_masuk',
                "class"         => 'numberonly currency',
                "property"      => '',
                "data"          => '',
                "value"         => number_format(floatval($edit->biaya_masuk)),
                "show"          => true
            ],
            [
                "caption"       => 'Program Studi',
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
                "caption"       => 'Asal Perguruan Tinggi',
                "type"          => 'select',
                "required"      => '',
                "placeholder"   => 'Pilih Perguruan Tinggi',
                "name"          => 'id_perguruan_tinggi_asal',
                "class"         => '',
                "property"      => 'onchange=getprogramstudi();',
                "data"          => $id_perguruan_tinggi_asal,
                "value"         => trim($edit->id_perguruan_tinggi_asal . "|" . trim($edit->kode_pt) . "|" . trim($edit->nama_perguruan_tinggi_asal)),
                "show"          => false
            ],
            [
                "caption"       => 'Asal Program Studi',
                "type"          => 'select',
                "required"      => '',
                "placeholder"   => 'Pilih Program Studi',
                "name"          => 'id_prodi_asal',
                "class"         => '',
                "property"      => '',
                "data"          => $program_studi_asal,
                "value"         => $edit->id_prodi_asal,
                "show"          => false
            ]
        ];

        $this->data['forminput']     = $forminput;

        return view('master_mahasiswa.add', $this->data);
    }

    public function InsertMasterMahasiswa(Request $request)
    {
        // $data = array();
        // dd($request);

        $request->validate([
            'id_mahasiswa'      => 'required',
            'nim'               => 'required',
            'id_jenis_daftar'   => 'required',
            'id_jalur_daftar'   => 'required',
            'id_tahun_akademik' => 'required',
            'tanggal_daftar'    => 'required|date',
            'id_pembiayaan'     => 'required',
            'biaya_masuk'       => 'required',
            'id_prodi'          => 'required'
        ]);

        // $post= array();


        if ($request->id_registrasi_mahasiswa) {
            $edit = DB::connection('akademik')->table('siakad.list_mahasiswa')
                ->where('id_registrasi_mahasiswa', $request->id_registrasi_mahasiswa)
                ->first();

            if (empty($edit)) {
                return Redirect()->route('master_mahasiswa.index')->with('error', 'Data tidak dapat disimpan');
            }
        }

        $request['tanggal_daftar']  = Carbon::createFromFormat('d-m-Y', $request->tanggal_daftar)
            ->format('Y-m-d');
        // $data['tgl_version']    = Carbon::createFromFormat('d-m-Y', $request->tgl_version)
        //     ->format('Y-m-d');
      
        $data = $request->input();
        unset($data['_token']);

        $request['id_mahasiswa'] = $request->id_mahasiswa;
        $biodata_mahasiswa       = (new MasterDataController)->GetBioMahasiswa($request);

        $data['nama_mahasiswa'] = $biodata_mahasiswa['nama_mahasiswa'];
        $data['jenis_kelamin']  = $biodata_mahasiswa['jenis_kelamin'];
        $data['tanggal_lahir']  = $biodata_mahasiswa['tanggal_lahir'];
        $data['id_agama']       = $biodata_mahasiswa['id_agama'];
        $data['nama_agama']     = $biodata_mahasiswa['nama_agama'];

        $request['id_prodi'] = $request->id_prodi;
        $program_studi        = (new MasterDataController)->GetProgramStudi($request);

        $data['nama_program_studi'] = $program_studi['nama_program_studi'];

        $data['id_status_mahasiswa']   = "A";
        $data['nama_status_mahasiswa'] = "Aktif";
        $data['biaya_masuk'] = floatval($request->biaya_masuk);

        $request['id_tahun_akademik'] = $request->id_tahun_akademik;
        $tahun_akademik        =  (new MasterDataController)->GetTahunAkademik($request);

        $data['id_periode_masuk'] = $tahun_akademik['id_semester'];
        $data['nama_periode_masuk'] = $tahun_akademik['nama_semester'];
if($request->id_perguruan_tinggi_asal != ""){

    $ptasal = explode("|", $request->id_perguruan_tinggi_asal);
    $data['id_perguruan_tinggi_asal'] = $ptasal[0];
    $data['kode_pt'] = $ptasal[1];
    $data['nama_perguruan_tinggi_asal'] = $ptasal[2];
}

        // dd($data);
        if ($request->id_registrasi_mahasiswa) {
            try {
                $insert = DB::connection('akademik')->table('siakad.list_mahasiswa')->where('id_registrasi_mahasiswa', $request->id_registrasi_mahasiswa)->update($data);
                return Redirect()->route('master_mahasiswa.index')->with('success', 'Master Mahasiswa Berhasil Diubah');
            } catch (Exception $e) {
                $this->res  = $e->getMessage();
                $this->state = "0";
                dd( $this->res);
                return Redirect('master_mahasiswa')->with($this->res);
            }
        } else {
            try {
                $insert = DB::connection('akademik')->table('siakad.list_mahasiswa')->insert($data);
                return Redirect()->route('master_mahasiswa.index')->with('success', 'Master Mahasiswa Berhasil Disimpan');
            } catch (Exception $e) {
                $this->res  = $e->getMessage();
                $this->state = "0";
                dd($this->res);
                return Redirect()->route('master_mahasiswa/add_master_mahasiswa')->with($this->res);
            }
        }
    }

    public function DeleteMasterMahasiswa($id)
    {
        try {
            $delete = DB::connection('akademik')->table('siakad.list_mahasiswa')->where('id_registrasi_mahasiswa', $id)->delete();
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
