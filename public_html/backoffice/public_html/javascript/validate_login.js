var ValidateLogin = function() {
    // function to initiate Validation Sample 1
    var msg1 = $("#error_msg1").html();
    var msg2 = $("#error_msg2").html();
    var msg3 = $("#error_msg3").html();
    ///////----for 'CHANGE USER PASSWORD' Tab - Begin/////////
    var runValidatorUserSelection = function() {

        var searchform = $('#login_form_admin');
        var errorHandler1 = $('.errorHandler', searchform);
        $('#login_form_admin').validate({
            errorElement: "span", // contain the error msg in a span tag
            errorClass: 'help-block',
            errorId: 'admin_form',
            ignore: ':hidden',
            rules: {
                admin_username: {
                    required: true,
                    maxlength: 50
                },
                admin_password: {
                    required: true,
                    maxlength: 100
                },
                captcha: {
                    required: true
                }
            },
            messages: {
                admin_username: {
                    required: capitalizeFirstLetter(trans('required', trans('user_name'))),
                    maxlength: capitalizeFirstLetter(trans('maxlength', trans('username'), "50"))
                },
                admin_password:  {
                    required: capitalizeFirstLetter(trans('required', trans('password'))),
                    maxlength: capitalizeFirstLetter(trans('maxlength', trans('password'), "100"))
                },
                captcha: {
                    required: capitalizeFirstLetter(trans('required', trans('captcha')))
                }
            },
            invalidHandler: function(event, validator) { //display error alert on form submit
                
                errorHandler1.show();
            },

            highlight: function(element) {
                $(element).closest('.help-block').removeClass('valid');
                // display OK icon
                $(element).closest('.form-group').removeClass('has-success').addClass('has-error').find('.symbol').removeClass('ok').addClass('required');
                // add the Bootstrap error class to the control group
            },
            unhighlight: function(element) { // revert the change done by hightlight
                $(element).closest('.form-group').removeClass('has-error');
                // set error class to the control group
            },
            success: function(label, element) {
                label.addClass('help-block valid');
                // mark the current input as valid and display OK icon
                //$(element).closest('.form-group').removeClass('has-error').addClass('has-success').find('.symbol').removeClass('required').addClass('ok');
                $(element).closest('.form-group').removeClass('has-error').addClass('ok');
            }
        });
    };
    return {
        //main function to initiate template pages
        init: function() {
            runValidatorUserSelection();
        }
    };
}();

var ValidateUserLogin = function() {
    // function to initiate Validation Sample 1
    var msg1 = $("#error_msg1").html();
    var msg2 = $("#error_msg2").html();
    var msg3 = $("#error_msg3").html();
    ///////----for 'CHANGE USER PASSWORD' Tab - Begin/////////
    var runValidatorUserSelection = function() {

        var searchform = $('#login_form');
        var errorHandler1 = $('.errorHandler', searchform);
        $('#login_form').validate({
            errorElement: "span", // contain the error msg in a span tag
            errorClass: 'help-block',
            errorId: 'user_form',
            ignore: ':hidden',
            rules: {
                admin_username: {
                    required: true,
                    maxlength: 50
                },
                user_username: {
                    required: true,
                    maxlength: 50
                },
                user_password: {
                    required: true,
                    maxlength: 100
                },
                captcha_user: {
                    required: true
                }
            },
            messages: {
                admin_username: {
                    required: capitalizeFirstLetter(trans('required', trans('admin_username'))),
                    maxlength: capitalizeFirstLetter(trans('maxlength', trans('admin_username'), "50"))
                },
                user_username: {
                    required: capitalizeFirstLetter(trans('required', trans('user_username'))),
                    maxlength: capitalizeFirstLetter(trans('maxlength', trans('user_username'), "50"))  
                },
                user_password: {
                    required: capitalizeFirstLetter(trans('required', trans('password'))),
                    maxlength: capitalizeFirstLetter(trans('maxlength', trans('password'), "100")) 
                },
                captcha_user: {
                    required: capitalizeFirstLetter(trans('required', trans('captcha')))
                }
            },
            invalidHandler: function(event, validator) { //display error alert on form submit
                errorHandler1.show();
            },
            highlight: function(element) {
                $(element).closest('.help-block').removeClass('valid');
                // display OK icon
                $(element).closest('.form-group').removeClass('has-success').addClass('has-error').find('.symbol').removeClass('ok').addClass('required');
                // add the Bootstrap error class to the control group
            },
            unhighlight: function(element) { // revert the change done by hightlight
                $(element).closest('.form-group').removeClass('has-error');
                // set error class to the control group
            },
            success: function(label, element) {
                label.addClass('help-block valid');
                // mark the current input as valid and display OK icon
                //$(element).closest('.form-group').removeClass('has-error').addClass('has-success').find('.symbol').removeClass('required').addClass('ok');
                $(element).closest('.form-group').removeClass('has-error').addClass('ok');
            }
        });
    };
    return {
        //main function to initiate template pages
        init: function() {
            runValidatorUserSelection();
        }
    };
}();

$(function() {

    ValidateLogin.init();
    ValidateUserLogin.init();

    $('#admin_username').keydown(function(e) {
        if (e.keyCode == 32) // 32 is the ASCII value for a space
            e.preventDefault();
    });

    $('#admin_password').keydown(function(e) {
        if (e.keyCode == 32) // 32 is the ASCII value for a space
            e.preventDefault();
    });

    $('#user_username').keydown(function(e) {
        if (e.keyCode == 32) // 32 is the ASCII value for a space
            e.preventDefault();
    });

    $('#user_password').keydown(function(e) {
        if (e.keyCode == 32) // 32 is the ASCII value for a space
            e.preventDefault();
    });

});

function restrictSpace(e) {
    if (e.keyCode == 32) // 32 is the ASCII value for a space
        e.preventDefault();
}

function getSwitchLanguage(lang) {
    var url = "";
    var base_url = $("#base_url").val();
    var current_url = $("#current_url").val();
    var current_url_full = $("#current_url_full").val();

    if (current_url != current_url_full) {
        url = current_url_full;
    } else {
        url = current_url;
    }
    var redirect_url = base_url;

    redirect_url = base_url + lang + "/" + url;

    document.location.href = redirect_url;
}