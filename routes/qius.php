<?php

use App\Http\Controllers\WaktuKrsController;
use App\Http\Controllers\WaktuRemidiController;
use App\Livewire\WaktuKrs\WaktuKrsTable;
use App\Livewire\WaktuKrs\WaktuKrsTambahData;
use Illuminate\Support\Facades\Route;

Route::middleware(['auth', 'akses'])->group(function () {

    Route::get('waktu_krs', WaktuKrsTable::class)->name('waktu_remidi');
    Route::get('waktu_krs/add_waktu_krs', WaktuKrsTambahData::class)->name('waktu_krs.add_waktu_krs');
});
