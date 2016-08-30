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

});

function activateStep($elem) {
    $elem.removeClass('disabled');
    $elem.find('a[data-toggle="tab"]').click();
}

//STARTING HERE
var selectedWordtoShowHighlights = false;
var lastItemToHighlightPost;
var selectedText;
var highlightListForTrainingQ = [];

function highlightForAllChunks(){
    $("#chunks .chunk").each(
        function(index, elem){
            highlightForOnlyOneChunk($(elem));
        });
}

function highlightForOnlyOneChunk($chunk){
    $chunk.find('.selectize-input .item').each(function(index, elem){
        highlightForOneItem(elem);
    });
}

function highlightForOneItem(elem){
    var itemText = $(elem).text();
    itemText = itemText.slice(0, -1);
    $('#'+$(elem).attr("referencedPost")).highlight(itemText);
}

function clearReferencedWordsFromPosts(){ //fix it
    if($('#toggleAll').length > 0 && $('#toggleAll').attr("show") == "true"){

        $('.chunk').each(function(index, elem){
            $(elem).find('.selectize-input .item').each(function(index2, innerElem){
                var itemText = $(innerElem).text();
                itemText = itemText.slice(0, -1);
                $('#'+$(innerElem).attr("referencedPost")).removeHighlight(itemText);
            });
        });

    }
    else{
        $('.currentChunk .selectize-input .item').each(function(index, elem){
            var itemText = $(elem).text();
            itemText = itemText.slice(0, -1);
            $('#'+$(elem).attr("referencedPost")).removeHighlight(itemText);
        });
    }
}

function removeSelection(){
    if (window.getSelection) {
        if (window.getSelection().empty) {  // Chrome
            window.getSelection().empty();
        } else if (window.getSelection().removeAllRanges) {  // Firefox
            window.getSelection().removeAllRanges();
        } else if (document.selection) {  // IE?
            document.selection.empty();
        }
    }
}