
        $(document).ready(function() {

            $(".date").daterangepicker({
                singleDatePicker: true,
                showDropdowns: true,
                minYear: 1960,
                maxYear: parseInt(moment().format("YYYY"), 10),
                locale: {
                    format: 'DD-MM-YYYY'
                },
                timePicker: false,
            });

            $(".datetime").daterangepicker({
                singleDatePicker: true,
                showDropdowns: true,
                minYear: 1960,
                maxYear: parseInt(moment().format("YYYY"), 10),
                locale: {
                    format: 'DD-MM-YYYY hh:mm A'
                },
                timePicker: true,
            });

            VirtualSelect.init({
                ele: '.virtual',
                maxWidth: '850px',
            });

            $('.numberonly').keypress(function(e) {

                var charCode = (e.which) ? e.which : event.keyCode
                if (String.fromCharCode(charCode).match(/[^0-9]/g))

                    return false;

            });

            $('.currency').keyup(function(e) {
                $(this).val(format($(this).val()));
            });

        });


        var format = function(num) {
            var str = num.toString().replace("", ""),
                parts = false,
                output = [],
                i = 1,
                formatted = null;
            if (str.indexOf(".") > 0) {
                parts = str.split(".");
                str = parts[0];
            }
            str = str.split("").reverse();
            for (var j = 0, len = str.length; j < len; j++) {
                if (str[j] != ",") {
                    output.push(str[j]);
                    if (i % 3 == 0 && j < (len - 1)) {
                        output.push(",");
                    }
                    i++;
                }
            }
            formatted = output.reverse().join("");
            return ("" + formatted + ((parts) ? "." + parts[1].substr(0, 2) : ""));
        };

        // function loading() {
        //     $(".btn").attr("disabled", true);
        //     Swal.fire({
        //         title: 'Mohon Tunggu !',
        //         html: 'Data Sedang Diproses',
        //         icon: 'info',
        //         timerProgressBar: true,
        //         allowOutsideClick: false,
        //         didOpen: () => {
        //             Swal.showLoading()

        //         }
        //     })
        // }

        // function finish() {
        //     $(".btn").attr("disabled", false);
        //     swal.close();
        // }