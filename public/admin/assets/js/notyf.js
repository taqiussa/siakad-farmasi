
import 'notyf/notyf';

import { Notyf } from 'notyf';

var notyf = new Notyf({
    duration: 5000,
    position: {
        x: 'right',
        y: 'top',
    },
    dismissible: true,
    types: [
        {
            type: 'warning',
            background: 'orange',
            icon: {
                className: 'material-icons',
                tagName: 'i',
                text: 'warning'
            }
        },
    ]
});
window.addEventListener('notyf', event => {
    // notyf[event.detail.type](event.detail.message);
    notyf.open({
        type: event.detail[0].type,
        message: event.detail[0].message,
    });
});