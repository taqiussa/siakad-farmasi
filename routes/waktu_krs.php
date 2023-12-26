<?php

use App\Http\Controllers\WaktuKrsController;
use App\Http\Controllers\WaktuRemidiController;
use App\Livewire\WaktuKrs\WaktuKrsTable;
use App\Livewire\WaktuKrs\WaktuKrsTambahData;
use App\Livewire\WaktuKrs\WaktuKrsEditData;
use App\Livewire\WaktuKrs\DetailMatakuliah;
use Illuminate\Support\Facades\Route;

Route::middleware(['auth', 'akses'])->group(function () {

    Route::get('waktu_krs', WaktuKrsTable::class)->name('waktu_krs');
    Route::get('waktu_krs/add_waktu_krs', WaktuKrsTambahData::class)->name('waktu_krs.add_waktu_krs');
    Route::get('waktu_krs/edit_waktu_krs/{id}', WaktuKrsEditData::class);
    Route::get('waktu_krs/detail_matakuliah/{id}', DetailMatakuliah::class);
});
