<div class="card bg-light shadow-sm">
    <div class="card-header">
        <h3 class="card-title"></h3>
        <div class="card-toolbar">
            <a href="{{ route('waktu_krs.add_waktu_krs') }}" type="button" class="btn btn-primary"
                data-bs-toggle="tooltip" data-bs-original-title="Coming Soon" data-kt-initialized="1">
                <!--begin::Svg Icon | path: icons/duotune/arrows/arr075.svg-->
                <span class="svg-icon svg-icon-2"><svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                        xmlns="http://www.w3.org/2000/svg">
                        <rect opacity="0.5" x="11.364" y="20.364" width="16" height="2" rx="1"
                            transform="rotate(-90 11.364 20.364)" fill="currentColor"></rect>
                        <rect x="4.36396" y="11.364" width="16" height="2" rx="1"
                            fill="currentColor"></rect>
                    </svg></span>
                Tambah Master Waktu KRS
            </a>
        </div>
    </div>
    <div class="card-body card-scroll">

        {{ $count }}

        <button class="btn btn-danger" wire:click="confirm(1)">delete</button>

    </div>
    <div class="card-footer">
    </div>
</div>
