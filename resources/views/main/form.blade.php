<?php

if ($item['show'] == false) {
    $classhide = 'd-none';
} else {
    $classhide = '';
}

// var_dump($classhide);exit();

?>
@if (
    $item['type'] == 'text' ||
        $item['type'] == 'date' ||
        $item['type'] == 'datetime-local' ||
        $item['type'] == 'url' ||
        $item['type'] == 'email' ||
        $item['type'] == 'password')
    <div class="row mb-8 {{ $classhide }}" id="div_{{ $item['name'] }}">
        <div class="col-xl-4">
            <div class=" {{ $item['required'] }} fs-6 fw-bold mt-2 mb-3 ">{{ $item['caption'] }}</div>
        </div>
        <div class="col-lg-8">
            <input type="{{ $item['type'] }}" class="form-control {{ $item['class'] }}"
                placeholder="{{ $item['placeholder'] }}" id="{{ $item['name'] }}" name="{{ $item['name'] }}"
                {{ $item['property'] }} {{ $item['required'] }}
                @if (old($item['name'])) value="{{ old($item['name']) }}" @else  value="{{ $item['value'] }}" @endif />
            @error($item['name'])
                <div class="fv-plugins-message-container invalid-feedback">
                    <div data-field="text_input" data-validator="notEmpty">* {{ $message }}</div>
                </div>
            @enderror
        </div>
    </div>
    @if ($item['class'] == 'datetime' || $item['class'] == 'date')
        @push('scripts')
            <script>
                $(document).ready(function() {
                    $('#{{ $item['name'] }}').on('change', function(e) {
                        var data = document.getElementById("{{ $item['name'] }}").value;
                        console.log(data);
                        @this.set((this.name), data);
                    });
                });
            </script>
        @endpush
    @endif
@elseif ($item['type'] == 'select')
    <div class="row mb-8 {{ $classhide }}" id="div_{{ $item['name'] }}">
        <div class="col-xl-4">
            <div class="{{ $item['required'] }} fs-6 fw-bold mt-2 mb-3">{{ $item['caption'] }}</div>
        </div>
        <div class="col-lg-8" wire:ignore>
            <select class="form-select {{ $item['class'] }}" {{ $item['property'] }} {{ $item['required'] }}
                name="{{ $item['name'] }}" id="{{ $item['name'] }}" placeholder="{{ $item['placeholder'] }}"
                data-search="true" data-silent-initial-value-set="true">
                <option value=''>
                    {{ $item['placeholder'] }} </option>
                @if ($item['data'])
                    @foreach ($item['data'] as $row)
                        <option value='{{ $row->id }}'
                        @if (old($item['name'])) @if (old($item['name']) == $row->id) Selected @endif @else
                            @if ($item['value'] == $row->id) Selected @endif @endif
                            >
                            {{ $row->value }} </option>
                    @endforeach
                @endif
            </select>
            <br>
        </div>
    </div>
    @push('scripts')
        <script>
            $(document).ready(function() {
                $('#{{ $item['name'] }}').select2();
                $('#{{ $item['name'] }}').on('change', function(e) {
                    var data = $(this).select2("val");
                    @this.set((this.name), data);
                });
            });
        </script>
    @endpush
@elseif ($item['type'] == 'upload')
    <div class="row mb-8 {{ $classhide }}" id="div_{{ $item['name'] }}">
        <div class="col-xl-4">
            <div class="{{ $item['required'] }} fs-6 fw-bold mt-2 mb-3">{{ $item['caption'] }}</div>
        </div>
        <div class="col-lg-8">
            <?php
            if ($item['value']) {
                $infoPath = pathinfo(public_path("/images/logo/$item[value]"));
                $extension = $infoPath['extension'];
            } else {
                $extension = '';
            }
            
            ?>
            @if ($item['value'] && ($extension == 'jpg' || $extension == 'jpeg' || $extension == 'png' || $extension == 'svg'))
                <div class="image-input-wrapper w-125px h-125px ">
                    <img src="/images/logo/{{ $item['value'] }}" width="125" height="125" />
                </div>
            @elseif($item['value'])
                <a type="button" target="_blank" href='/images/logo/{{ $item['value'] }}'
                    class="btn btn-xs btn-info"><i class="fa fa-list-ol"></i>Lihat File</a>
            @endif
            <input type="file" name="{{ $item['name'] }}" id="{{ $item['name'] }}" {{ $item['property'] }}
                {{ $item['required'] }} value="{{ old($item['name']) }}">
            <br>
            <span class="alert-error"> {{ $item['placeholder'] }}</span>
            @error($item['name'])
                <div class="fv-plugins-message-container invalid-feedback">
                    <div data-field="text_input" data-validator="notEmpty">* {{ $message }}</div>
                </div>
            @enderror
        </div>
@endif
