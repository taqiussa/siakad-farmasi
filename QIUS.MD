1. cek app.js dari folder resources/js
2. cek notyf.js dari folder yang sama
3. di layout.blade.php tak tambahkan  
    @vite(['resources/css/app.css', 'resources/js/app.js'])
    di atas <head> ini compile dari vite.config.js
ke 3 step di atas untuk membuat sweetalert confirm dan toastr event success, error, dan warning

4. tak gaweke livewire component jenenge WaktuRemidi/Table, berarti ono folder views/livewire/waktu-remidi/table.blade.php
5. di dalam controller WaktuRemidi/Table.php, ono 2 function confirm dan delete, isinya dispatch.
6. di atas ada protected $listeners seng tak comment itu cara lama v2 , cara baru v3 nganggo #[on('delete')] di atas public function delete