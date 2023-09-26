<?php

namespace App\Livewire\WaktuKrs;

use Livewire\Component;
use App\Traits\DataTrait;
use Livewire\Attributes\Rule;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;


class WaktuKrsEditData extends Component
{
    use DataTrait;

    #[Rule('required')]
    public $id_waktu_krs;

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

        $forminput = array(
            [
                "caption"       => 'ID Waktu KRS',
                "type"          => 'text',
                "required"      => 'required',
                "placeholder"   => '',
                "name"          => 'id_waktu_krs',
                "class"         => '',
                "property"      => 'wire:model=id_waktu_krs',
                "data"          => '',
                "value"         => '',
                "show"          => false
            ],
            [
                "caption"       => 'Nama KRS',
                "type"          => 'text',
                "required"      => '',
                "placeholder"   => 'Masukan Nama KRS. Contoh : KRS Online 2022/2023 Genap',
                "name"          => 'nama_krs',
                "class"         => '',
                "property"      => 'wire:model=nama_krs',
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
                "property"      => 'wire:model=id_prodi',
                "data"          => $this->GetProgramStudi(),
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
                "property"      => 'wire:model=id_tahun_akademik',
                "data"          => $this->GetTahunAkademik(),
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
                "property"      => 'wire:model=tgl_mulai',
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
                "property"      => 'wire:model=tgl_selesai',
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
                "property"      => 'wire:model=tgl_toleransi_mulai',
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
                "property"      => 'wire:model=tgl_toleransi_selesai',
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
                "property"      => 'wire:model=status_data',
                "data"          => $this->GetStatus(),
                "value"         => '',
                "show"          => true
            ]
        );

        return view(
            'livewire.waktu-krs.waktu-krs-tambah-data',
            [

                'forminput' => $forminput,

            ]
        );
    }

    public function hydrate()
    {
        $this->dispatch('render-select2');
    }

    public function mount($id)
    {
        $edit =  DB::connection('akademik')->table('siakad.waktu_krs')
        ->where('id_waktu_krs', $id)
        ->first();
        // dd(Carbon::createFromFormat('Y-m-d H:i:s', $edit->tgl_mulai)->format('d-m-Y g:i A'));

        $this->id_waktu_krs          = $edit->id_waktu_krs;
        $this->nama_krs              = $edit->nama_krs;
        $this->id_prodi              = $edit->id_prodi;
        $this->id_tahun_akademik     = $edit->id_tahun_akademik;
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
