<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\MasterBiodataMahasiswa;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Exception;
// use DB;

class MasterBiodataMahasiswaController extends Controller
{
    public $search = '';

    public function __construct()
    {
        
        $this->middleware('auth');

        $this->data = array(
            'msg_main'      => '',
            'msg_detail'    => '',
            'menu_app'      => '',
            'submit'        => 'master_biodata_mahasiswa/insert_master_biodata_mahasiswa',
            'reload'        => 'master_biodata_mahasiswa',
        );
    }

    function index()
    {
        return view('master_biodata_mahasiswa.index',  $this->data);
    }

    function GetMasterBiodataMahasiswa(Request $request)
    {

        if ($request->ajax()) {
            $data = DB::connection('akademik')->table('siakad.biodata_mahasiswa')
            ->leftJoin('siakad.list_mahasiswa', 'siakad.biodata_mahasiswa.id_mahasiswa','=','siakad.list_mahasiswa.id_mahasiswa')
                ->select('siakad.biodata_mahasiswa.id_mahasiswa','siakad.biodata_mahasiswa.nama_mahasiswa','siakad.biodata_mahasiswa.jenis_kelamin','siakad.biodata_mahasiswa.nama_agama','siakad.biodata_mahasiswa.tanggal_lahir','siakad.list_mahasiswa.nama_program_studi')
                ->when($request->search,  fn ($query) => $query->where('nama_mahasiswa', 'ILIKE', '%' . $request->search . '%'))
                ->orderBy('siakad.biodata_mahasiswa.nama_mahasiswa', 'asc')
                ->paginate(10);

            $this->data["list"]    = $data;

            return view('master_biodata_mahasiswa.master_mahasiswa_pagination',  $this->data)->render();
        }
    }

    public function AddMasterBiodataMahasiswa()
    {
        $jenis_kelamin = array(
            array('id' => 'L', 'value' => 'Laki-Laki'),
            array('id' => 'P', 'value' => 'Perempuan')
        );


        $agama = DB::connection('akademik')->table("siakad.master_agama")
            ->select('id_agama as id', 'nama_agama as value')
            ->get();
        $agama = json_decode(json_encode($agama), true);

        $negara = DB::connection('akademik')->table("siakad.negara")
            ->select('id_negara as id', 'nama_negara as value')
            ->get();
        $negara = json_decode(json_encode($negara), true);

        $kecamatan = DB::connection('akademik')->table("siakad.master_wilayah as kecamatan")
            ->join('siakad.master_wilayah as kabupaten', 'kecamatan.id_induk_wilayah', '=', 'kabupaten.id_wilayah')
            ->join('siakad.master_wilayah as provinsi', 'kabupaten.id_induk_wilayah', '=', 'provinsi.id_wilayah')
            ->select(
                'kecamatan.id_wilayah as id',
                DB::raw("CONCAT(kecamatan.nama_wilayah,' - ',kabupaten.nama_wilayah, ' - ', provinsi.nama_wilayah) as value")
            )
            ->where('kecamatan.id_level_wilayah', 3)
            ->get();
        $kecamatan = json_decode(json_encode($kecamatan), true);

        $penerima_kps = array(
            array('id' => '0', 'value' => 'Tidak'),
            array('id' => '1', 'value' => 'Ya')
        );

        $tranpostasi = DB::connection('akademik')->table("siakad.master_alat_transportasi")
            ->select('id_alat_transportasi as id', 'nama_alat_transportasi as value')
            ->get();
        $tranpostasi = json_decode(json_encode($tranpostasi), true);

        $jenistinggal = DB::connection('akademik')->table("siakad.master_jenis_tinggal")
            ->select('id_jenis_tinggal as id', 'nama_jenis_tinggal as value')
            ->get();
        $jenistinggal = json_decode(json_encode($jenistinggal), true);

        $pendidikan = DB::connection('akademik')->table("siakad.master_jenjang_pendidikan")
            ->select('id_jenjang_didik as id', 'nama_jenjang_didik as value')
            ->get();
        $pendidikan = json_decode(json_encode($pendidikan), true);

        $pekerjaan = DB::connection('akademik')->table("siakad.master_pekerjaan")
            ->select('id_pekerjaan as id', 'nama_pekerjaan as value')
            ->get();
        $pekerjaan = json_decode(json_encode($pekerjaan), true);

        $penghasilan = DB::connection('akademik')->table("siakad.master_penghasilan")
            ->select('id_penghasilan as id', 'nama_penghasilan as value')
            ->get();
        $penghasilan = json_decode(json_encode($penghasilan), true);

        // dd($kecamatan);
        $forminput = [
            [
                "caption"       => 'Nama Mahasiswa',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Lengkap Mahasiswa. Contoh : Anang Hadi yanto',
                "name"          => 'nama_mahasiswa',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true

            ],
            [
                "caption"       => 'Jenis Kelamin',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Jenis Kelamin',
                "name"          => 'jenis_kelamin',
                "class"         => '',
                "property"      => '',
                "data"          => $jenis_kelamin,
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Tempat Lahir',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Tempat Lahir : Kendal',
                "name"          => 'tempat_lahir',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Tanggal Lahir',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Tanggal Versi. Contoh : dd-mm-yyyy',
                "name"          => 'tanggal_lahir',
                "class"         => 'date',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Nama Ibu Kandung',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Ibu Kandung. Contoh : Tumainah',
                "name"          => 'nama_ibu_kandung',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Agama',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Agama',
                "name"          => 'id_agama',
                "class"         => '',
                "property"      => '',
                "data"          => $agama,
                "value"         => '',
                "show"          => true
            ]
        ];

        $forminputtabs["Alamat"] = [
            [
                "caption"       => 'Kewarganegaraan ',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Kewarganegaraan',
                "name"          => 'id_negara',
                "class"         => '',
                "property"      => '',
                "data"          => $negara,
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'NIK',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nomer Kependudukan. Contoh : 33242112900001',
                "name"          => 'nik',
                "class"         => 'numberonly',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'NISN',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nomer Induk Nasional. Contoh : 123456789',
                "name"          => 'nisn',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'NPWP',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => 'Masukan Nomer Pokok Wajib Pajak. Contoh : 123456789',
                "name"          => 'npwp',
                "class"         => 'numberonly',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Telepon',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => 'Masukan No Telepon. Contoh : 0247654321',
                "name"          => 'telepon',
                "class"         => 'numberonly',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'HP',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan No Handphone. Contoh : 089885576113',
                "name"          => 'handphone',
                "class"         => 'numberonly',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Email',
                "type"          => 'email',
                "required"      => 'required',
                "placeholder"   => 'Masukan Alamat Email. Contoh : mahasiswa@unissula.ac.id',
                "name"          => 'email',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Jalan',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => 'Masukan Nama Jalan. Contoh : Jl. Dipenogoro No 5',
                "name"          => 'jalan',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Dusun',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => 'Masukan Nama Dusun. Contoh : Meteseh',
                "name"          => 'dusun',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'RT',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => 'Masukan RT. Contoh : 1',
                "name"          => 'rt',
                "class"         => 'numberonly',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'RW',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => 'Masukan RW. Contoh : 1',
                "name"          => 'rw',
                "class"         => 'numberonly',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Kelurahan',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Kelurahan. Contoh : Meteseh',
                "name"          => 'kelurahan',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Kecamatan',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Nama Kecamatan. Contoh : Mijen',
                "name"          => 'id_wilayah',
                "class"         => '',
                "property"      => '',
                "data"          => $kecamatan,
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Kode POS',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Kode Pos. Contoh : 51381',
                "name"          => 'kode_pos',
                "class"         => 'numberonly',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Penerima KPS',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Jenis Penerima KPS. Contoh : Tidak',
                "name"          => 'penerima_kps',
                "class"         => '',
                "property"      => '',
                "data"          => $penerima_kps,
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Alat Transportasi',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Alat Transportasi. Contoh : Mobil',
                "name"          => 'id_alat_transportasi',
                "class"         => '',
                "property"      => '',
                "data"          => $tranpostasi,
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Jenis Tinggal',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Jenis Tinggal. Contoh : Kost',
                "name"          => 'id_jenis_tinggal',
                "class"         => '',
                "property"      => '',
                "data"          => $jenistinggal,
                "value"         => '',
                "show"          => true
            ]
        ];
        $forminputtabs["Ayah"] = [
            [
                "caption"       => 'NIK ayah',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => 'Masukan NIK Ayah Aplikasi. Contoh : 3324072112900001',
                "name"          => 'nik_ayah',
                "class"         => 'numberonly',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true

            ],
            [
                "caption"       => 'Nama Ayah',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Ayah. Contoh : Jumali',
                "name"          => 'nama_ayah',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Tanggal Lahir Ayah',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Tgl Lahir Ayah. Contoh : dd-mm-yyyy',
                "name"          => 'tanggal_lahir_ayah',
                "class"         => 'date',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Pendidikan',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Pendidikan Ayah. Contoh : SMA',
                "name"          => 'id_pendidikan_ayah',
                "class"         => '',
                "property"      => '',
                "data"          => $pendidikan,
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Pekerjaan',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Pendidikan Ayah. Contoh : Karyawan Swasta',
                "name"          => 'id_pekerjaan_ayah',
                "class"         => '',
                "property"      => '',
                "data"          => $pekerjaan,
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Penghasilan',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Pendidikan Ayah. Contoh : Rp. 5,000,000 - Rp. 20,000,000',
                "name"          => 'id_penghasilan_ayah',
                "class"         => '',
                "property"      => '',
                "data"          => $penghasilan,
                "value"         => '',
                "show"          => true
            ]
        ];
        $forminputtabs["Ibu"] = [
            [
                "caption"       => 'NIK Ibu',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => 'Masukan NIK Ibu Aplikasi. Contoh : 3324072112900001',
                "name"          => 'nik_ibu',
                "class"         => 'numberonly',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true

            ],
            [
                "caption"       => 'Tanggal Lahir Ibu',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Tgl Lahir Ibu. Contoh : dd-mm-yyyy',
                "name"          => 'tanggal_lahir_ibu',
                "class"         => 'date',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Pendidikan',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Pendidikan ibu. Contoh : SMA',
                "name"          => 'id_pendidikan_ibu',
                "class"         => '',
                "property"      => '',
                "data"          => $pendidikan,
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Pekerjaan',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Pendidikan Ibu. Contoh : Karyawan Swasta',
                "name"          => 'id_pekerjaan_ibu',
                "class"         => '',
                "property"      => '',
                "data"          => $pekerjaan,
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Penghasilan',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Pendidikan Ibu. Contoh : Rp. 5,000,000 - Rp. 20,000,000',
                "name"          => 'id_penghasilan_ibu',
                "class"         => '',
                "property"      => '',
                "data"          => $penghasilan,
                "value"         => '',
                "show"          => true
            ]
        ];
        $forminputtabs["Wali"] = [
            [
                "caption"       => 'Nama Wali',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => 'Masukan Nama Wali. Contoh : Jumali',
                "name"          => 'nama_wali',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Tanggal Lahir Wali',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => 'Masukan Tgl Lahir Wali. Contoh : dd-mm-yyyy',
                "name"          => 'tanggal_lahir_wali',
                "class"         => 'date',
                "property"      => '',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Pendidikan',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Pendidikan Wali. Contoh : SMA',
                "name"          => 'id_pendidikan_wali',
                "class"         => '',
                "property"      => '',
                "data"          => $pendidikan,
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Pekerjaan',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Pendidikan Wali. Contoh : Karyawan Swasta',
                "name"          => 'id_pekerjaan_wali',
                "class"         => '',
                "property"      => '',
                "data"          => $pekerjaan,
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Penghasilan',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Pendidikan Wali. Contoh : Rp. 5,000,000 - Rp. 20,000,000',
                "name"          => 'id_penghasilan_wali',
                "class"         => '',
                "property"      => '',
                "data"          => $penghasilan,
                "value"         => '',
                "show"          => true
            ]
        ];

        $this->data['forminput']     = $forminput;
        $this->data['forminputtabs'] = $forminputtabs;
        $this->data['defaulttabs']   = "Alamat";


        return view('master_biodata_mahasiswa.add', $this->data);
    }

    public function EditMasterBiodataMahasiswa($id)
    {
        // $agama = DB::connection('akademik')->table("siakad.master_agama")
        $edit =  DB::connection('akademik')->table('siakad.biodata_mahasiswa')
            ->where('id_mahasiswa', $id)
            ->first();

        $jenis_kelamin = array(
            array('id' => 'L', 'value' => 'Laki-Laki'),
            array('id' => 'P', 'value' => 'Perempuan')
        );


        $agama = DB::connection('akademik')->table("siakad.master_agama")
            ->select('id_agama as id', 'nama_agama as value')
            ->get();
        $agama = json_decode(json_encode($agama), true);

        $negara = DB::connection('akademik')->table("siakad.negara")
            ->select('id_negara as id', 'nama_negara as value')
            ->get();
        $negara = json_decode(json_encode($negara), true);

        $kecamatan = DB::connection('akademik')->table("siakad.master_wilayah as kecamatan")
            ->join('siakad.master_wilayah as kabupaten', 'kecamatan.id_induk_wilayah', '=', 'kabupaten.id_wilayah')
            ->join('siakad.master_wilayah as provinsi', 'kabupaten.id_induk_wilayah', '=', 'provinsi.id_wilayah')
            ->select(
                'kecamatan.id_wilayah as id',
                DB::raw("CONCAT(kecamatan.nama_wilayah,' - ',kabupaten.nama_wilayah, ' - ', provinsi.nama_wilayah) as value")
            )
            ->where('kecamatan.id_level_wilayah', 3)
            ->get();
        $kecamatan = json_decode(json_encode($kecamatan), true);

        $penerima_kps = array(
            array('id' => '0', 'value' => 'Tidak'),
            array('id' => '1', 'value' => 'Ya')
        );

        $tranpostasi = DB::connection('akademik')->table("siakad.master_alat_transportasi")
            ->select('id_alat_transportasi as id', 'nama_alat_transportasi as value')
            ->get();
        $tranpostasi = json_decode(json_encode($tranpostasi), true);

        $jenistinggal = DB::connection('akademik')->table("siakad.master_jenis_tinggal")
            ->select('id_jenis_tinggal as id', 'nama_jenis_tinggal as value')
            ->get();
        $jenistinggal = json_decode(json_encode($jenistinggal), true);

        $pendidikan = DB::connection('akademik')->table("siakad.master_jenjang_pendidikan")
            ->select('id_jenjang_didik as id', 'nama_jenjang_didik as value')
            ->get();
        $pendidikan = json_decode(json_encode($pendidikan), true);

        $pekerjaan = DB::connection('akademik')->table("siakad.master_pekerjaan")
            ->select('id_pekerjaan as id', 'nama_pekerjaan as value')
            ->get();
        $pekerjaan = json_decode(json_encode($pekerjaan), true);

        $penghasilan = DB::connection('akademik')->table("siakad.master_penghasilan")
            ->select('id_penghasilan as id', 'nama_penghasilan as value')
            ->get();
        $penghasilan = json_decode(json_encode($penghasilan), true);

        // dd($kecamatan);
        $forminput = [
            [
                "caption"       => 'Id Mahasiswa',
                "type"          => 'hidden',
                "required"      => 'required',
                "placeholder"   => '',
                "name"          => 'id_mahasiswa',
                "class"         => 'd-none',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->id_mahasiswa,

            ], [
                "caption"       => 'Nama Mahasiswa',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Lengkap Mahasiswa. Contoh : Anang Hadi yanto',
                "name"          => 'nama_mahasiswa',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->nama_mahasiswa,

            ],
            [
                "caption"       => 'Jenis Kelamin',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Jenis Kelamin',
                "name"          => 'jenis_kelamin',
                "class"         => '',
                "property"      => '',
                "data"          => $jenis_kelamin,
                "value"         => $edit->jenis_kelamin,
            ],
            [
                "caption"       => 'Tempat Lahir',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Tempat Lahir : Kendal',
                "name"          => 'tempat_lahir',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->tempat_lahir,
            ],
            [
                "caption"       => 'Tanggal Lahir',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Tanggal Versi. Contoh : dd-mm-yyyy',
                "name"          => 'tanggal_lahir',
                "class"         => 'date',
                "property"      => '',
                "data"          => '',
                "value"         => Carbon::createFromFormat('Y-m-d', $edit->tanggal_lahir)->format('d-m-Y'),
            ],
            [
                "caption"       => 'Nama Ibu Kandung',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Ibu Kandung. Contoh : Tumainah',
                "name"          => 'nama_ibu_kandung',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->nama_ibu_kandung,
            ],
            [
                "caption"       => 'Agama',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Agama',
                "name"          => 'id_agama',
                "class"         => '',
                "property"      => '',
                "data"          => $agama,
                "value"         => $edit->id_agama,
            ]
        ];

        $forminputtabs["Alamat"] = [
            [
                "caption"       => 'Kewarganegaraan ',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Kewarganegaraan',
                "name"          => 'id_negara',
                "class"         => '',
                "property"      => '',
                "data"          => $negara,
                "value"         => $edit->id_negara,
            ],
            [
                "caption"       => 'NIK',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nomer Kependudukan. Contoh : 33242112900001',
                "name"          => 'nik',
                "class"         => 'numberonly',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->nik,
            ],
            [
                "caption"       => 'NISN',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nomer Induk Nasional. Contoh : 123456789',
                "name"          => 'nisn',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->nisn,
            ],
            [
                "caption"       => 'NPWP',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => 'Masukan Nomer Pokok Wajib Pajak. Contoh : 123456789',
                "name"          => 'npwp',
                "class"         => 'numberonly',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->npwp,
            ],
            [
                "caption"       => 'Telepon',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => 'Masukan No Telepon. Contoh : 0247654321',
                "name"          => 'telepon',
                "class"         => 'numberonly',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->telepon,
            ],
            [
                "caption"       => 'HP',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan No Handphone. Contoh : 089885576113',
                "name"          => 'handphone',
                "class"         => 'numberonly',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->handphone,
            ],
            [
                "caption"       => 'Email',
                "type"          => 'email',
                "required"      => 'required',
                "placeholder"   => 'Masukan Alamat Email. Contoh : mahasiswa@unissula.ac.id',
                "name"          => 'email',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->email,
            ],
            [
                "caption"       => 'Jalan',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => 'Masukan Nama Jalan. Contoh : Jl. Dipenogoro No 5',
                "name"          => 'jalan',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->jalan,
            ],
            [
                "caption"       => 'Dusun',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => 'Masukan Nama Dusun. Contoh : Meteseh',
                "name"          => 'dusun',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->dusun,
            ],
            [
                "caption"       => 'RT',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => 'Masukan RT. Contoh : 1',
                "name"          => 'rt',
                "class"         => 'numberonly',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->rt,
            ],
            [
                "caption"       => 'RW',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => 'Masukan RW. Contoh : 1',
                "name"          => 'rw',
                "class"         => 'numberonly',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->rw,
            ],
            [
                "caption"       => 'Kelurahan',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Kelurahan. Contoh : Meteseh',
                "name"          => 'kelurahan',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->kelurahan,
            ],
            [
                "caption"       => 'Kecamatan',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Nama Kecamatan. Contoh : Mijen',
                "name"          => 'id_wilayah',
                "class"         => '',
                "property"      => '',
                "data"          => $kecamatan,
                "value"         => $edit->id_wilayah,
            ],
            [
                "caption"       => 'Kode POS',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Kode Pos. Contoh : 51381',
                "name"          => 'kode_pos',
                "class"         => 'numberonly',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->kode_pos,
            ],
            [
                "caption"       => 'Penerima KPS',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Jenis Penerima KPS. Contoh : Tidak',
                "name"          => 'penerima_kps',
                "class"         => '',
                "property"      => '',
                "data"          => $penerima_kps,
                "value"         => $edit->penerima_kps,
            ],
            [
                "caption"       => 'Alat Transportasi',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Alat Transportasi. Contoh : Mobil',
                "name"          => 'id_alat_transportasi',
                "class"         => '',
                "property"      => '',
                "data"          => $tranpostasi,
                "value"         => $edit->id_alat_transportasi,
            ],
            [
                "caption"       => 'Jenis Tinggal',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Jenis Tinggal. Contoh : Kost',
                "name"          => 'id_jenis_tinggal',
                "class"         => '',
                "property"      => '',
                "data"          => $jenistinggal,
                "value"         => $edit->id_jenis_tinggal,
            ]
        ];
        $forminputtabs["Ayah"] = [
            [
                "caption"       => 'NIK ayah',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => 'Masukan NIK Ayah Aplikasi. Contoh : 3324072112900001',
                "name"          => 'nik_ayah',
                "class"         => 'numberonly',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->nik_ayah,

            ],
            [
                "caption"       => 'Nama Ayah',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Nama Ayah. Contoh : Jumali',
                "name"          => 'nama_ayah',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->nama_ayah,
            ],
            [
                "caption"       => 'Tanggal Lahir Ayah',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Tgl Lahir Ayah. Contoh : dd-mm-yyyy',
                "name"          => 'tanggal_lahir_ayah',
                "class"         => 'date',
                "property"      => '',
                "data"          => '',
                "value"         => Carbon::createFromFormat('Y-m-d', $edit->tanggal_lahir_ayah)->format('d-m-Y'),
            ],
            [
                "caption"       => 'Pendidikan',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Pendidikan Ayah. Contoh : SMA',
                "name"          => 'id_pendidikan_ayah',
                "class"         => '',
                "property"      => '',
                "data"          => $pendidikan,
                "value"         => $edit->id_pendidikan_ayah,
            ],
            [
                "caption"       => 'Pekerjaan',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Pendidikan Ayah. Contoh : Karyawan Swasta',
                "name"          => 'id_pekerjaan_ayah',
                "class"         => '',
                "property"      => '',
                "data"          => $pekerjaan,
                "value"         => $edit->id_pekerjaan_ayah,
            ],
            [
                "caption"       => 'Penghasilan',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Pendidikan Ayah. Contoh : Rp. 5,000,000 - Rp. 20,000,000',
                "name"          => 'id_penghasilan_ayah',
                "class"         => '',
                "property"      => '',
                "data"          => $penghasilan,
                "value"         => $edit->id_penghasilan_ayah,
            ]
        ];
        $forminputtabs["Ibu"] = [
            [
                "caption"       => 'NIK Ibu',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => 'Masukan NIK Ibu Aplikasi. Contoh : 3324072112900001',
                "name"          => 'nik_ibu',
                "class"         => 'numberonly',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->nik_ibu,

            ],
            [
                "caption"       => 'Tanggal Lahir Ibu',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => 'Masukan Tgl Lahir Ibu. Contoh : dd-mm-yyyy',
                "name"          => 'tanggal_lahir_ibu',
                "class"         => 'date',
                "property"      => '',
                "data"          => '',
                "value"         => Carbon::createFromFormat('Y-m-d', $edit->tanggal_lahir_ibu)->format('d-m-Y'),
            ],
            [
                "caption"       => 'Pendidikan',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Pendidikan ibu. Contoh : SMA',
                "name"          => 'id_pendidikan_ibu',
                "class"         => '',
                "property"      => '',
                "data"          => $pendidikan,
                "value"         => $edit->id_pendidikan_ibu,
            ],
            [
                "caption"       => 'Pekerjaan',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Pendidikan Ibu. Contoh : Karyawan Swasta',
                "name"          => 'id_pekerjaan_ibu',
                "class"         => '',
                "property"      => '',
                "data"          => $pekerjaan,
                "value"         => $edit->id_pekerjaan_ibu,
            ],
            [
                "caption"       => 'Penghasilan',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Pendidikan Ibu. Contoh : Rp. 5,000,000 - Rp. 20,000,000',
                "name"          => 'id_penghasilan_ibu',
                "class"         => '',
                "property"      => '',
                "data"          => $penghasilan,
                "value"         => $edit->id_penghasilan_ibu,
            ]
        ];
        $forminputtabs["Wali"] = [
            [
                "caption"       => 'Nama Wali',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => 'Masukan Nama Wali. Contoh : Jumali',
                "name"          => 'nama_wali',
                "class"         => '',
                "property"      => '',
                "data"          => '',
                "value"         => $edit->nama_wali,
            ],
            [
                "caption"       => 'Tanggal Lahir Wali',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => 'Masukan Tgl Lahir Wali. Contoh : dd-mm-yyyy',
                "name"          => 'tanggal_lahir_wali',
                "class"         => 'date',
                "property"      => '',
                "data"          => '',
                "value"         => Carbon::createFromFormat('Y-m-d', $edit->tanggal_lahir_wali)->format('d-m-Y'),
            ],
            [
                "caption"       => 'Pendidikan',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Pendidikan Wali. Contoh : SMA',
                "name"          => 'id_pendidikan_wali',
                "class"         => '',
                "property"      => '',
                "data"          => $pendidikan,
                "value"         => $edit->id_pendidikan_wali,
            ],
            [
                "caption"       => 'Pekerjaan',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Pendidikan Wali. Contoh : Karyawan Swasta',
                "name"          => 'id_pekerjaan_wali',
                "class"         => '',
                "property"      => '',
                "data"          => $pekerjaan,
                "value"         => $edit->id_pekerjaan_wali,
            ],
            [
                "caption"       => 'Penghasilan',
                "type"          => 'select',
                "required"      => 'required',
                "placeholder"   => 'Pilih Pendidikan Wali. Contoh : Rp. 5,000,000 - Rp. 20,000,000',
                "name"          => 'id_penghasilan_wali',
                "class"         => '',
                "property"      => '',
                "data"          => $penghasilan,
                "value"         => $edit->id_penghasilan_wali,
            ]
        ];

        $this->data['forminput']     = $forminput;
        $this->data['forminputtabs'] = $forminputtabs;
        $this->data['defaulttabs']   = "Alamat";

        return view('master_biodata_mahasiswa.add', $this->data);
    }

    public function InsertMasterBiodataMahasiswa(Request $request)
    {
        $data = array();

        $request->validate([
            'email'                => 'required|email',
            'jenis_kelamin'        => 'required',
            'id_agama'             => 'required',
            'id_negara'            => 'required',
            'id_wilayah'           => 'required',
            'penerima_kps'         => 'required',
            'id_alat_transportasi' => 'required',
            'id_jenis_tinggal'     => 'required',
            'id_pendidikan_ayah'   => 'required',
            'id_pekerjaan_ayah'    => 'required',
            'id_penghasilan_ayah'  => 'required',
            'id_pendidikan_ibu'    => 'required',
            'id_pekerjaan_ibu'     => 'required',
            'id_penghasilan_ibu'   => 'required',
            'id_pendidikan_wali'   => 'required',
            'id_pekerjaan_wali'    => 'required',
            'id_penghasilan_wali'  => 'required',
            'nama_mahasiswa'       => 'required',
            'tempat_lahir'         => 'required',
            'tanggal_lahir'        => 'required|date',
            'nama_ibu_kandung'     => 'required',
            'nik'                  => 'required|max:16',
            'nik_ayah'             => 'max:16',
            'nik_ibu'              => 'max:16',
            'nisn'                 => 'required',
            'handphone'            => 'required|numeric',
            'kelurahan'            => 'required',
            'kode_pos'             => 'required|max:5',
            'nama_ayah'            => 'required',
            'tanggal_lahir_ayah'   => 'required|date',
            'tanggal_lahir_ibu'    => 'required|date'
        ]);

        if ($request->id_mahasiswa) {
            $edit = DB::connection('akademik')->table('siakad.biodata_mahasiswa')
                ->where('id_mahasiswa', $request->id_mahasiswa)
                ->first();

            if (empty($edit)) {
                return Redirect()->route('master_biodata_mahasiswa.index')->with('error', 'Data tidak dapat disimpan');
            }
        }

        $request['tanggal_lahir']  = Carbon::createFromFormat('d-m-Y', $request->tanggal_lahir)
            ->format('Y-m-d');
        $request['tanggal_lahir_ayah']  = Carbon::createFromFormat('d-m-Y', $request->tanggal_lahir_ayah)
            ->format('Y-m-d');
        $request['tanggal_lahir_ibu']  = Carbon::createFromFormat('d-m-Y', $request->tanggal_lahir_ibu)
            ->format('Y-m-d');
        // $data['tgl_version']    = Carbon::createFromFormat('d-m-Y', $request->tgl_version)
        //     ->format('Y-m-d');
        // dd($request);
        $data = $request->input();
        unset($data['_token']);

        $agama = DB::connection('akademik')->table("siakad.master_agama")
            ->select('id_agama as id', 'nama_agama as value')
            ->where('id_agama', $request->id_agama)
            ->first();
        if ($agama) {
            $data['nama_agama'] = $agama->value;
        }

        $tranpostasi = DB::connection('akademik')->table("siakad.master_alat_transportasi")
            ->select('id_alat_transportasi as id', 'nama_alat_transportasi as value')
            ->where('id_alat_transportasi', $request->id_alat_transportasi)
            ->first();
        if ($tranpostasi) {
            $data['nama_alat_transportasi'] = $tranpostasi->value;
        }

        $jenistinggal = DB::connection('akademik')->table("siakad.master_jenis_tinggal")
            ->select('id_jenis_tinggal as id', 'nama_jenis_tinggal as value')
            ->where('id_jenis_tinggal', $request->id_jenis_tinggal)
            ->first();
        if ($jenistinggal) {
            $data['nama_jenis_tinggal'] = $jenistinggal->value;
        }

        $pendidikan = DB::connection('akademik')->table("siakad.master_jenjang_pendidikan")
            ->select('id_jenjang_didik as id', 'nama_jenjang_didik as value')
            ->where('id_jenjang_didik', $request->id_pendidikan_ayah)
            ->first();
        if ($pendidikan) {
            $data['nama_pendidikan_ayah'] = $pendidikan->value;
        }

        $pendidikan = DB::connection('akademik')->table("siakad.master_jenjang_pendidikan")
            ->select('id_jenjang_didik as id', 'nama_jenjang_didik as value')
            ->where('id_jenjang_didik', $request->id_pendidikan_ibu)
            ->first();
        if ($pendidikan) {
            $data['nama_pendidikan_ibu'] = $pendidikan->value;
        }

        $pendidikan = DB::connection('akademik')->table("siakad.master_jenjang_pendidikan")
            ->select('id_jenjang_didik as id', 'nama_jenjang_didik as value')
            ->where('id_jenjang_didik', $request->id_pendidikan_wali)
            ->first();
        if ($pendidikan) {
            $data['nama_pendidikan_wali'] = $pendidikan->value;
        }

        $pekerjaan = DB::connection('akademik')->table("siakad.master_pekerjaan")
            ->select('id_pekerjaan as id', 'nama_pekerjaan as value')
            ->where('id_pekerjaan', $request->id_pekerjaan_ayah)
            ->first();
        if ($pekerjaan) {
            $data['nama_pekerjaan_ayah'] = $pekerjaan->value;
        }

        $pekerjaan = DB::connection('akademik')->table("siakad.master_pekerjaan")
            ->select('id_pekerjaan as id', 'nama_pekerjaan as value')
            ->where('id_pekerjaan', $request->id_pekerjaan_ibu)
            ->first();
        if ($pekerjaan) {
            $data['nama_pekerjaan_ibu'] = $pekerjaan->value;
        }

        $pekerjaan = DB::connection('akademik')->table("siakad.master_pekerjaan")
            ->select('id_pekerjaan as id', 'nama_pekerjaan as value')
            ->where('id_pekerjaan', $request->id_pekerjaan_wali)
            ->first();
        if ($pekerjaan) {
            $data['nama_pekerjaan_wali'] = $pekerjaan->value;
        }

        $penghasilan = DB::connection('akademik')->table("siakad.master_penghasilan")
            ->select('id_penghasilan as id', 'nama_penghasilan as value')
            ->where('id_penghasilan', $request->id_penghasilan_ayah)
            ->first();
        if ($penghasilan) {
            $data['nama_penghasilan_ayah'] = $penghasilan->value;
        }

        $penghasilan = DB::connection('akademik')->table("siakad.master_penghasilan")
            ->select('id_penghasilan as id', 'nama_penghasilan as value')
            ->where('id_penghasilan', $request->id_penghasilan_ibu)
            ->first();
        if ($penghasilan) {
            $data['nama_penghasilan_ibu'] = $penghasilan->value;
        }

        $penghasilan = DB::connection('akademik')->table("siakad.master_penghasilan")
            ->select('id_penghasilan as id', 'nama_penghasilan as value')
            ->where('id_penghasilan', $request->id_penghasilan_wali)
            ->first();
        if ($penghasilan) {
            $data['nama_penghasilan_wali'] = $penghasilan->value;
        }

        $negara = DB::connection('akademik')->table("siakad.negara")
            ->select('id_negara as id', 'nama_negara as value')
            ->where('id_negara', $request->id_negara)
            ->first();
        if ($negara) {
            $data['kewarganegaraan'] = $negara->value;
        }

        $kecamatan = DB::connection('akademik')->table("siakad.master_wilayah as kecamatan")
            ->join('siakad.master_wilayah as kabupaten', 'kecamatan.id_induk_wilayah', '=', 'kabupaten.id_wilayah')
            ->join('siakad.master_wilayah as provinsi', 'kabupaten.id_induk_wilayah', '=', 'provinsi.id_wilayah')
            ->select(
                'kecamatan.id_wilayah as id',
                DB::raw("CONCAT(kecamatan.nama_wilayah,' - ',kabupaten.nama_wilayah, ' - ', provinsi.nama_wilayah) as value")
            )
            ->where('kecamatan.id_wilayah', $request->id_wilayah)
            ->first();
        if ($kecamatan) {
            $data['nama_wilayah'] = $kecamatan->value;
        }
        // dd($data);
        if ($request->id_mahasiswa) {
            try {
                $insert = DB::connection('akademik')->table('siakad.biodata_mahasiswa')->where('id_mahasiswa', $request->id_mahasiswa)->update($data);
                return Redirect()->route('master_biodata_mahasiswa.index')->with('success', 'Master Mahasiswa Berhasil Diubah');
            } catch (Exception $e) {
                $this->res  = $e->getMessage();
                $this->state = "0";
                return Redirect()->route('master_biodata_mahasiswa')->with($this->res);
            }
        } else {
            try {
                $insert = DB::connection('akademik')->table('siakad.biodata_mahasiswa')->insert($data);
                return Redirect()->route('master_biodata_mahasiswa.index')->with('success', 'Master Mahasiswa Berhasil Disimpan');
            } catch (Exception $e) {
                $this->res  = $e->getMessage();
                $this->state = "0";
                dd($this->res);
                return Redirect()->route('master_biodata_mahasiswa/add_master_biodata_mahasiswa')->with($this->res);
            }
        }
    }

    public function DeleteMasterBiodataMahasiswa($id)
    {
        try {
            $delete = DB::connection('akademik')->table('siakad.biodata_mahasiswa')->where('id_mahasiswa', $id)->delete();
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
