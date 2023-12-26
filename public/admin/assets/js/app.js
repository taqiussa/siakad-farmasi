import './bootstrap';
// import './notyf';
//sweetalert2
import Swal from 'sweetalert2';
window.Swal = Swal;

window.addEventListener('confirm', event => {
    console.log(event);
    Swal.fire({
        title: event.detail.title,
        text: event.detail.text,
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Ya, Hapussasas!',
    }).then((result) => {
        if (result.isConfirmed) {
            Livewire.dispatch('delete', { id: event.detail[0].id });
        }
    });
});
