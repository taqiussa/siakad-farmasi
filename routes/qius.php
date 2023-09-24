<?php

use App\Http\Controllers\WaktuRemidiController;
use Illuminate\Support\Facades\Route;

Route::middleware(['auth'])->group(function () {

    // Menu Waktu Remidi
    Route::controller(WaktuRemidiController::class)->group(function () {
        Route::get('waktu_remidi', 'index')->name('waktu_remidi');
    });
});
