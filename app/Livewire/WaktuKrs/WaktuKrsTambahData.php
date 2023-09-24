<?php

namespace App\Livewire\WaktuKrs;

use Livewire\Component;
use App\Traits\DataTrait;
use Livewire\Attributes\Rule;
use Illuminate\Support\Facades\DB;

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

    public function render()
    {
        return view(
            'livewire.waktu-krs.waktu-krs-tambah-data',
            [
                'listProdi' => $this->GetProgramStudi(),
                'listTahun' => $this->GetTahunAkademik()
            ]
        );
    }

    public function mount()
    {
        $this->tgl_mulai = date('Y-m-d H:i');
        $this->tgl_selesai = date('Y-m-d H:i');
        $this->tgl_toleransi_mulai = date('Y-m-d H:i');
        $this->tgl_toleransi_selesai = date('Y-m-d H:i');
    }
    public function simpan()
    {
        DB::connection('akademik')->table('siakad.waktu_krs')->insert($this->validate());

        $this->dispatch(
            'notyf',
            [
                'type' => 'success',
                'message' => 'Berhasil Simpan Data'
            ]
        );

        return to_route('waktu_remidi');
    }
}
