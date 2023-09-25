<?php

namespace App\Livewire\WaktuKrs;

use Livewire\Component;
use Livewire\Attributes\On;

class WaktuKrsTable extends Component
{
    public $count = 1;

    public function render()
    {
        return view('livewire.waktu-krs.waktu-krs-table');
    }

    public function confirm($id)
    {
        $this->dispatch(
            'confirm',
            [
                'title' => 'Menghapus Skor',
                'text' => 'And Yakin Menghapus Data ?',
                'id' => $id,
            ]
        );
    }

    #[on('delete')]
    public function delete($id)
    {
        $this->count = 2;
        $this->dispatch(
            'notyf',
            [
                'type' => 'error',
                'message' => 'Berhasil Menghapus Data'
            ]
        );

        // return to_route('waktu_remidi')->with('error', 'berhasil hapus data');

    }
}
