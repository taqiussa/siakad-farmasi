@extends('main.layout')
@section('content')
    <div class="card">
        <div class="card-header">{{ __('Dashboard') }}</div>

        <div class="card-body">
            @if (session('status'))
                <div class="alert alert-success" role="alert">
                    {{ session('status') }}
                </div>
            @endif

            <b> {{ Auth::user()->name }} </b> {{ __('You are logged in!') }}
        </div>
    </div>
@endsection
