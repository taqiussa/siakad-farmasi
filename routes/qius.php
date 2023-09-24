<?php

use App\Http\Controllers\WaktuKrsController;
use App\Http\Controllers\WaktuRemidiController;
use Illuminate\Support\Facades\Route;

Route::middleware(['auth'])->group(function () {

    // Menu Waktu Remidi
    // Route::controller(WaktuRemidiController::class)->group(function () {
    //     Route::get('waktu_remidi', 'index')->name('waktu_remidi');
    //     Route::get('waktu_remidi/tambah_data', 'tambah_data')->name('waktu_remidi.tambah_data');
    // });

    Route::controller(WaktuKrsController::class)->group(function() {
        Route::get('waktu_remidi', 'index')->name('waktu_remidi');
        Route::get('waktu_remidi/tambah_data', 'tambah_data')->name('waktu_remidi.tambah_data');
    });

});
