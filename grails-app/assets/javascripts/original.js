/**
 * Created by iremgokceyildirim on 22/08/16.
 */
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

var numberofTrainingType1Steps, numberofTrainingType2Steps, numberofTrainingType3Steps;
var currentTrainingType1Step = currentTrainingType2Step = currentTrainingType3Step = 0;
var currentType = 1;
var trainingPostsNumberinEachStep = 2;
var alertEditingLength = 20;
var answerIsOn = false;
var trainingData = {};

var causalIndex = 0;
var alertEditing = "Please add some text of at least " + alertEditingLength + " characters";
var alertWords = "Please add at least two words of cause-and-effect by highlighting some words from the posts";
var wordAndReferencesMap = [];
var selectedWordtoShowHighlights = false;
var lastItemToHighlightPost;

$(document).ready(function () {
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
        var $active = $('.wizard .nav-tabs li.active');
        var pressedButtonId = $(this).attr('id');
        if(pressedButtonId == "step1next"){
            $("#step1_intro1").hide();
            $("#step2_testing").show();

            $active.next().removeClass('disabled');
            nextTab($active);
        }
        else if(pressedButtonId == "step2next"){
            if(validateTestingForm()){
                updateAndSubmitTesting();
            }
        }
        else if(pressedButtonId == "step3next"){
            $("#step3_intro2").hide();

            $("#step4_training #type").text("Type-1 | Step-1");
            $("#step4_training #description").text("In this step, the worker will receive a page with a preset number of chunks, with the relevant highlighted phrases pre-selected.  The workers task is to enter the text for the chunks.  After they submit this page, they will see a page with “correct” (recommended) answers.  This page should show the full interface (i.e. not just the correct text answers), but no editing is possible.  (Note - we should make sure the back button works, or provide explicit back button)");
            $("#step4_training").show();
            $("#step4_training").css('display', 'inline-block');

            $active.next().removeClass('disabled');
            nextTab($active);
        }
        else if(pressedButtonId == "step4next"){
            if(currentTrainingType1Step <= numberofTrainingType1Steps){
                if(!answerIsOn){
                    var a = isThereEmptyWords();
                    var b = isThereEmptyText();
                    if(!( a || b)){
                        updateAndSubmitTraining(1);
                        answerIsOn = true;
                        printTrainingType1(true);
                        $("#step4_training #type").text("Type-1 | Step-" + currentTrainingType1Step + " Answers");
                    }
                    else{
                        alert("Please fix the errors!");
                    }
                }
                else{
                    answerIsOn = false;
                    currentTrainingType1Step++;
                    if(currentTrainingType1Step > numberofTrainingType1Steps){
                        currentTrainingType2Step = 1;
                        currentType = 2;
                        $("#step4_training #description").text("`Blank` interface (1 post to code, with 1 preceding post for context).In this step, the worker will receive a page very much like they would receive in an actual task.  They need to do the task.  When they submit however, they will be shown a page with the “correct” answer in the full interface, so they can compare to their own work.  As with the previous step, there should be a back button of some kind.");
                        printTrainingType2(false);
                        $("#step4_training #type").text("Type-2 | Step-" + currentTrainingType2Step);
                    }
                    else{
                        printTrainingType1(false);
                        $("#step4_training #type").text("Type-1 | Step-" + currentTrainingType1Step);
                    }
                }
            }
            else if(currentTrainingType2Step <= numberofTrainingType2Steps){
                if(!answerIsOn){
                    var a = isThereEmptyWords();
                    var b = isThereEmptyText();
                    if(!( a || b)){
                        updateAndSubmitTraining(2);
                        answerIsOn = true;
                        printTrainingType2(true);
                        $("#step4_training #type").text("Type-2 | Step-" + currentTrainingType2Step + " Answers");
                    }
                    else{
                        alert("Please fix the errors!");
                    }
                }
                else{
                    answerIsOn = false;
                    currentTrainingType2Step++;
                    if(currentTrainingType2Step > numberofTrainingType2Steps){
                        currentTrainingType3Step = 1;
                        currentType = 3;
                        $("#step4next").text("Submit and Continue");
                        answerIsOn=false;
                        $("#step4_training #description").text("`Blank` interface (1 post to code, with 1 preceding post for context) There will be 1 or more pages of actual testing. (disable back button?)");
                        printTrainingType3(false);
                        $("#step4_training #type").text("Type-3 | Step-" + currentTrainingType3Step);
                    }
                    else{
                        printTrainingType2(false);
                        $("#step4_training #type").text("Type-2 | Step-" + currentTrainingType2Step);
                    }
                }
            }
            else if(currentTrainingType3Step <= numberofTrainingType3Steps){
                var a = isThereEmptyWords();
                var b = isThereEmptyText();
                if(!( a || b)){
                    updateAndSubmitTraining(3);
                    currentTrainingType3Step++;
                    if(currentTrainingType3Step > numberofTrainingType3Steps){
                        $("#step4_training").hide();
                        $("#step5_complete").show();
                        $active.next().removeClass('disabled');
                        nextTab($active);
                    }
                    else{
                        printTrainingType3(false);
                        $("#step4_training #type").text("Type-3 | Step-" + currentTrainingType3Step);
                    }
                }
                else{
                    alert("Please fix the errors!");
                }
            }
        }
    });

    $(".prev-step").click(function (e) {
        var pressedButtonId = $(this).attr('id');
        if(pressedButtonId == "step2prev"){
            $("#step2_testing").hide();
            $("#step1_intro1").show();
            var $active = $('.wizard .nav-tabs li.active');
            prevTab($active);
        }
        else if(pressedButtonId == "step3prev"){
            $("#step2_testing").show();
            $("#step3_intro2").hide();
            var $active = $('.wizard .nav-tabs li.active');
            prevTab($active);
        }
        else if(pressedButtonId == "step4prev"){
            if(answerIsOn){
                if(currentType == 3){
                    answerIsOn = false;
                    printTrainingType3(false);
                    $("#step4_training #type").text("Type-3 | Step-" + currentTrainingType3Step);
                }
                else if(currentType == 2){
                    answerIsOn = false;
                    printTrainingType2(false);
                    $("#step4_training #type").text("Type-2 | Step-" + currentTrainingType2Step);
                }
                else if(currentType == 1){
                    answerIsOn = false;
                    printTrainingType1(false);
                    $("#step4_training #type").text("Type-1 | Step-" + currentTrainingType1Step);
                }
            }
            else{
                if(currentTrainingType3Step > 1){
                    currentTrainingType3Step--;
                    printTrainingType3(false);
                    $("#step4_training #type").text("Type-3 | Step-" + currentTrainingType3Step);
                }
                else if(currentTrainingType3Step == 1){
                    currentTrainingType3Step = 0;
                    $("#step4next").text("Save and Continue"); //one time only
                    currentType = 2;
                    answerIsOn = true;
                    currentTrainingType2Step--;
                    printTrainingType2(true);
                    $("#step4_training #description").text("`Blank` interface (1 post to code, with 1 preceding post for context).In this step, the worker will receive a page very much like they would receive in an actual task.  They need to do the task.  When they submit however, they will be shown a page with the “correct” answer in the full interface, so they can compare to their own work.  As with the previous step, there should be a back button of some kind.");
                    $("#step4_training #type").text("Type-2 | Step-" + currentTrainingType2Step + " Answers");
                }
                else if(currentTrainingType2Step > 1){
                    answerIsOn = true;
                    currentTrainingType2Step--;
                    printTrainingType2(true);
                    $("#step4_training #type").text("Type-2 | Step-" + currentTrainingType2Step + " Answers");
                }
                else if(currentTrainingType2Step == 1){
                    currentTrainingType2Step = 0;
                    currentType = 1;
                    answerIsOn = true;
                    currentTrainingType1Step--;
                    printTrainingType1(true);
                    $("#step4_training #description").text("In this step, the worker will receive a page with a preset number of chunks, with the relevant highlighted phrases pre-selected.  The workers task is to enter the text for the chunks.  After they submit this page, they will see a page with “correct” (recommended) answers.  This page should show the full interface (i.e. not just the correct text answers), but no editing is possible.  (Note - we should make sure the back button works, or provide explicit back button)");
                    $("#step4_training #type").text("Type-1 | Step-" + currentTrainingType1Step + " Answers");
                }
                else if(currentTrainingType1Step > 1){
                    answerIsOn = true;
                    currentTrainingType1Step--;
                    printTrainingType1(true);
                    $("#step4_training #type").text("Type-1 | Step-" + currentTrainingType1Step + " Answers");
                }
                else if(currentTrainingType1Step == 1){
                    $("#step4_training").hide();
                    $("#step3_intro2").show();

                    var $active = $('.wizard .nav-tabs li.active');
                    prevTab($active);
                }
            }
        }
    });

    $.getJSON('testing.json', function(testingData) {
        $("#passage1").text(testingData['testingPosts'][0]['post']);
        $("#q1a1").parent()[0].childNodes[1].nodeValue =  testingData['testingPosts'][0]['answers'][0];
        $("#q1a2").parent()[0].childNodes[1].nodeValue =  testingData['testingPosts'][0]['answers'][1];
        $("#q1a3").parent()[0].childNodes[1].nodeValue =  testingData['testingPosts'][0]['answers'][2];

        $("#passage2").text(testingData['testingPosts'][1]['post']);
        $("#q2a1").parent()[0].childNodes[1].nodeValue =  testingData['testingPosts'][1]['answers'][0];
        $("#q2a2").parent()[0].childNodes[1].nodeValue =  testingData['testingPosts'][1]['answers'][1];
        $("#q2a3").parent()[0].childNodes[1].nodeValue =  testingData['testingPosts'][1]['answers'][2];

        for (var i = 0; i < testingData['testingPosts'][1]['highlights'].length; i++) {
            $('#passage2').highlight(testingData['testingPosts'][1]['highlights'][i]);
        }
    });

    $.getJSON('training.json', function(data) {
        currentTrainingType1Step = 1;
        trainingData = data;
        if(trainingData['trainingPosts']['type_1'].length){
            numberofTrainingType1Steps = Math.ceil(trainingData['trainingPosts']['type_1'].length / trainingPostsNumberinEachStep);
            printTrainingType1(false);
        }
        if(trainingData['trainingPosts']['type_2'].length){
            numberofTrainingType2Steps = Math.ceil(trainingData['trainingPosts']['type_2'].length / trainingPostsNumberinEachStep);
            //printTrainingType2(false);
        }
        if(trainingData['trainingPosts']['type_3'].length){
            numberofTrainingType3Steps = Math.ceil(trainingData['trainingPosts']['type_3'].length / trainingPostsNumberinEachStep);
            //printTrainingType3(false);
        }
    });

    $('#addCausal').click(function() {
        if(currentTrainingType1Step > numberofTrainingType1Steps && !answerIsOn)
            createCausal();
    });

    $('#removeCausal').click(function() {
        if(currentTrainingType1Step > numberofTrainingType1Steps && !answerIsOn)
            removeCausal();
    });

    $('#toggleAll').click(function() {
        if ($(this).attr("show") == "true"){
            if($("#results .result").length > 1){
                collapseAll();
            }
        }
        else{
            if($("#results .result").length > 1){
                expandAll();
            }
        }
    });

});

function nextTab(elem) {
    $(elem).next().find('a[data-toggle="tab"]').click();
}
function prevTab(elem) {
    $(elem).prev().find('a[data-toggle="tab"]').click();
}

function validateTestingForm() {
    if ($("input[name=q1a]:checked").length == 0 || $("input[name=q2a]:checked").length == 0)
    {
        alert("Please select an answer!");
        return false;
    }
    return true;
}

function printTrainingType1(withAnswer){
    causalIndex = 0;
    $("#posts").empty();
    $("#results").empty();
    if(!withAnswer){
        for (var i = 0; i < currentTrainingType1Step * trainingPostsNumberinEachStep; i++) {  //highlighted&notext
            var $div = createPost(trainingData['trainingPosts']['type_1'][i]['post'], trainingData['trainingPosts']['type_1'][i]['id']);
            $div.trigger('click');
            for (var k = 0; k < trainingData['trainingPosts']['type_1'][i]['chunks'].length; k++) {
                createCausal();
                for (var j = 0; j < trainingData['trainingPosts']['type_1'][i]['chunks'][k]['highlights'].length; j++) {
                    var selectedText = trainingData['trainingPosts']['type_1'][i]['chunks'][k]['highlights'][j];
                    highlightAndAddToResult("post-"+i,selectedText);
                }
            }
        }
        $(".result").each(function(index, elem){
            var $textarea = $(elem).find("textarea");
            if($("input[name=" +"type-1" + "-step-"+ currentTrainingType1Step +"-chunk-" + index + "-text"+ "]").length)
                $textarea.text($("input[name=" +"type-1" + "-step-"+ currentTrainingType1Step +"-chunk-" + index + "-text"+ "]").val());
        });
        expandAll();
        // $(".currentPost").removeClass("currentPost"); //added not neccesseraly
    }
    else{
        for (var i = 0; i < currentTrainingType1Step * trainingPostsNumberinEachStep; i++) {  //highlighted&notext
            var $div = createPost(trainingData['trainingPosts']['type_1'][i]['post'], trainingData['trainingPosts']['type_1'][i]['id']);
            $div.trigger('click');
            for (var k = 0; k < trainingData['trainingPosts']['type_1'][i]['chunks'].length; k++) {
                createCausal();
                for (var j = 0; j < trainingData['trainingPosts']['type_1'][i]['chunks'][k]['highlights'].length; j++) {
                    var selectedText = trainingData['trainingPosts']['type_1'][i]['chunks'][k]['highlights'][j];
                    highlightAndAddToResult("post-"+i,selectedText);
                }
                $(".currentResult textarea").text(trainingData['trainingPosts']['type_1'][i]['chunks'][k]['text']);
            }
        }
        expandAll();
    }
}

function printTrainingType2(withAnswer){
    causalIndex = 0;
    $("#posts").empty();
    $("#results").empty();
    if(!withAnswer){
        for (var i = 0; i < currentTrainingType2Step * trainingPostsNumberinEachStep; i++) {  //highlighted&notext
            var $div = createPost(trainingData['trainingPosts']['type_2'][i]['post'], trainingData['trainingPosts']['type_2'][i]['id']);
        }

        var index = 0;
        while($("input[name=" +"type-2" + "-step-"+ currentTrainingType2Step +"-chunk-" + index + "-highlights"+ "]").length){
            createCausal();
            var highlights = JSON.parse($("input[name=" +"type-2" + "-step-"+ currentTrainingType2Step +"-chunk-" + index + "-highlights"+ "]").val());
            for (var j = 0; j < highlights.length; j++) {
                var selectedText = highlights[j]['value'];
                highlightAndAddToResult(highlights[j]['referencedPost'],selectedText);
            }
            $(".currentResult textarea").text($("input[name=" +"type-2" + "-step-"+ currentTrainingType2Step +"-chunk-" + index + "-text"+ "]").val());
            index++;
        }
        expandAll();
    }
    else{
        for (var i = 0; i < currentTrainingType2Step * trainingPostsNumberinEachStep; i++) {  //highlighted&notext
            var $div = createPost(trainingData['trainingPosts']['type_2'][i]['post'], trainingData['trainingPosts']['type_2'][i]['id']);
            $div.trigger('click');
            for (var k = 0; k < trainingData['trainingPosts']['type_2'][i]['chunks'].length; k++) {
                createCausal();
                for (var j = 0; j < trainingData['trainingPosts']['type_2'][i]['chunks'][k]['highlights'].length; j++) {
                    var selectedText = trainingData['trainingPosts']['type_2'][i]['chunks'][k]['highlights'][j];
                    highlightAndAddToResult("post-"+i,selectedText);
                }
                $(".currentResult textarea").text(trainingData['trainingPosts']['type_2'][i]['chunks'][k]['text']);
            }
        }
        expandAll();
    }
}

function printTrainingType3(withAnswer){ //no need for answer but keep the parameter
    causalIndex = 0;
    $("#posts").empty();
    $("#results").empty();
    for (var i = 0; i < currentTrainingType3Step * trainingPostsNumberinEachStep; i++) {  //highlighted&notext
        var $div = createPost(trainingData['trainingPosts']['type_3'][i]['post'], trainingData['trainingPosts']['type_3'][i]['id']);
    }

    var index = 0;
    while($("input[name=" +"type-3" + "-step-"+ currentTrainingType3Step +"-chunk-" + index + "-highlights"+ "]").length){
        createCausal();
        var highlights = JSON.parse($("input[name=" +"type-3" + "-step-"+ currentTrainingType3Step +"-chunk-" + index + "-highlights"+ "]").val());
        for (var j = 0; j < highlights.length; j++) {
            var selectedText = highlights[j]['value'];
            highlightAndAddToResult(highlights[j]['referencedPost'],highlights[j]['value']);
        }
        $(".currentResult textarea").text($("input[name=" +"type-3" + "-step-"+ currentTrainingType3Step +"-chunk-" + index + "-text"+ "]").val());
        index++;
    }
}

function updateAndSubmitTesting(){
    $("input[name=testing_1_p]").val($("#passage1").text());
    $("input[name=testing_1_a]").val($("input[name=q1a]:checked").val());
    $("input[name=testing_1_a_text]").val($("input[name=q1a]:checked").parent().text());
    $("input[name=testing_2_p]").val($("#passage2").text());
    $("input[name=testing_2_a]").val($("input[name=q2a]:checked").val());
    $("input[name=testing_2_a_text]").val($("input[name=q2a]:checked").parent().text());
    var ajaxRequest= $.post( "js/requestForwarder.php",$("form[name='submitForm']").serialize() + '&action=insertWorkerTesting', function(data) {
        alert(data);
    })
        .fail(function() {
            alert( "ERROR: Your answers cannot be stored correctly, please try to submit again!" );
        })
        .always(function() {
            $("#step2_testing").hide();
            $("#step3_intro2").show();

            var $active = $('.wizard .nav-tabs li.active');
            $active.next().removeClass('disabled');
            nextTab($active);
        });
}

function updateAndSubmitTraining(type){
    if($("#results .result").length > 0){
        if(type == 1)
            $( "input[name^='"+ "type-" + type + "-step-"+ currentTrainingType1Step +"']").remove();
        else if(type == 2)
            $( "input[name^='"+ "type-" + type + "-step-"+ currentTrainingType2Step +"']").remove();
        else if(type == 3)
            $( "input[name^='"+ "type-" + type + "-step-"+ currentTrainingType3Step +"']").remove();

        $('.result').each(function(index, elem){
            var highlights = [];
            $(elem).find('.items .item').each(function(index, elem){
                var highlight = {};
                highlight.index = index;
                highlight.value = $(elem).attr("data-value");
                highlight.referencedPost = $(elem).attr("referencedPost");
                highlights.push(highlight);
            });
            if(type == 1){
                var input_highlights = $("<input>", {type: "hidden", name:"type-" + type + "-step-"+ currentTrainingType1Step +"-chunk-" + index + "-highlights", value: JSON.stringify(highlights)});
                var input_text = $("<input>", {type: "hidden", name:"type-" + type + "-step-"+ currentTrainingType1Step +"-chunk-" + index + "-text", value:$(elem).find("textarea").val()});
                $('#inputsToSubmit').append(input_highlights);
                $('#inputsToSubmit').append(input_text);

            }
            else if(type == 2){
                var input_highlights = $("<input>", {type: "hidden", name:"type-" + type + "-step-"+ currentTrainingType2Step +"-chunk-" + index + "-highlights", value: JSON.stringify(highlights)});
                var input_text = $("<input>", {type: "hidden", name:"type-" + type + "-step-"+ currentTrainingType2Step +"-chunk-" + index + "-text", value:$(elem).find("textarea").val()});
                $('#inputsToSubmit').append(input_highlights);
                $('#inputsToSubmit').append(input_text);

            }
            else if(type == 3){
                var input_highlights = $("<input>", {type: "hidden", name:"type-" + type + "-step-"+ currentTrainingType3Step +"-chunk-" + index + "-highlights", value: JSON.stringify(highlights)});
                var input_text = $("<input>", {type: "hidden", name:"type-" + type + "-step-"+ currentTrainingType3Step +"-chunk-" + index + "-text", value:$(elem).find("textarea").val()});
                $('#inputsToSubmit').append(input_highlights);
                $('#inputsToSubmit').append(input_text);
            }
        });
        // alert("Ready to submit");
        var step;
        if (currentType == 1)
            step = currentTrainingType1Step;
        else if (currentType == 2)
            step = currentTrainingType2Step;
        else if (currentType == 3)
            step = currentTrainingType3Step;
        var ajaxRequest= $.post( "js/requestForwarder.php",$( "input[name^='"+ "type-" + type + "-step-"+ step +"']").serialize() + '&action=insertWorkerTraining' + '&type=' + type +'&step=' + step +'&worker_amazon_id=' + $("input[name=worker_amazon_id]").val(), function(data) {
            alert(data);
        })
            .fail(function() {
                alert( "ERROR: Your answers cannot be stored correctly, please try to submit again!" );
            })
            .always(function() {
                // var $active = $('.wizard .nav-tabs li.active');
                // $active.css("left", "20px");
            });
    }
    else{
        alert("Add at least one causal relation item first!");
    }
}

/* From ORIGINAL BEGIN */
function createPost(sentence, index){ //merged with posts onclick
    var $div = $("<div>", {id: "post-"+index, class: "post"});
    var $p = $("<p>");
    $p.html(sentence);
    $div.append($p);
    $("#posts").append($div);
    $div.click(function(){
        $(".currentPost").removeClass("currentPost");
        $(this).addClass("currentPost");
        if(currentType != 1 && !answerIsOn){
            var selectedText = $.selection();
            if(selectedText){
                if($("#results div").length > 0){
                    $('.currentPost p').highlight(selectedText);//{ wordsOnly: true }
                    $('.currentResult input')[0].selectize.createItem(selectedText);
                    var createdItem = $('.currentResult .selectize-input div').last();
                    createdItem.attr("id", $('.currentResult').attr("id") + "-casual-"+($('.currentResult .selectize-input div').length-1));
                    createdItem.attr("referencedPost", $('.currentPost').attr("id"));
                    $("span:contains('" + selectedText + "')").each(
                        function(index, elem){
                            $(this).attr("referencedCasual",createdItem.attr("id"));
                        }); //oneTime, can be reassign after highlightForOnlyOneResult
                    //$('.currentResult textarea').val($('.currentResult input')[0].selectize.items.join(" "));
                    $("#addCausalAlert").hide();

                    var tuple = {'data-value':createdItem.attr('data-value'), 'postReference':createdItem.attr('referencedPost'), 'referencedResult':$('.currentResult').attr('id')};
                    var exist = false;
                    wordAndReferencesMap.forEach(function(elem,index){
                        if(elem['data-value'] == createdItem.attr('data-value') && elem['referencedResult'] == $('.currentResult').attr('id')){
                            exist = true;
                            return;
                        }
                    });
                    if(!exist)
                        wordAndReferencesMap.push(tuple);
                }
                else{
                    $("#addCausalAlert").show();
                }
                removeSelection();
            }
        }
    });
    if(index == trainingPostsNumberinEachStep - 1){
        $div.addClass("currentPost");
        $div.addClass("latestPost");
    }
    focusOnTheLatest();
    return $div;
}



function focusOnTheLatest(){
    $('#posts').scrollTop($('#posts')[0].scrollHeight);
}

function createCausal(){
    collapseCurrent();

    var div = $("<div>", {id: "result-"+causalIndex, class: "panel result"});
    var button = $("<button>", {'data-toggle':"collapse", id:"collapseSelective", class:"btn btn-info", 'data-parent':"#results", 'data-target':"#collapse-"+causalIndex, style:"width:100%;"});
    var p1 = $("<p>", {id: "alertWords", class:"alertMsg"});
    p1.html('<span class="glyphicon glyphicon-exclamation-sign"></span>&nbsp;' + alertWords);
    var divInner = $("<div>", {id: "collapse-"+causalIndex, class: "panel-collapse collapse in"});
    $(divInner).collapse({"toggle": false, 'parent': '#results'});
    var input = $("<input>", {type: "text", placeholder:"Highlight some words from the posts"});
    var p2 = $("<p>", {id: "alertEditing", class:"alertMsg"});
    p2.html('<span class="glyphicon glyphicon-exclamation-sign"></span>&nbsp;' + alertEditing);
    var textArea = $("<textarea>", {class:"form-control", rows:"1", id:"textEdit", placeholder:"Enter some text here"});
    divInner.append(input);
    div.append(button);
    div.append(p1);
    div.append(divInner);
    div.append(p2);
    div.append(textArea);
    $("#results").append(div);

    $(div).addClass("currentResult");
    causalIndex++; //TODO: always increasing although some causal relationship elements are removed!!but it's alright!

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
            if($('.currentResult .selectize-input .item').length > 1) //naive expectation: 1 for cause 1 for effect
                p1.hide();
            $(item).click(function(e){
                var target = e.target || e.srcElement;
                if(target.tagName != "A"){ //if cross is clicked to remove a word
                    if(selectedWordtoShowHighlights && lastItemToHighlightPost == $(item).attr('data-value')){
                        $(item).removeClass('active');
                        selectedWordtoShowHighlights = false;
                        if($('#toggleAll').attr("show") == "true"){
                            highlightForAllResults();
                        }
                        else{
                            highlightForOnlyOneResult(div);
                        }
                    }
                    else{
                        clearReferencedWordsFromPosts();
                        highlightForOneItem(item);
                        selectedWordtoShowHighlights = true;
                        lastItemToHighlightPost = $(item).attr('data-value');
                    }
                }
            });
        },
        onItemRemove: function (value, item) {
            wordAndReferencesMap.forEach(function(elem,index){
                if(elem['data-value'] == $(item).attr('data-value') && elem['referencedResult'] == $('.currentResult').attr('id')){
                    wordAndReferencesMap.splice(index,1);
                    return;
                }
            });
            $('#' + $(item).attr('referencedPost')).removeHighlight(value);
            //$('.currentResult textarea').val($('.currentResult textarea').val().replace(value,''));
            if(lastItemToHighlightPost == $(item).attr('data-value')){
                highlightForOnlyOneResult(div);
                selectedWordtoShowHighlights = false;
            }
        },
        onChange: function (value){ //calling onItemRemove as well
            //$('.currentResult textarea').val($('.currentResult input')[0].selectize.items.join(" "));
            wordAndReferencesMap.forEach(function(elem,index){
                //alert("here");
                $('.currentResult .items .item').each(function (index,item){
                    if(elem['data-value'] == $(item).attr('data-value') && elem['referencedResult'] == $('.currentResult').attr('id')){
                        $(item).attr('referencedPost', elem['postReference']);
                        return;
                    }
                });
            });
        }
    });
    $('.currentResult .selectize-input input').attr("readonly",'');
    if(currentType == 1 || (currentType == 2 && answerIsOn))
        $('.currentResult .selectize-input input').attr("disabled",'disabled');//added important

    $(div).find("button").click(function(e){ //this div only expandable using collapse icon
        if($('#toggleAll').attr("show") == "true"){
            collapseAll();
            setTimeout(function(){ $(this).click();}, 600);
        }
        else{
            collapseCurrent();
            $(this).parent().addClass("currentResult");
            if(!answerIsOn)
                $('.currentResult textarea').removeAttr('readonly');
            expandCurrentCollapsed($(this).parent());
        }
    });

    $(textArea).on('change keyup paste', function() {
        if($(this).val().length < alertEditingLength)
            p2.show();
        else
            p2.hide();
    });
}

function removeCausal(){
    clearReferencedWordsFromPosts();
    var idToFocus = $('.currentResult').prev().attr("id");
    $('.currentResult').remove();
    // if(currentTrainingType2Step > numberofTrainingType2Steps){
    //     $("input[name=" +"type-3" + "-step-"+ currentTrainingType3Step +"-chunk-");
    // } else if(currentTrainingType1Step > numberofTrainingType1Steps){
    //     $("input[name=" +"type-2" + "-step-"+ currentTrainingType2Step +"-chunk-"
    // }
    if($("#results .result").length > 0)
        $('#' + idToFocus).find('button').click();

    //TODO: fix the causalIndex
}

function collapseCurrent(){
    $("#posts").unhighlight({ element: 'span', className: 'highlight' });
    $(".currentResult .in").collapse("hide");
    $(".currentResult button").addClass('collapsed');
    $(".currentResult textarea").attr("readonly","");
    $(".currentResult textarea").height(20);
    $(".currentResult").removeClass("currentResult");
    selectedWordtoShowHighlights = false;
}

function expandCurrentCollapsed($result){
    // no need to expand manually, button is doing itself already, so just highlight the words as follows
    highlightForOnlyOneResult($result);
}

function expandAll(){
    $('#results .in').collapse("hide");
    setTimeout(function(){
        $('#results .panel-collapse').collapse("show");
        $("#results button.collapsed").removeClass("collapsed");
        $(".currentResult").removeClass("currentResult"); //added
        $("#toggleAll").html("Hide All");
        $("#toggleAll").attr("show", "true");
        if(answerIsOn)
            $("#results textarea").attr("readonly","");//added
        else
            $('#results textarea').removeAttr('readonly');
    }, 600);

    highlightForAllResults();
}

function collapseAll(){
    $("#results button").addClass("collapsed");
    $('#results .in').collapse("hide");
    $("#results textarea").attr("readonly","");//added
    $("#posts").unhighlight({ element: 'span', className: 'highlight' });
    $('#toggleAll').html("Show All");
    $('#toggleAll').attr("show", "false");
    selectedWordtoShowHighlights = false;
}

function highlightForAllResults(){
    $("#results .result").each(
        function(index, elem){
            highlightForOnlyOneResult($(elem));
        });
}

function highlightForOnlyOneResult($result){
    $result.find('.selectize-input .item').each(function(index, elem){
        highlightForOneItem(elem);
    });
}

function highlightForOneItem(elem){
    var itemText = $(elem).text();
    itemText = itemText.slice(0, -1);
    $('#'+$(elem).attr("referencedPost")).highlight(itemText);
}


function highlightAndAddToResult(referencedPost, selectedText){ //added modified
    if($("#results div").length > 0){
        $('#'+referencedPost).find("p").highlight(selectedText);//{ wordsOnly: true }
        $('.currentResult input')[0].selectize.createItem(selectedText);
        var $createdItem = $('.currentResult .selectize-input .item').last();
        $createdItem.attr("id", $('.currentResult').attr("id") + "-casual-"+($('.currentResult .selectize-input .item').length-1));
        $createdItem.attr("referencedPost", $('#'+referencedPost).attr("id"));
        if(currentType == 1 || (currentType == 2 && answerIsOn))
            $createdItem.find("a").remove();
        $("span:contains('" + selectedText + "')").each(
            function(index, elem){
                $(this).attr("referencedCasual",$createdItem.attr("id"));
            }); //oneTime, can be reassign after highlightForOnlyOneResult
        //$('.currentResult textarea').val($('.currentResult input')[0].selectize.items.join(" "));
        $("#addCausalAlert").hide();

        var tuple = {'data-value':$createdItem.attr('data-value'), 'postReference':$createdItem.attr('referencedPost'), 'referencedResult':$('.currentResult').attr('id')};
        var exist = false;
        wordAndReferencesMap.forEach(function(elem,index){
            if(elem['data-value'] == $createdItem.attr('data-value') && elem['referencedResult'] == $('.currentResult').attr('id')){
                exist = true;
                return;
            }
        });
        if(!exist)
            wordAndReferencesMap.push(tuple);
    }
    else{
        $("#addCausalAlert").show();
    }
    removeSelection();
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

function clearReferencedWordsFromPosts(){ //fix it
    if($('#toggleAll').attr("show") == "true"){

        $('.result').each(function(index, elem){
            $(elem).find('.selectize-input .item').each(function(index2, innerElem){
                var itemText = $(innerElem).text();
                itemText = itemText.slice(0, -1);
                $('#'+$(innerElem).attr("referencedPost")).removeHighlight(itemText);
            });
        });

    }
    else{
        $('.currentResult .selectize-input .item').each(function(index, elem){
            var itemText = $(elem).text();
            itemText = itemText.slice(0, -1);
            $('#'+$(elem).attr("referencedPost")).removeHighlight(itemText);
        });
    }
}

function isThereEmptyText(){
    var emptyText = false;
    $("#results .result").each(
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
    $("#results .result").each(
        function(index, elem){
            if($(elem).find(".selectize-input .item").length < 2){
                $(elem).find("#alertWords").show();
                emptyWords = true;
            }
        });

    return emptyWords;
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


/* From ORIGINAL END */
