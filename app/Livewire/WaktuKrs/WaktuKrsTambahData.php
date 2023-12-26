<?php

namespace App\Livewire\WaktuKrs;

use Livewire\Component;
use App\Traits\DataTrait;
use Livewire\Attributes\Rule;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;


class WaktuKrsTambahData extends Component
{
    use DataTrait;

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

    public $forminput = [];

    public function render()
    {

        

        return view(
            'livewire.waktu-krs.waktu-krs-tambah-data',
            [

                'forminput' => $this->forminput,

            ]
        );
    }

    public function hydrate()
    {
        $this->dispatch('render-select2');
    }

    public function mount()
    {
        // dd( $status );
        $this->forminput = array(
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
                "required"      => '',
                "placeholder"   => 'Pilih Program Studi ',
                "name"          => 'id_prodi',
                "class"         => '',
                "property"      => 'wire:model=id_prodi ',
                "data"          => $this->GetProgramStudi(),
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Mulai Berlaku',
                "type"          => 'select',
                "required"      => '',
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
                "required"      => '',
                "placeholder"   => '',
                "name"          => 'tgl_mulai',
                "class"         => 'datetime',
                "property"      => 'wire:model.defer=tgl_mulai',
                "data"          => '',
                "value"         => '',
                "show"          => true
            ],
            [
                "caption"       => 'Tanggal Selesai',
                "type"          => 'text',
                "required"      => '',
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
                "required"      => '',
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
                "required"      => '',
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
                "required"      => '',
                "placeholder"   => 'Pilih Status Data',
                "name"          => 'status_data',
                "class"         => '',
                "property"      => 'wire:model=status_data',
                "data"          => $this->GetStatus(),
                "value"         => '',
                "show"          => true
            ]
        );
        $this->tgl_mulai             = date('d-m-Y g:i A');
        $this->tgl_selesai           = date('d-m-Y g:i A');
        $this->tgl_toleransi_mulai   = date('d-m-Y g:i A');
        $this->tgl_toleransi_selesai = date('d-m-Y g:i A');
    }

    


    public function simpan()
    {
        dd( $this  );
        $this->nama_semester         = $this->GetTahunAkademik($this->id_tahun_akademik)->nama_semester;
        $this->nama_program_studi    = $this->GetProgramStudi($this->id_prodi)->nama_program_studi;
        $this->tgl_mulai             = Carbon::createFromFormat('d-m-Y g:i A', $this->tgl_mulai)->format('Y-m-d H:i');
        $this->tgl_selesai           = Carbon::createFromFormat('d-m-Y g:i A', $this->tgl_selesai)->format('Y-m-d H:i');
        $this->tgl_toleransi_mulai   = Carbon::createFromFormat('d-m-Y g:i A', $this->tgl_toleransi_mulai)->format('Y-m-d H:i');
        $this->tgl_toleransi_selesai = Carbon::createFromFormat('d-m-Y g:i A', $this->tgl_toleransi_selesai)->format('Y-m-d H:i');

       


        try {
            DB::connection('akademik')->table('siakad.waktu_krs')->insert($this->validate());
            return to_route('waktu_krs')->with('success', 'Master Waktu KRS Berhasil Disimpan');
        } catch (\Exception $e) {
            $this->res  = $e->getMessage();
            $this->state = "0";
            return Redirect()->route('waktu_krs.add_waktu_krs')->with('error', 'Master Waktu KRS Gagal Disimpan Hubungi Administrator');
        }
    }
}
