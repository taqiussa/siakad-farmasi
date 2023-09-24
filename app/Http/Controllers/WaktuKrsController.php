<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class WaktuKrsController extends Controller
{
    public $search = '';
    public $data = [];

    public function __construct()
    {
        $this->data = array(
            'msg_main'         => '',
            'msg_detail'       => '',
            'menu_app'         => '',
            'submit'           => 'waktu_remidi/insert_waktu_remidi',
            'submit_mahasiswa' => 'waktu_remidi/insert_mahasiswa',
            'reload'           => 'waktu_remidi',
        );
    }
    public function index()
    {
        return view('waktu_remidi.index', $this->data);
    }

    public function tambah_data()
    {
        return view('waktu_remidi.add');
    }

}
