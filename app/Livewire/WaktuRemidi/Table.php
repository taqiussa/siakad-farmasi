<?php

namespace App\Livewire\WaktuRemidi;

use Livewire\Component;
use Livewire\Attributes\On;
class Table extends Component
{

    public $count = 1;

    // protected $listeners = ['delete' => 'delete'];

    public function render()
    {
        return view('livewire.waktu-remidi.table');
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
    }
}
