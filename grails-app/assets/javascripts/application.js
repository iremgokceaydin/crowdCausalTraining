// This is a manifest file that'll be compiled into application.js.
//
// Any JavaScript file within this directory can be referenced here using a relative path.
//
// You're free to add application-wide JavaScript to this file, but it's generally better
// to create separate JavaScript files as needed.
//
//= require jquery
//= require bootstrap.min
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
var alertEditingLength = 20;
var alertEditing = "Please add some text of at least " + alertEditingLength + " characters";
var alertWords = "Please add at least two words of cause-and-effect by highlighting some words from the posts";
var chunkIndex = 0;

function highlightForAllChunks(chunksParent){
    $("#"+chunksParent + " .chunk").each(
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

jQuery.fn.removeHighlight = function (pat) {
    return this.find("span.highlight").each(function () {
        if (!pat || pat.toUpperCase() == $(this).html().toUpperCase()) {
            this.parentNode.firstChild.nodeName;
            with (this.parentNode) {
                replaceChild(this.firstChild, this);
                normalize();
            }
        }
    }).end();
};

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

function createPost(questionType, postText, postId, isLatest, isAnswerPage, isAdmin){ //merged with posts onclick
    var $div = $("<div>", {id: "post-"+postId, class: "post"});
    var $p = $("<p>");
    $p.html(postText);
    $div.append($p);
    $("#posts").append($div);
    $div.click(function(){
        $(".currentPost").removeClass("currentPost");
        $(this).addClass("currentPost");
        if(isAdmin || (questionType != "Type1" && !isAnswerPage)){
            var selectedText = $.selection();
            if(selectedText){
                if($("#chunks div").length > 0){
                    $('.currentPost p').highlight(selectedText);//{ wordsOnly: true }
                    $('.currentChunk input')[0].selectize.createItem(selectedText);
                    var createdItem = $('.currentChunk .selectize-input div').last();
                    createdItem.attr("id", $('.currentChunk').attr("id") + "-chunk-"+($('.currentChunk .selectize-input div').length-1));
                    createdItem.attr("referencedPost", $('.currentPost').attr("id"));
                    $("span:contains('" + selectedText + "')").each(
                        function(index, elem){
                            $(this).attr("referencedChunk",createdItem.attr("id"));
                        }); //oneTime, can be reassign after highlightForOnlyOneResult
                    //$('.currentResult textarea').val($('.currentResult input')[0].selectize.items.join(" "));
                    $("#addChunkAlert").hide();
                }
                else{
                    $("#addChunkAlert").show();
                }
                removeSelection();
            }
        }
    });
    if(isLatest){
        $div.addClass("currentPost");
        $div.addClass("latestPost");
    }
    focusOnTheLatest();
    return $div;
}

function createChunk(chunksParent,questionType, isAnswerPage, isAdmin, chunkText, toggleId){
    collapseCurrentForAdd(chunksParent);
    $("#" + chunksParent + " .currentChunk").removeClass("currentChunk");

    var div = $("<div>", {id: "chunk-"+chunkIndex, class: "panel chunk"});
    var button = $("<button>", {'data-toggle':"collapse", id:"collapseSelective", class:"btn btn-info", 'data-parent':"#"+chunksParent, 'data-target':"#collapse-"+chunkIndex, style:"width:100%;"});
    var p1 = $("<p>", {id: "alertWords", class:"alertMsg"});
    p1.html('<span class="glyphicon glyphicon-exclamation-sign"></span>&nbsp;' + alertWords);
    var divInner = $("<div>", {id: "collapse-"+chunkIndex, class: "panel-collapse collapse in"});
    $(divInner).collapse({"toggle": false, 'parent': '#'+chunksParent});
    var input = $("<input>", {type: "text", placeholder:"Highlight some words from the posts"});
    var p2 = $("<p>", {id: "alertEditing", class:"alertMsg"});
    p2.html('<span class="glyphicon glyphicon-exclamation-sign"></span>&nbsp;' + alertEditing);
    var textArea = $("<textarea>", {class:"form-control", rows:"1", id:"textEdit", placeholder:"Enter some text here"});
    if(isAnswerPage || chunkText != "")
        textArea.val(chunkText);
    divInner.append(input);
    div.append(button);
    div.append(p1);
    div.append(divInner);
    div.append(p2);
    div.append(textArea);
    $("#"+chunksParent).append(div);

    $(div).addClass("currentChunk");
    chunkIndex++;

    $(input).selectize({
        plugins: ['drag_drop','remove_button'],
        delimiter: ',',
        persist: false,
        create: function(input) {
            return {
                value: input,
                text: input
            }
        },
        onItemAdd: function (value, item) {
            if($("#"+chunksParent + " .currentChunk .selectize-input .item").length > 1) //naive expectation: 1 for cause 1 for effect
                p1.hide();
            $(item).click(function(e){
                var target = e.target || e.srcElement;
                if(target.tagName != "A"){ //if cross is clicked to remove a word
                    //$("#posts").unhighlight({ element: 'span', className: 'highlight' });
                    if(selectedWordtoShowHighlights && lastItemToHighlightPost == $(item).attr('data-value')){
                        $(item).removeClass('active');
                        selectedWordtoShowHighlights = false;
                        if($('#'+toggleId).attr("show") == "true"){
                            highlightForAllChunks(chunksParent);
                        }
                        else{
                            highlightForOnlyOneChunk(div);
                        }
                    }
                    else{
                        clearReferencedWordsFromPosts();//TODO somewhere
                        highlightForOneItem(item);
                        selectedWordtoShowHighlights = true;
                        lastItemToHighlightPost = $(item).attr('data-value');
                    }
                }
            });
        },
        onItemRemove: function (value, item) {
            $('#' + $(item).attr('referencedPost')).removeHighlight(value);
            //$('.currentResult textarea').val($('.currentResult textarea').val().replace(value,''));
            if(lastItemToHighlightPost == $(item).attr('data-value')){
                highlightForOnlyOneChunk(div);
                selectedWordtoShowHighlights = false;
            }
        },
        onChange: function (value){ //calling onItemRemove as well

        }
    });
    $("#"+chunksParent + " .currentChunk .selectize-input input").attr("readonly",'');
    if(!isAdmin) {
        if (questionType == "Type1" || (questionType == "Type2" && isAnswerPage))
            $("#"+chunksParent + " .currentChunk .selectize-input input").attr("disabled", 'disabled');//added important
    }
    $(div).find("button").click(function(e){ //this div only expandable using collapse icon
        if($('#'+toggleId).attr("show") == "true"){
            collapseAll(chunksParent, toggleId);
            setTimeout(function(){ $(this).click();}, 600);
        }
        else{
            if($(this).parent().hasClass("currentChunk")) {
                if ($(this).hasClass("collapsed")){
                    //expand will be done automatically by accordion structure
                    highlightForOnlyOneChunk($(this).parent());
                }
                else
                    afterCollapseCurrent(chunksParent);
            }
            else{
                //others automatically will be collapsed due to accordion nature
                afterCollapseCurrent(chunksParent);
                $("#" + chunksParent + " .currentChunk").removeClass("currentChunk");
                $(this).parent().addClass("currentChunk");
                highlightForOnlyOneChunk($(this).parent());
            }

            if(!isAnswerPage)
                $("#"+chunksParent + " .currentChunk textarea").removeAttr('readonly');
        }
    });

    $(textArea).on('change keyup paste', function() {
        if($(this).val().length < alertEditingLength)
            p2.show();
        else
            p2.hide();
    });
}


function highlightAndAddToChunk(chunksParent,referencedPost, selectedText, questionType, isAnswerPage, isAdmin){ //added modified
    if($("#" +chunksParent + " div").length > 0){
        $('#'+referencedPost).find("p").highlight(selectedText);//{ wordsOnly: true }
        $('.currentChunk input')[0].selectize.createItem(selectedText);
        var $createdItem = $('.currentChunk .selectize-input .item').last();
        $createdItem.attr("id", $('.currentChunk').attr("id") + "-casual-"+($('.currentChunk .selectize-input .item').length-1));
        $createdItem.attr("referencedPost", $('#'+referencedPost).attr("id"));
        if(!isAdmin){
            if(questionType == "Type1" || (questionType == "Type2" && isAnswerPage))
                $createdItem.find("a").remove();
        };

        $("span:contains('" + selectedText + "')").each(
            function(index, elem){
                $(this).attr("referencedChunk",$createdItem.attr("id"));
            }); //oneTime, can be reassign after highlightForOnlyOneResult
        //$('.currentResult textarea').val($('.currentResult input')[0].selectize.items.join(" "));
        $("#addChunkAlert").hide();
    }
    else{
        $("#addChunkAlert").show();
    }
    removeSelection();
}

function removeChunk(){
    clearReferencedWordsFromPosts();
    var idToFocus = $('.currentChunk').prev().attr("id");
    $('.currentChunk').remove();
    if($("#chunks .chunk").length > 0)
        $('#' + idToFocus).find('button').click();
}


function collapseCurrentForAdd(chunksParent){
    $("#posts").unhighlight({ element: 'span', className: 'highlight' });
    $("#" + chunksParent + " .currentChunk .in").collapse("hide");
    $("#" + chunksParent + " .currentChunk button").addClass('collapsed');
    //$(".currentChunk textarea").attr("readonly","");
    $("#" + chunksParent + " .currentChunk textarea").height(20);
    selectedWordtoShowHighlights = false;
}

function afterCollapseCurrent(chunksParent){
    $("#posts").unhighlight({ element: 'span', className: 'highlight' });
    $("#" + chunksParent + " .currentChunk textarea").height(20);
    selectedWordtoShowHighlights = false;
}

function focusOnTheLatest(){
    $('#posts').scrollTop($('#posts')[0].scrollHeight);
}

//TODO make the id of chunksParent dynamic, edit all the subsequent functions accordingly
function prepareInputsforAdminTrainingChunksSubmit(){
    if($("#chunks .chunk").length > 0){
        var a = isThereEmptyWords();
        var b = isThereEmptyText();
        if(!( a || b)){
            var input_chunks = $("<input>", {type: "hidden", name:"numberOfChunks", value: $('.chunk').length});
            $('#inputsToSubmit').append(input_chunks);

            $('.chunk').each(function(index, elem){
                var highlights = [];
                $(elem).find('.items .item').each(function(index, elem){
                    var highlight = {};
                    highlight.index = index;
                    highlight.value = $(elem).attr("data-value");
                    highlight.referencedPost = $(elem).attr("referencedPost");
                    highlights.push(highlight);
                });

                var input_highlights = $("<input>", {type: "hidden", name:"chunk-" + index + "-highlights", value: JSON.stringify(highlights)});
                var input_text = $("<input>", {type: "hidden", name:"chunk-" + index + "-text", value:$(elem).find("textarea").val()});
                $('#inputsToSubmit').append(input_highlights);
                $('#inputsToSubmit').append(input_text);

            });

            return true;
        }
        else{
            alert("Please fix the errors!");
            return false;
        }

    }
    else{
        alert("Add at least one causal chunk item first!");
        return false;
    }
}

function prepareInputsforAdminTestingHighlightsSubmit(){
    if($('.currentChunk .selectize-input .item').length == 0) {
        alert("Please add highlights!");
        return false;
    }
    else {
        $(".chunk").find('.items .item').each(function () {
            var input_highlight = $("<input>", {
                type: "hidden",
                name: "highlight",
                value: $(this).attr("data-value")
            });
            $('#inputsToSubmit').append(input_highlight);
        });

        return true;
    }
}

function collapseAll(chunksParent, toggleId){
    $("#"+chunksParent+" button").addClass("collapsed");
    $("#"+chunksParent+" .in").collapse("hide");
    //$("#chunks textarea").attr("readonly","");//added
    $("#posts").unhighlight({ element: 'span', className: 'highlight' });
    $('#'+toggleId).html("Show All");
    $('#'+toggleId).attr("show", "false");
    selectedWordtoShowHighlights = false;
}

function expandAll(isAnswerPage,chunksParent, toggleId){
    $("#"+chunksParent+" .in").collapse("hide");
    setTimeout(function(){
        $("#"+chunksParent+" .panel-collapse").collapse("show");
        $("#"+chunksParent+" button.collapsed").removeClass("collapsed");
        $("#"+chunksParent+" .currentChunk").removeClass("currentChunk"); //added
        $('#'+toggleId).html("Hide All");
        $('#'+toggleId).attr("show", "true");
        if(isAnswerPage)
            $("#"+chunksParent+" textarea").attr("readonly","");//added
        else
            $("#"+chunksParent+" textarea").removeAttr('readonly');
    }, 600);

    highlightForAllChunks(chunksParent);
}

function expandCurrentCollapsed($chunk){
    // $chunk.find("button.collapsed").removeClass("collapsed");
    // // alert($chunk.find("div.collapse").className);
    // $chunk.find(".panel-collapse").collapse("show");
    // no need to expand manually, button is doing itself already, so just highlight the words as follows
    highlightForOnlyOneChunk($chunk);
}

function isThereEmptyText(){
    var emptyText = false;
    $("#chunks .chunk").each(
        function(index, elem){
            if($(elem).find("textarea").val() == "" || $(elem).find("textarea").val().length < alertEditingLength){
                $(elem).find("#alertEditing").show();
                emptyText = true;
            }
        });

    return emptyText;
}

function isThereEmptyWords(){
    var emptyWords = false;
    $("#chunks .chunk").each(
        function(index, elem){
            if($(elem).find(".selectize-input .item").length < 2){
                $(elem).find("#alertWords").show();
                emptyWords = true;
            }
        });

    return emptyWords;
}