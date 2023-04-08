<div class="row g-6 g-xl-9">
    @foreach ($list as $item)
        <div class="col-md-6 col-xl-4">
            <a class="card border border-2 border-gray-300 border-hover">
                <div class="card-header border-0 pt-9">
                    <div class="card-title m-0">
                        <div class="symbol symbol-70px w-70px bg-light">
                            <img src="/images/logo/{{ $item->image }}" alt="image" class="p-3">
                        </div>
                    </div>
                    <div class="card-toolbar">
                        <span
                            class="badge badge-light-success fw-bolder me-auto px-4 py-3">{{ $item->nama_aplikasi . ' - ' . $item->deskripsi }}</span>
                    </div>
                    <div class="form-check form-switch form-check-custom form-check-solid">
                        <input class="form-check-input" type="checkbox"
                            onchange="ubah_status('{{ $item->id_trans_user_group }}');"
                            name="{{ $item->id_trans_user_group }}" id="{{ $item->id_trans_user_group }}"
                            @if ($item->status_data == 'Aktif') checked="checked" @endif>
                    </div>
                </div>
                <div class="card-body p-9">
                    <div class="fs-3 fw-bolder text-dark">{{ $item->nama_group }}</div>
                    <p class="text-gray-400 fw-bold fs-5 mt-1 mb-7">{{ $item->deskripsi_group }}</p>
                    <div class="h-4px w-100 bg-light mb-5" data-bs-toggle="tooltip" title=""
                        data-bs-original-title="">
                        <div class="bg-success rounded h-4px" role="progressbar" style="width: 100%" aria-valuenow="100"
                            aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                    {{-- <div class="d-flex flex-center mb-5">
                        <button class="btn btn-sm btn-light-primary"><span class="svg-icon svg-icon-3">
                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                    <polygon points="0 0 24 0 24 24 0 24"></polygon>
                                    <path d="M9.26193932,16.6476484 C8.90425297,17.0684559 8.27315905,17.1196257 7.85235158,16.7619393 C7.43154411,16.404253 7.38037434,15.773159 7.73806068,15.3523516 L16.2380607,5.35235158 C16.6013618,4.92493855 17.2451015,4.87991302 17.6643638,5.25259068 L22.1643638,9.25259068 C22.5771466,9.6195087 22.6143273,10.2515811 22.2474093,10.6643638 C21.8804913,11.0771466 21.2484189,11.1143273 20.8356362,10.7474093 L17.0997854,7.42665306 L9.26193932,16.6476484 Z" fill="#000000" fill-rule="nonzero" opacity="0.5" transform="translate(14.999995, 11.000002) rotate(-180.000000) translate(-14.999995, -11.000002)"></path>
                                    <path d="M4.26193932,17.6476484 C3.90425297,18.0684559 3.27315905,18.1196257 2.85235158,17.7619393 C2.43154411,17.404253 2.38037434,16.773159 2.73806068,16.3523516 L11.2380607,6.35235158 C11.6013618,5.92493855 12.2451015,5.87991302 12.6643638,6.25259068 L17.1643638,10.2525907 C17.5771466,10.6195087 17.6143273,11.2515811 17.2474093,11.6643638 C16.8804913,12.0771466 16.2484189,12.1143273 15.8356362,11.7474093 L12.0997854,8.42665306 L4.26193932,17.6476484 Z" fill="#000000" fill-rule="nonzero" transform="translate(9.999995, 12.000002) rotate(-180.000000) translate(-9.999995, -12.000002)"></path>
                                </g>
                            </svg>
                        </span>Login Aplikasi</button>
                    </div> --}}
                </div>

            </a>
        </div>
    @endforeach
</div>
<div class="d-flex flex-stack flex-wrap pt-10">
    {{ $list->links() }}
</div>
