<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\MasterAplikasiController as ControllersMasterAplikasiController;
use App\Http\Controllers\MasterMenuController as ControllersMasterMenuController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Auth::routes(); 

Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');

Route::controller(ControllersMasterAplikasiController::class)->group(function(){
    Route::get('master_aplikasi', 'index')->name('master_aplikasi.index');
    Route::get('get_master_aplikasi', 'GetMasterAplikasi');
    Route::get('add_master_aplikasi', 'AddMasterAplikasi');
    Route::get('edit_master_aplikasi/{id}', 'EditMasterAplikasi');
    Route::post('insert_master_aplikasi', 'InsertMasterAplikasi');
    Route::get('delete_master_aplikasi/{id}', 'DeleteMasterAplikasi');
});

Route::controller(ControllersMasterMenuController::class)->group(function(){
    Route::get('master_menu', 'index')->name('master_menu.index');
    Route::get('get_master_menu/{id}', 'GetMasterMenu');
    Route::get('get_master_aplikasi_menu', 'GetMasterAplikasi');
    Route::get('add_master_menu/{id}', 'AddMasterMenu');
    Route::post('insert_master_menu', 'InsertMasterMenu');

    // Route::get('edit_master_aplikasi/{id}', 'EditMasterAplikasi');
    // Route::post('insert_master_aplikasi', 'InsertMasterAplikasi');
    // Route::get('delete_master_aplikasi/{id}', 'DeleteMasterAplikasi');
});

// Route::get('/master_aplikasi',[ControllersMasterAplikasiController::class,'get_master_aplikasi']);
// Route::get('/ajax-pagination',array('as'=>'pagination','uses'=>'MasteraplikasiController@ajaxPagination'));


Route::get('list_bookcategory', [App\Http\Controllers\backend\BookcategoryController::class,'BookCategoryList'])->name('bookcategory.index');
Route::get('/add_bookcategory',[App\Http\Controllers\backend\BookcategoryController::class,'BookCategoryAdd'])->name('bookcategoryadd');
Route::post('/insert_bookcategory', [App\Http\Controllers\backend\BookcategoryController::class,'BookCategoryInsert']);
Route::get('/edit_bookcategory/{id}', [App\Http\Controllers\backend\BookcategoryController::class,'BookEditCategory']);
Route::post('/update_bookcategory/{id}', [App\Http\Controllers\backend\BookcategoryController::class,'BookUpdateCategory']);
Route::get('/delete_bookcategory/{id}', [App\Http\Controllers\backend\BookcategoryController::class,'BookDeleteCategory']);

Route::get('user_list', [App\Http\Controllers\backend\UsermanagementController::class,'UserList'])->name('user.index');
Route::get('/edit_user/{id}', [App\Http\Controllers\backend\UsermanagementController::class,'UserEdit']);
Route::post('/update_user/{id}', [App\Http\Controllers\backend\UsermanagementController::class,'UserUpdate']);
Route::get('/delete_user/{id}', [App\Http\Controllers\backend\UsermanagementController::class,'UserDelete']);
