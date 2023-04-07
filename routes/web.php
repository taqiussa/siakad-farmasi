<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\MasterAplikasiController as ControllersMasterAplikasiController;
use App\Http\Controllers\MasterMenuController as ControllersMasterMenuController;
use App\Http\Controllers\MasterGroupController as ControllersMasterGroupController;
use App\Http\Controllers\MasterPenggunaController as ControllersMasterPenggunaController;
use Illuminate\Support\Facades\Auth;
use App\Http\Middleware\AksesModul;

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

Route::controller(ControllersMasterAplikasiController::class)->group(function () {
    Route::get('master_aplikasi', 'index')->name('master_aplikasi.index');
    Route::get('get_master_aplikasi', 'GetMasterAplikasi');
    Route::get('add_master_aplikasi', 'AddMasterAplikasi');
    Route::get('edit_master_aplikasi/{id}', 'EditMasterAplikasi');
    Route::post('insert_master_aplikasi', 'InsertMasterAplikasi');
    Route::get('delete_master_aplikasi/{id}', 'DeleteMasterAplikasi');
});

Route::controller(ControllersMasterMenuController::class)->group(function () {
    Route::get('master_menu', 'index')->name('master_menu.index');
    Route::get('master_menu/get_master_aplikasi', 'GetMasterAplikasi');
    Route::get('master_menu/get_master_menu/{id}', 'GetMasterMenu');
    Route::get('master_menu/get_master_menu_pagination', 'GetMasterMenuPagination');
    Route::get('master_menu/add_master_menu/{id}', 'AddMasterMenu');
    Route::post('master_menu/insert_master_menu', 'InsertMasterMenu');
    Route::get('master_menu/edit_master_menu/{id}', 'EditMasterMenu');
    Route::get('master_menu/delete_master_menu/{id}', 'DeleteMasterMenu');
    Route::get('master_menu/get_submaster_menu/{id}', 'GetSubMasterMenu');
    Route::get('master_menu/get_sub_menu_pagination', 'GetSubMenuPagination');
    Route::get('master_menu/add_sub_menu/{id}', 'AddSubModul');
    Route::post('master_menu/insert_sub_menu', 'InsertSubMenu');
    Route::get('master_menu/edit_sub_menu/{id}', 'EditSubModul');
    Route::get('master_menu/delete_sub_menu/{id}', 'DeleteSubMenu');
});


Route::middleware(['akses'])->group(function(){
    Route::controller(ControllersMasterGroupController::class)->group(function () {
        Route::get('master_group', 'index')->name('master_menu.index');
        Route::get('master_group/get_master_aplikasi', 'GetMasterAplikasi');
        Route::get('master_group/get_master_group/{id}', 'GetMasterGroup');
        Route::get('master_group/get_master_group_pagination', 'GetMasterGroupPagination');
        Route::get('master_group/add_master_group/{id}', 'AddMasterGroup');
        Route::get('master_group/delete_master_group/{id}', 'DeleteMasterGroup');
        Route::post('master_group/insert_master_group', 'InsertMasterGroup');
        Route::get('master_group/edit_master_group/{id}', 'EditMasterGroup');
        Route::get('master_group/delete_master_group/{id}', 'DeleteMasterGroup');
        Route::get('master_group/get_akses_aplikasi/{id}', 'GetAksesAplikasi');
        Route::post('master_group/insert_akses', 'InsertAkses');
    });
    
    Route::controller(ControllersMasterPenggunaController::class)->group(function () {
        Route::get('master_pengguna', 'index')->name('master_pengguna.index');
        Route::get('master_pengguna/get_pengguna_pagination', 'GetPenggunaPagination');
        Route::get('master_pengguna/add_pengguna', 'AddPengguna');
        Route::get('master_pengguna/edit_pengguna/{id}', 'EditPengguna');
        Route::get('master_pengguna/delete_pengguna/{id}', 'DeletePengguna');
        Route::get('master_pengguna/get_master_group/{id}', 'GetAksesPengguna');
        Route::get('master_pengguna/get_group_pengguna_pagination', 'GetGroupPenggunaPagination');
        Route::post('master_pengguna/add_akses', 'AddAkses');
        Route::post('master_pengguna/get_master_group', 'GetMasterGroup');
        Route::post('master_pengguna/insert_trans_user_group', 'InsertTransUserGroup');
        Route::post('master_pengguna/insert_pengguna', 'InsertPengguna');
        Route::post('master_pengguna/update_password', 'UpdatePassword');
    });
});

// Route::get('/master_aplikasi',[ControllersMasterAplikasiController::class,'get_master_aplikasi']);
// Route::get('/ajax-pagination',array('as'=>'pagination','uses'=>'MasteraplikasiController@ajaxPagination'));


Route::get('list_bookcategory', [App\Http\Controllers\backend\BookcategoryController::class, 'BookCategoryList'])->name('bookcategory.index');
Route::get('/add_bookcategory', [App\Http\Controllers\backend\BookcategoryController::class, 'BookCategoryAdd'])->name('bookcategoryadd');
Route::post('/insert_bookcategory', [App\Http\Controllers\backend\BookcategoryController::class, 'BookCategoryInsert']);
Route::get('/edit_bookcategory/{id}', [App\Http\Controllers\backend\BookcategoryController::class, 'BookEditCategory']);
Route::post('/update_bookcategory/{id}', [App\Http\Controllers\backend\BookcategoryController::class, 'BookUpdateCategory']);
Route::get('/delete_bookcategory/{id}', [App\Http\Controllers\backend\BookcategoryController::class, 'BookDeleteCategory']);

Route::get('user_list', [App\Http\Controllers\backend\UsermanagementController::class, 'UserList'])->name('user.index');
Route::get('/edit_user/{id}', [App\Http\Controllers\backend\UsermanagementController::class, 'UserEdit']);
Route::post('/update_user/{id}', [App\Http\Controllers\backend\UsermanagementController::class, 'UserUpdate']);
Route::get('/delete_user/{id}', [App\Http\Controllers\backend\UsermanagementController::class, 'UserDelete']);
