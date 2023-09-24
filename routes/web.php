<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\HomeController as ControllersHomeController;
use App\Http\Controllers\MasterAplikasiController as ControllersMasterAplikasiController;
use App\Http\Controllers\MasterBiodataMahasiswaController as ControllersMasterBiodataMahasiswaController;
use App\Http\Controllers\MasterMahasiswaController as ControllersMasterMahasiswaController;
use App\Http\Controllers\MasterMatakuliahController as ControllersMasterMatakuliahController;
use App\Http\Controllers\MasterKodePembayaranController as ControllersMasterKodePembayaranController;
use App\Http\Controllers\MasterKurikulumController as ControllersMasterKurikulumController;
use App\Http\Controllers\MasterAngkatanMahasiswaController as ControllersMasterAngkatanMahasiswaController;
use App\Http\Controllers\MasterWaktuKrsController as ControllersWaktuKrsController;
use App\Http\Controllers\MasterDataController as ControllersMasterDataController;
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

Route::controller(ControllersHomeController::class)->group(function () {
    Route::get('home', 'index')->name('home.index');
    Route::get('home/get_group_pengguna_pagination', 'GetGroupPenggunaPagination');
});

// Route::controller(ControllersMasterMahasiswaController::class)->group(function () {
//     Route::get('master_mahasiswa', 'index')->name('master_mahasiswa.index');
//     // Route::get('get_master_mahasiswa', 'GetMasterMahasiswa');
//     // Route::get('add_master_mahasiswa', 'AddMasterMahasiswa');
//     // Route::get('edit_master_mahasiswa/{id}', 'EditMasterMahasiswa');
//     // Route::post('insert_master_mahasiswa', 'InsertMasterMahasiswa');
//     // Route::get('delete_master_mahasiswa/{id}', 'DeleteMasterMahasiswa');
// });


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


Route::controller(ControllersMasterDataController::class)->group(function () {
    Route::post('master_data/get_bio_mahasiswa', 'GetBioMahasiswa');
    Route::post('master_data/get_universitas', 'GetUniversitas');
    Route::post('master_data/get_prodi_universitas', 'GetProdiUniversitas');
    Route::post('master_data/get_kurikulum', 'GetKurikulum');
    // master_data/get_bio_mahasiswa
    // Route::get('delete_master_mahasiswa/{id}', 'DeleteMasterMahasiswa');
});

Route::middleware(['akses'])->group(function(){

    Route::controller(ControllersWaktuKrsController::class)->group(function () {
        Route::get('waktu_krs', 'index')->name('waktu_krs.index');
        Route::get('waktu_krs/add_waktu_krs', 'AddMasterAngkatanMahasiswa')->name('waktu_krs.add_waktu_krs');
        Route::get('waktu_krs/get_waktu_krs', 'GetMasterWaktuKrs');
        Route::get('waktu_krs/edit_waktu_krs/{id}', 'EditMasterWaktuKrs');
        Route::post('waktu_krs/insert_waktu_krs', 'InsertMasterWaktuKrs');
        Route::get('waktu_krs/delete_waktu_krs/{id}', 'DeleteMasterWaktuKrs');
        Route::get('waktu_krs/detail_matakuliah/{id}', 'DetailMatakuliah');
        Route::get('waktu_krs/get_matakuliah_pagination', 'GetMatakuliahPagination');
        // Route::post('waktu_krs/insert_mahasiswa', 'InsertMahasiswa');
        // Route::get('waktu_krs/delete_mahasiswa/{id}', 'DeleteMahasiswa');
        // Route::get('waktu_krs/detail_tagihan_angkatan/{id}', 'DetailTagihanAngkatan');
        // Route::get('waktu_krs/get_tagihan_angkatan_pagination', 'GetTagihanAngkatanPagination');
        // Route::post('waktu_krs/insert_tagihan', 'InsertTagihan');
        // Route::get('waktu_krs/delete_tagihan/{id}', 'DeleteTagihan');
    });

    Route::controller(ControllersMasterKodePembayaranController::class)->group(function () {
        Route::get('master_kode_pembayaran', 'index')->name('master_kode_pembayaran.index');
        Route::get('master_kode_pembayaran/add_master_kode_pembayaran', 'AddMasterKodePembayaran')->name('master_kode_pembayaran.add_master_kode_pembayaran');
        Route::get('master_kode_pembayaran/get_master_kode_pembayaran', 'GetMasterKodePembayaran');
        Route::get('master_kode_pembayaran/edit_master_kode_pembayaran/{id}', 'EditMasterKodePembayaran');
        Route::post('master_kode_pembayaran/insert_master_kode_pembayaran', 'InsertMasterKodePembayaran');
        Route::get('master_kode_pembayaran/delete_master_kode_pembayaran/{id}', 'DeleteMasterKodePembayaran');
    });

    Route::controller(ControllersMasterAngkatanMahasiswaController::class)->group(function () {
        Route::get('master_angkatan_mahasiswa', 'index')->name('master_angkatan_mahasiswa.index');
        Route::get('master_angkatan_mahasiswa/add_master_angkatan_mahasiswa', 'AddMasterAngkatanMahasiswa')->name('master_angkatan_mahasiswa.add_master_angkatan_mahasiswa');
        Route::get('master_angkatan_mahasiswa/get_master_angkatan_mahasiswa', 'GetMasterAngkatanMahasiswa');
        Route::get('master_angkatan_mahasiswa/edit_master_angkatan_mahasiswa/{id}', 'EditMasterAngkatanMahasiswa');
        Route::post('master_angkatan_mahasiswa/insert_master_angkatan_mahasiswa', 'InsertMasterAngkatanMahasiswa');
        Route::get('master_angkatan_mahasiswa/delete_master_angkatan_mahasiswa/{id}', 'DeleteMasterAngkatanMahasiswa');
        Route::get('master_angkatan_mahasiswa/detail_mahasiswa/{id}', 'DetailMahasiswa');
        Route::get('master_angkatan_mahasiswa/get_mahasiswa_angkatan_pagination', 'GetMahasiswaAngkatanPagination');
        Route::post('master_angkatan_mahasiswa/insert_mahasiswa', 'InsertMahasiswa');
        Route::get('master_angkatan_mahasiswa/delete_mahasiswa/{id}', 'DeleteMahasiswa');
        Route::get('master_angkatan_mahasiswa/detail_tagihan_angkatan/{id}', 'DetailTagihanAngkatan');
        Route::get('master_angkatan_mahasiswa/get_tagihan_angkatan_pagination', 'GetTagihanAngkatanPagination');
        Route::post('master_angkatan_mahasiswa/insert_tagihan', 'InsertTagihan');
        Route::get('master_angkatan_mahasiswa/delete_tagihan/{id}', 'DeleteTagihan');
    });


    Route::controller(ControllersMasterKurikulumController::class)->group(function () {
        Route::get('master_kurikulum', 'index')->name('master_kurikulum.index');
        Route::get('master_kurikulum/add_master_kurikulum', 'AddMasterKurikulum')->name('master_kurikulum.add_master_kurikulum');
        Route::get('master_kurikulum/get_master_kurikulum', 'GetMasterKurikulum');
        Route::get('master_kurikulum/edit_master_kurikulum/{id}', 'EditMasterKurikulum');
        Route::post('master_kurikulum/insert_master_kurikulum', 'InsertMasterKurikulum');
        Route::get('master_kurikulum/delete_master_kurikulum/{id}', 'DeleteMasterKurikulum');
        Route::get('master_kurikulum/detail_kurikulum/{id}', 'DetailKurikulum');
        Route::get('master_kurikulum/get_matakuliah_kurikulum_pagination', 'GetMatakuliahKurikulumPagination');
        Route::post('master_kurikulum/add_matakuliah_kurikulum', 'AddMatakuliahKurikulum');
        Route::post('master_kurikulum/insert_matakuliah_kurikulum', 'InsertMatakuliahKurikulum');
        Route::get('master_kurikulum/delete_matakuliah_kurikulum/{id}', 'DeleteMatakuliahKurikulum');
    });

    Route::controller(ControllersMasterMatakuliahController::class)->group(function () {
        Route::get('master_matakuliah', 'index')->name('master_matakuliah.index');
        Route::get('master_matakuliah/add_master_matakuliah', 'AddMasterMatakuliah')->name('master_matakuliah.add_master_matakuliah');
        Route::get('master_matakuliah/get_master_matakuliah', 'GetMasterMatakuliah');
        Route::get('master_matakuliah/edit_master_matakuliah/{id}', 'EditMasterMatakuliah');
        Route::post('master_matakuliah/insert_master_matakuliah', 'InsertMasterMatakuliah');
        Route::get('master_matakuliah/delete_master_matakuliah/{id}', 'DeleteMasterMatakuliah');
    });
   
    Route::controller(ControllersMasterMahasiswaController::class)->group(function () {
        Route::get('master_mahasiswa', 'index')->name('master_mahasiswa.index');
        Route::get('master_mahasiswa/add_master_mahasiswa', 'AddMasterMahasiswa');
        Route::get('master_mahasiswa/get_master_mahasiswa', 'GetMasterMahasiswa');
        Route::get('master_mahasiswa/edit_master_mahasiswa/{id}', 'EditMasterMahasiswa');
        Route::post('master_mahasiswa/insert_master_mahasiswa', 'InsertMasterMahasiswa');
        Route::get('master_mahasiswa/delete_master_mahasiswa/{id}', 'DeleteMasterMahasiswa');
    });

    Route::controller(ControllersMasterBiodataMahasiswaController::class)->group(function () {
        Route::get('master_biodata_mahasiswa', 'index')->name('master_biodata_mahasiswa.index');
        Route::get('master_biodata_mahasiswa/add_master_biodata_mahasiswa', 'AddMasterBiodataMahasiswa');
        Route::get('master_biodata_mahasiswa/get_master_biodata_mahasiswa', 'GetMasterBiodataMahasiswa');
        Route::get('master_biodata_mahasiswa/edit_master_biodata_mahasiswa/{id}', 'EditMasterBiodataMahasiswa');
        Route::post('master_biodata_mahasiswa/insert_master_biodata_mahasiswa', 'InsertMasterBiodataMahasiswa');
        Route::get('master_biodata_mahasiswa/delete_master_biodata_mahasiswa/{id}', 'DeleteMasterBiodataMahasiswa');
    });

    
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


require __DIR__ . '/qius.php';