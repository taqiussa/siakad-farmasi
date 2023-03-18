<?php

namespace App\Http\Controllers\Main;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class AdminController extends Controller
{
    public function dashboard(){
        return view('dashboard');
    }

    public function login(Request $request){
        if ($request->isMethod('post')){
            // $data = $request->all();
            // echo "<pre>";print_r($data);die();
        }
        return view('login.login');
    }


}
