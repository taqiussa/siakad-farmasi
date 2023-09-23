<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\MasterMahasiswa;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Exception;
// use DB;

class MasterDataController extends Controller
{
    public $search = '';

    public function __construct()
    {

        $this->middleware('auth');
    }

    function GetBioMahasiswa(Request $request)
    {
        // dd($request);

        if ($request->ajax()) {
            $data = DB::connection('akademik')->table('siakad.biodata_mahasiswa')
                ->select('id_mahasiswa as id', 'nama_mahasiswa as text')
                ->where('nama_mahasiswa', 'ILIKE', '%' . $request->search . '%')
                ->orderBy('siakad.biodata_mahasiswa.nama_mahasiswa', 'asc')
                ->limit(10)
                ->get();

            $this->data["list"]    = $data;

            return response()->json($this->data["list"]);
        } elseif ($request->id_mahasiswa) {
            // dd($request->select);
            $data = DB::connection('akademik')->table('siakad.biodata_mahasiswa')
                ->where('id_mahasiswa', '=',  $request->id_mahasiswa)
                ->first();

            $jenis_pendaftaran = json_decode(json_encode($data), true);

            return $jenis_pendaftaran;
        }
    }


    function GetListMahasiswa(Request $request)
    {
        // dd($request);

        if (!$request->id_prodi) {
            $data = DB::connection('akademik')->table('siakad.list_mahasiswa')
                ->select('id_mahasiswa as id', 'nama_mahasiswa as text')
                ->where('nama_mahasiswa', 'ILIKE', '%' . $request->search . '%')
                ->orderBy('siakad.biodata_mahasiswa.nama_mahasiswa', 'asc')
                ->limit(10)
                ->get();

            $this->data["list"]    = $data;

            return response()->json($this->data["list"]);
        } elseif ($request->id_prodi) {
            // dd($request->id_mahasiswa);
            $data = DB::connection('akademik')->table('siakad.list_mahasiswa')
                ->select('id_registrasi_mahasiswa as id',   DB::raw("CONCAT(nim,' - ',nama_mahasiswa)  as value"))
                ->where('id_prodi', '=',  $request->id_prodi)
                ->where('id_tahun_akademik', '=',  $request->id_tahun_akademik)
                ->get();

            $mahasiswa = json_decode(json_encode($data), true);

            return $mahasiswa;
        }
    }

    function GetUniversitas(Request $request)
    {
        if ($request->ajax()) {
            $response = $this->TokenFeeder();
            $token    = 'Authorization: Bearer ' . str_replace('"', '', $response);

            $curl = curl_init();

            $search = str_replace(' ', '+', $request->search);
            curl_setopt_array($curl, array(
                CURLOPT_URL            => 'http://feeder.untad.ac.id:8082/ws/history_pendidikan/search/perguruan_tinggi?nm_lemb=%' . $search . '%',
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_ENCODING       => '',
                CURLOPT_MAXREDIRS      => 10,
                CURLOPT_TIMEOUT        => 0,
                CURLOPT_FOLLOWLOCATION => true,
                CURLOPT_HTTP_VERSION   => CURL_HTTP_VERSION_1_1,
                CURLOPT_CUSTOMREQUEST  => 'GET',
                CURLOPT_HTTPHEADER     => array($token),
            ));

            $universitas = curl_exec($curl);

            curl_close($curl);
            $universitas = json_decode($universitas, true);

            $response = array();
            if ($universitas) {
                foreach ($universitas['perguruan_tinggi'][0] as $row) {
                    $response[] = array(
                        "id"   => $row['id_sp'] . "|" . trim($row['npsn']) . "|" . trim($row['nm_lemb']),
                        "text" => trim($row['npsn']) . " - " . $row['nm_lemb']
                    );
                }
            }
            return response()->json($response);
        }
    }

    function TokenFeeder()
    {
        $curl = curl_init();

        curl_setopt_array($curl, array(
            CURLOPT_URL            => 'http://feeder.unissula.ac.id:8100/ws/user/update_token',
            // CURLOPT_URL            => 'http://feeder.untad.ac.id:8082/ws/user/update_token',
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING       => '',
            CURLOPT_MAXREDIRS      => 10,
            CURLOPT_TIMEOUT        => 0,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION   => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST  => 'POST',
        ));

        $response = curl_exec($curl);

        curl_close($curl);
        return $response;
    }

    function GetProdiUniversitas(Request $request)
    {
        $response = $this->TokenFeeder();
        $token    = 'Authorization: Bearer ' . str_replace('"', '', $response);

        $curl = curl_init();

        $search = explode("|", $request->search);
        // dd($search[0]);
        // $search = trim(str_replace(' ', '+', ));
        curl_setopt_array($curl, array(
            CURLOPT_URL            => 'http://feeder.unissula.ac.id:8100/ws/history_pendidikan/select/perguruan_tinggi/' . $search[0] . '/20222',
            // CURLOPT_URL            => 'http://feeder.untad.ac.id:8082/ws/history_pendidikan/select/perguruan_tinggi/' . $search[0] . '/20222',
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING       => '',
            CURLOPT_MAXREDIRS      => 10,
            CURLOPT_TIMEOUT        => 0,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION   => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST  => 'GET',
            CURLOPT_HTTPHEADER     => array($token),
        ));

        $response = curl_exec($curl);
        curl_close($curl);

        $json = json_decode($response, true);
        // dd($response);
        $response = array();
        if ($json['prodi_perguruan_tinggi']) {
            foreach ($json['prodi_perguruan_tinggi'][0] as $row) {
                $response[] = array(
                    "id" => $row['id_sms'],
                    "text" => $row['nm_programstudi'] . " - " . $row['nm_lemb']
                );
            }
        }

        return response()->json($response);
    }

    function GetJenisPendaftaran()
    {
        $jenis_pendaftaran = DB::connection('akademik')->table("siakad.master_jenis_perndaftaran")
            ->select('id_jenis_daftar as id', 'nama_jenis_daftar as value')
            ->get();
        $jenis_pendaftaran = json_decode(json_encode($jenis_pendaftaran), true);

        return $jenis_pendaftaran;
    }

    function GetJalurMasuk()
    {
        $jalur_masuk = DB::connection('akademik')->table("siakad.master_jalur_masuk")
            ->select('id_jalur_masuk as id', 'nama_jalur_masuk as value')
            ->get();
        $jalur_masuk = json_decode(json_encode($jalur_masuk), true);
        return $jalur_masuk;
    }

    function GetTahunAkademik(Request $request = null)
    {
        if (!$request) {
            $tahun_akademik = DB::connection('akademik')->table("siakad.master_tahun_akademik")
                ->select('id_tahun_akademik as id', 'nama_semester as value')
                ->get();
            $tahun_akademik = json_decode(json_encode($tahun_akademik), true);
        } elseif ($request->id_tahun_akademik) {
            $data = DB::connection('akademik')->table('siakad.master_tahun_akademik')
                ->where('id_tahun_akademik', '=',  $request->id_tahun_akademik)
                ->first();
            $tahun_akademik = json_decode(json_encode($data), true);
        }
        return $tahun_akademik;
    }

    function GetKodePembayaran(Request $request = null)
    {
        if (!$request) {
            $kode_pembayaran = DB::connection('akademik')->table("siakad.master_kode_pembayaran")
                ->select('id_kode_pembayaran as id', 'kode_rekening as value')
                ->get();
            $kode_pembayaran = json_decode(json_encode($kode_pembayaran), true);
        } elseif ($request->id_kode_pembayaran) {
            $data = DB::connection('akademik')->table('siakad.master_kode_pembayaran')
                ->where('id_kode_pembayaran', '=',  $request->id_kode_pembayaran)
                ->first();
            $kode_pembayaran = json_decode(json_encode($data), true);
        }
        return $kode_pembayaran;
    }

    function GetPembiayaanMahasiswa()
    {
        $pembiayaan_mahasiswa = DB::connection('akademik')->table("siakad.master_pembiayaan_mahasiswa")
            ->select('id_pembiayaan as id', 'nama_pembiayaan as value')
            ->get();
        $pembiayaan_mahasiswa = json_decode(json_encode($pembiayaan_mahasiswa), true);
        return $pembiayaan_mahasiswa;
    }

    function GetProgramStudi(Request $request = null)
    {
        if (!$request) {
            $program_studi = DB::connection('akademik')->table("siakad.master_prodi")
                ->select(
                    'id_prodi as id',
                    DB::raw("CONCAT(kode_program_studi,' - ',nama_jenjang_pendidikan, ' - ', nama_program_studi)  as value")
                )
                ->get();
            $program_studi = json_decode(json_encode($program_studi), true);
        } elseif ($request->id_prodi) {
            // dd($request->select);
            $data = DB::connection('akademik')->table('siakad.master_prodi')
                ->where('id_prodi', '=',  $request->id_prodi)
                ->first();
            $program_studi = json_decode(json_encode($data), true);
        }
        return $program_studi;
    }

    function GetJenisMatakuliah(Request $request = null)
    {
        $jenis_matakuliah = DB::connection('akademik')->table("siakad.master_jenis_matakuliah")
            ->select('id_jenis_mata_kuliah as id', 'nama_jenis_mata_kuliah as value')
            ->get();
        $jenis_matakuliah = json_decode(json_encode($jenis_matakuliah), true);

        return $jenis_matakuliah;
    }

    function GetMatakuliah(Request $request = null)
    {
        // dd($request);
        $matakuliah = DB::connection('akademik')->table("siakad.master_matakuliah")
            ->select('id_matkul as id', DB::raw("CONCAT(kode_mata_kuliah,' - ',nama_mata_kuliah, ' - ', sks_mata_kuliah, ' SKS')  as value"))
            ->where('master_matakuliah.id_prodi', '=', $request->id_prodi)
            ->get();
        $matakuliah = json_decode(json_encode($matakuliah), true);

        return $matakuliah;
    }

    function GetKurikulum(Request $request)
    {
        // dd($request);
        if($request->ajax()){

            $kurikulum = DB::connection('akademik')->table("siakad.kurikulum")
                ->select('id_kurikulum as id', 'nama_kurikulum as text')
                ->where('kurikulum.id_prodi', '=', $request->id_prodi)
                ->get();
            $kurikulum = json_decode(json_encode($kurikulum), true);
            return response()->json($kurikulum);
        }else if ($request->id_prodi){
            $kurikulum = DB::connection('akademik')->table("siakad.kurikulum")
            ->select('id_kurikulum as id', 'nama_kurikulum as value')
            ->where('kurikulum.id_prodi', '=', $request->id_prodi)
            ->get();
            $kurikulum = json_decode(json_encode($kurikulum), true);
            return($kurikulum);
        }       
    }

    
    // ===========
}
