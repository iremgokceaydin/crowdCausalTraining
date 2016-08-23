// This is a manifest file that'll be compiled into application.js.
//
// Any JavaScript file within this directory can be referenced here using a relative path.
//
// You're free to add application-wide JavaScript to this file, but it's generally better
// to create separate JavaScript files as needed.
//
//= require jquery
//= require bootstrap
//= require jquery-ui
//= require jquery.highlight
//= require jquery.selection
//= require selectize
//= require_tree .
//= require_self

if (typeof jQuery !== 'undefined') {
    (function($) {
        $('#spinner').ajaxStart(function() {
            $(this).fadeIn();
        }).ajaxStop(function() {
            $(this).fadeOut();
        });
    })(jQuery);
}

$(document).ready(function () {
    $("#footer").show();

    //Initialize tooltips
    $('.nav-tabs > li a[title]').tooltip();

    //Wizard
    $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {

        var $target = $(e.target);
        // alert($target.attr('id'));
        if ($target.parent().hasClass('disabled')) {
            return false;
        }
    });

    $(".next-step").click(function (e) {
        $("#footer").hide();
        var pressedButtonId = $(this).attr('id');
        if(pressedButtonId == "step1next"){
            //var redirectURL = '${createLink( controller:"testing", action:"index")}';
            window.location.href = "/testing?page=1";
        }
    });

    $(".prev-step").click(function (e) {
        $("#footer").hide();
        var pressedButtonId = $(this).attr('id');
        if(pressedButtonId == "step2prev"){
            window.location.href = "/introduction";
        }
    });
});

function activateStep($elem) {
    $elem.removeClass('disabled');
    $elem.find('a[data-toggle="tab"]').click();
}
