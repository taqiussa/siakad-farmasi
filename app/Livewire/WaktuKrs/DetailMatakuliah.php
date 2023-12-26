<?php

namespace App\Livewire\WaktuKrs;

use Livewire\Component;
use App\Traits\DataTrait;
use Livewire\Attributes\Rule;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;


class DetailMatakuliah extends Component
{
    use DataTrait;

    #[Rule('required')]
    public $id_angkatan;

    #[Rule('required|max:100')]
    public $nama_krs;

    #[Rule('required')]
    public $id_prodi;

    #[Rule('required')]
    public $id_tahun_akademik;

    #[Rule('required')]
    public $tgl_mulai;

    #[Rule('required')]
    public $tgl_selesai;

    #[Rule('required')]
    public $tgl_toleransi_mulai;

    #[Rule('required')]
    public $tgl_toleransi_selesai;

    #[Rule('required')]
    public $status_data;

    #[Rule('required')]
    public $nama_semester;

    #[Rule('required')]
    public $nama_program_studi;

    // public $edit;

    public function render()
    {
        // dd($this->edit->id_waktu_krs);

        return view(
            'livewire.waktu-krs.detail-matakuliah',
            [

                // 'forminput' => $forminput,

            ]
        );
    }

    public function hydrate()
    {
        $this->dispatch('render-select2');
    }

    public function mount($id)
    {
        // $edit =  DB::connection('akademik')->table('siakad.waktu_krs')
        // ->where('id_waktu_krs', $id)
        // ->first();
        $edit = DB::connection('akademik')->table('siakad.waktu_krs')
        ->select('siakad.waktu_krs.id_waktu_krs', 'siakad.waktu_krs.nama_krs', 'siakad.waktu_krs.nama_program_studi', 'siakad.waktu_krs.nama_semester', 'siakad.waktu_krs.tgl_mulai', 'siakad.waktu_krs.tgl_selesai','siakad.waktu_krs.tgl_toleransi_mulai','siakad.waktu_krs.tgl_toleransi_selesai','siakad.waktu_krs.status_data')
            ->where('id_waktu_krs', $id)
            ->first();
        // dd(Carbon::createFromFormat('Y-m-d H:i:s', $edit->tgl_mulai)->format('d-m-Y g:i A'));

        $this->id_waktu_krs          = $edit->id_waktu_krs;
        $this->nama_krs              = $edit->nama_krs;
        // $this->id_prodi              = $edit->id_prodi;
        // $this->id_tahun_akademik     = $edit->id_tahun_akademik;
        $this->status_data           = $edit->status_data;
        $this->tgl_mulai             = Carbon::createFromFormat('Y-m-d H:i:s', $edit->tgl_mulai)->format('d-m-Y g:i A'); 
        $this->tgl_selesai           = Carbon::createFromFormat('Y-m-d H:i:s', $edit->tgl_selesai)->format('d-m-Y g:i A'); 
        $this->tgl_toleransi_mulai   = Carbon::createFromFormat('Y-m-d H:i:s', $edit->tgl_toleransi_mulai)->format('d-m-Y g:i A'); 
        $this->tgl_toleransi_selesai = Carbon::createFromFormat('Y-m-d H:i:s', $edit->tgl_toleransi_selesai)->format('d-m-Y g:i A'); 
    }


    public function simpan()
    {

        // dd($this);
        $this->nama_semester         = $this->GetTahunAkademik($this->id_tahun_akademik)->nama_semester;
        $this->nama_program_studi    = $this->GetProgramStudi($this->id_prodi)->nama_program_studi;
        $this->tgl_mulai             = Carbon::createFromFormat('d-m-Y g:i A', $this->tgl_mulai)->format('Y-m-d H:i');
        $this->tgl_selesai           = Carbon::createFromFormat('d-m-Y g:i A', $this->tgl_selesai)->format('Y-m-d H:i');
        $this->tgl_toleransi_mulai   = Carbon::createFromFormat('d-m-Y g:i A', $this->tgl_toleransi_mulai)->format('Y-m-d H:i');
        $this->tgl_toleransi_selesai = Carbon::createFromFormat('d-m-Y g:i A', $this->tgl_toleransi_selesai)->format('Y-m-d H:i');
       
        try {
            $insert = DB::connection('akademik')->table('siakad.waktu_krs')->where('id_waktu_krs', $this->id_waktu_krs)->update($this->validate());
            return Redirect()->route('waktu_krs')->with('success', 'Master Waktu KRS Berhasil Diubah');
        } catch (\Exception $e) {
            $this->res  = $e->getMessage();
            $this->state = "0";
            dd($e);
            return Redirect('waktu_krs/edit_waktu_krs/'.$this->id_waktu_krs)->with('error', 'Master Waktu KRS Gagal Diubah');
        }


        
    }
}
