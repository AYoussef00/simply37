var ValidateSmsContentEdit = function () {

    var runValidateSmsContentEdit = function () {
        var searchform = $('#set_sms_content');
        var errorHandler1 = $('.errorHandler', searchform);
        $('#set_sms_content').validate({
            errorElement: "span",
            errorClass: 'help-block',
            errorPlacement: function (error, element) {
                 if ($(element).hasClass("ckeditor")) {
                    error.insertAfter($('#cke_mail_content'));
                } else{
                    error.insertAfter(element);
                }
            },
            ignore: [],
            rules: {
                sms_content: {
                    required: true,
                    minlength: 2,
                    maxlength: 500
                }
            },
            messages: {
                sms_content: {
                    required: trans('required', trans('sms_content')),
                    minlength: trans('sms_content_minlength2'),
                    maxlength: trans('sms_content_maxlength500')
                }
            },
            invalidHandler: function (event, validator) { //display error alert on form submit
                errorHandler1.show();
            },
            highlight: function (element) {
                $(element).closest('.help-block').removeClass('valid');
                // display OK icon
                $(element).closest('.form-group').removeClass('has-success').addClass('has-error').find('.symbol').removeClass('ok').addClass('required');
                // add the Bootstrap error class to the control group
            },
            unhighlight: function (element) { // revert the change done by hightlight
                $(element).closest('.form-group').removeClass('has-error');
                // set error class to the control group
            },
            success: function (label, element) {
                label.addClass('help-block valid');
                // mark the current input as valid and display OK icon
                //$(element).closest('.form-group').removeClass('has-error').addClass('has-success').find('.symbol').removeClass('required').addClass('ok');
                $(element).closest('.form-group').removeClass('has-error').addClass('ok');
            }
        });
    };
    return {
        //main function to initiate template pages
        init: function () {
            runValidateSmsContentEdit();

        }
    };
}();
var ValidateEmailConfigPayoutReleaseEmail = function () {

    var msg1 = $("#validate_mail_status").html();
    var msg2 = $("#validate_subject").html();
    var msg3 = $("#validate_mail_content").html();
    
    var runValidateEmailConfigPayoutReleaseEmail = function () {
        var searchform = $('#payout_mail_settings');
        var errorHandler1 = $('.errorHandler', searchform);
        $('#payout_mail_settings').validate({
            errorElement: "span",
            errorClass: 'help-block',
            errorPlacement: function (error, element) {
                 if ($(element).hasClass("ckeditor")) {
                    error.insertAfter($('#cke_mail_content1'));
                } else{
                    error.insertAfter(element);
                }
            },
            ignore: [],
            rules: {
                mail_status: {
                    required: true  
                },
                subject1: {
                    required: true
                },
                mail_content1: {
                    minlength: 1,
                   required:  function() 
                        {
                         CKEDITOR.instances.mail_content1.updateElement();
                        }

                }
            },
            messages: {
                mail_status: {
                    required: msg1
                },
                subject1: {
                    required: msg2
                },
                mail_content1: msg3
            },
            invalidHandler: function (event, validator) { //display error alert on form submit
                errorHandler1.show();
            },
            highlight: function (element) {
                $(element).closest('.help-block').removeClass('valid');
                // display OK icon
                $(element).closest('.form-group').removeClass('has-success').addClass('has-error').find('.symbol').removeClass('ok').addClass('required');
                // add the Bootstrap error class to the control group
            },
            unhighlight: function (element) { // revert the change done by hightlight
                $(element).closest('.form-group').removeClass('has-error');
                // set error class to the control group
            },
            success: function (label, element) {
                label.addClass('help-block valid');
                // mark the current input as valid and display OK icon
                //$(element).closest('.form-group').removeClass('has-error').addClass('has-success').find('.symbol').removeClass('required').addClass('ok');
                $(element).closest('.form-group').removeClass('has-error').addClass('ok');
            }
        });
    };

    return {
        //main function to initiate template pages
        init: function () {
            runValidateEmailConfigPayoutReleaseEmail();

        }
    };
}();

$(function()
{
    ValidateSmsContentEdit.init();
   ValidateEmailConfigPayoutReleaseEmail.init();
}());
