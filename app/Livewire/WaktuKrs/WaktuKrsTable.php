<?php

namespace App\Livewire\WaktuKrs;

use Livewire\Component;
use Livewire\Attributes\On;
use Illuminate\Support\Facades\DB;
use Livewire\WithPagination;

class WaktuKrsTable extends Component
{
    use WithPagination;

    protected $paginationTheme = 'bootstrap';

    public $search = '';

    public function render()
    {
        return view('livewire.waktu-krs.waktu-krs-table', [
            'list' => DB::connection('akademik')->table('siakad.waktu_krs')
                ->select('siakad.waktu_krs.id_waktu_krs', 'siakad.waktu_krs.nama_krs', 'siakad.waktu_krs.nama_program_studi', 'siakad.waktu_krs.nama_semester', 'siakad.waktu_krs.tgl_mulai', 'siakad.waktu_krs.tgl_selesai', 'siakad.waktu_krs.tgl_toleransi_mulai', 'siakad.waktu_krs.tgl_toleransi_selesai', 'siakad.waktu_krs.status_data')
                ->when($this->search,  fn ($query) => $query->where('siakad.waktu_krs.nama_krs', 'ILIKE', '%' . $this->search . '%'))
                ->orderBy('siakad.waktu_krs.nama_semester', 'desc')
                ->paginate(10)
        ]);
    }

    public function confirm($id)
    {
        $this->dispatch(
            'confirm',
            [
                'title' => 'Menghapus Data',
                'text' => 'And Yakin Menghapus Data ?',
                'id' => $id,
            ]
        );
    }

    #[on('delete')]
    public function delete($id)
    {
        try {
            DB::connection('akademik')->table('siakad.waktu_krs')->where('id_waktu_krs', $id)->delete();
            return to_route('waktu_krs')->with('success', 'Berhasil Hapus Data');
        } catch (\Throwable $th) {
            return to_route('waktu_krs')->with('error', $th);
        }

    }
}
