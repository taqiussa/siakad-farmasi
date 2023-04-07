<script type="text/javascript">
    $(document).ready(function() {
        VirtualSelect.init({
            ele: '.virtual',
            maxWidth: '850px',
        });

        $("#id_master_aplikasi").change(function() {
            var id_master_aplikasi = document.getElementById('id_master_aplikasi').value;

            $.ajax({
                type: "post",
                url: "{{ URL::to('/master_pengguna/get_master_group') }}",
                data: {
                    "id_master_aplikasi": id_master_aplikasi,
                    '_token': "{{ csrf_token() }}"
                },
                beforeSend: function() {
                    loading();
                },
                success: function(resp) {
                    finish();
                    datas = JSON.parse(resp);
                    var datad = [];

                    datas.forEach(function(item) {
                        // console.log(item);

                        var value = {
                            value: item.id_master_group,
                            label: item.nama_group,
                        };

                        datad.push(value);
                    });
                    document.querySelector('#id_master_group').setOptions(datad);


                },
                error: function(event, textStatus, errorThrown) {
                    console.log('Pesan: ' + textStatus + ' , HTTP: ' + errorThrown);
                }
            });
        });
    });


    function add_akses(id_user) {
        $.ajax({
            type: "post",
            url: "{{ URL::to('/master_pengguna/add_akses/') }}",
            data: {
                "id_user": id_user,
                '_token': "{{ csrf_token() }}"
            },
            beforeSend: function() {
                loading()
            },
            success: function(resp) {
                finish()
                $("#modal_1_body").html(resp);
                $("#modal_1_title").html("Tambah Akses Pengguna");
                $('#modal_1').modal({
                    backdrop: 'static'
                });
                $("#modal_1").modal('show');
            },
            error: function(event, textStatus, errorThrown) {
                console.log('Pesan: ' + textStatus + ' , HTTP: ' + errorThrown);
            }
        });
    }

    function simpan_akses(id_trans_user_group) {
        // alert(id_trans_user_group);
        // return false;

        var id_user = document.getElementById('id_user').value;
        var id_master_group = document.getElementById('id_master_group').value;
        var id_master_aplikasi = document.getElementById('id_master_aplikasi').value;

        $.ajax({
            type: "post",
            url: "{{ URL::to('/' . $submit) }}",
            data: {
                "id_trans_user_group": id_trans_user_group,
                "id_master_aplikasi": id_master_aplikasi,
                "id_master_group": id_master_group,
                "id_user": id_user,
                '_token': "{{ csrf_token() }}"
            },
            beforeSend: function() {
                loading();
            },
            success: function(resp) {
                finish();
                var obj = jQuery.parseJSON(resp);
                fetch_user_data();
                if (obj.state === "1") {
                    $('#modal_1').modal('hide');
                    toastr.success(obj.msg, obj.title);
                } else {
                    toastr.error(obj.msg, obj.title);
                }
            },
            error: function(event, textStatus, errorThrown) {
                console.log('Pesan: ' + textStatus + ' , HTTP: ' + errorThrown);
            }
        });

    }

    function ubah_status(id_trans_user_group) {
        var status_data = document.getElementById(id_trans_user_group).checked;
        // alert(status_data);return false;
        $.ajax({
            type: "post",
            url: "{{ URL::to('/' . $submit) }}",
            data: {
                "id_trans_user_group": id_trans_user_group,
                "status_data": status_data,
                '_token': "{{ csrf_token() }}"
            },
            beforeSend: function() {
                loading();
            },
            success: function(resp) {
                finish();
                var obj = jQuery.parseJSON(resp);
                fetch_user_data();
                if (obj.state === "1") {
                    $('#modal_1').modal('hide');
                    toastr.success(obj.msg, obj.title);
                } else {
                    toastr.error(obj.msg, obj.title);
                }
            },
            error: function(event, textStatus, errorThrown) {
                console.log('Pesan: ' + textStatus + ' , HTTP: ' + errorThrown);
            }
        });

    }

    function reset_password(id_user) {
        Swal.fire({
            title: "Konfirmasi Reset",
            text: "Lanjutkan Mereset Password, Password akan direset sama dengan username",
            icon: "question",
            showCancelButton: true,
            confirmButtonColor: "#c9302c",
            confirmButtonText: "Ya, Lanjutkan",
            cancelButtonText: "Tidak, Batalkan"
        }).then((result) => {
            if (result.value) {

                $.ajax({
                    type: "post",
                    url: "{{ URL::to('/master_pengguna/update_password/') }}",
                    data: {
                        "id_user": id_user,
                        '_token': "{{ csrf_token() }}"
                    },
                    beforeSend: function() {
                        loading()
                    },
                    success: function(resp) {
                        finish()
                        var obj = jQuery.parseJSON(resp);
                        if (obj.state === "1") {
                            toastr.success(obj.msg, obj.title);
                        } else {
                            toastr.error(obj.msg, obj.title);
                        }
                    },
                    error: function(event, textStatus, errorThrown) {
                        console.log('Pesan: ' + textStatus + ' , HTTP: ' + errorThrown);
                    }
                });
            }
        });
    }

    function delete_data(id_user) {
            Swal.fire({
                title: "Konfirmasi Delete",
                text: "Lanjutkan Menghapus data ?",
                icon: "error",
                showCancelButton: true,
                confirmButtonColor: "#c9302c",
                confirmButtonText: "Ya, Lanjutkan",
                cancelButtonText: "Tidak, Batalkan"
            }).then((result) => {
                if (result.value) {
                    $.ajax({
                        type: "get",
                        url: "/master_pengguna/delete_pengguna/" + id_user,
                        beforeSend: function() {
                            loading();
                        },
                        success: function(resp) {
                            finish();
                            var obj = jQuery.parseJSON(resp);
                            if (obj.state === "1") {
                                toastr.success(obj.msg, obj.title);
                                fetch_user_data();
                            } else {
                                toastr.error(obj.msg, obj.title);
                            }
                        },
                        error: function(event, textStatus, errorThrown) {
                            console.log('Pesan: ' + textStatus + ' , HTTP: ' + errorThrown);
                        }
                    });
                }
            });
        }

</script>
