<%@ page import="crowdcausaltraining.QType" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="admin"/>
</head>
<body>

<h2>Edit Highlights of Testing Question</h2>
<div class="row">
    <div class="col-md-6">
        <u>Question:</u>
        <div id="post-0" class="post currentPost">
            <p>${q.questionText}</p>
            <g:each var="highlight" in="${q.highlights}">
                <g:javascript>
                    highlightListForTrainingQ.push("${highlight}");
                </g:javascript>
            </g:each>
        </div>
    </div>

    <div class="col-md-6">
        <g:hasErrors bean="${q}">
            <ul>
                <g:eachError var="err" bean="${q}">
                    <li>${err}</li>
                </g:eachError>
            </ul>
        </g:hasErrors>

        <u>Highlights:</u>
        <g:form action="updateHighlightsOfTestingQ">
            <fieldset id="inputsToSubmit">
                <g:hiddenField name="id" value="${q.id}"/>
            </fieldset>

            <div id="chunk-0" class="chunk currentChunk">
                <input type="text" placeholder="Highlight some words from the question (post)">
            </div>
            <br>
            <g:submitButton name="Submit" onclick="return prepareInputsforAdminTestingHighlightsSubmit();"/>
        </g:form>
    </div>

</div>

<content tag="script">
    <script>
        $( document ).ready(function() {
            var $chunk = $(".chunk");
            var $input = $(".chunk input");
            $input.selectize({
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
                    $(item).click(function(e){
                        var target = e.target || e.srcElement;
                        if(target.tagName != "A"){ //if cross is clicked to remove a word
                            if(selectedWordtoShowHighlights && lastItemToHighlightPost == $(item).attr('data-value')){
                                $(item).removeClass('active');
                                selectedWordtoShowHighlights = false;
                                highlightForOnlyOneChunk($chunk);
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
                    $('#' + $(item).attr('referencedPost')).removeHighlight(value);
                    if(lastItemToHighlightPost == $(item).attr('data-value')){
                        highlightForOnlyOneChunk($chunk);
                        selectedWordtoShowHighlights = false;
                    }
                }
            });


            $(".post").click(function(){
                if($.selection() != "")
                    selectedText = $.selection();

                if(selectedText){
                    $('.currentPost p').highlight(selectedText);//{ wordsOnly: true }
                    $('.currentChunk input')[0].selectize.createItem(selectedText);
                    var createdItem = $('.currentChunk .selectize-input div').last();
                    createdItem.attr("id", $('.currentChunk').attr("id") + "-highlight-"+($('.currentChunk .selectize-input div').length-1));
                    createdItem.attr("referencedPost", $('.currentPost').attr("id"));
                    $(".currentPost span:contains('" + selectedText + "')").each(
                            function(index, elem){
                                $(this).attr("referencedChunk",createdItem.attr("id"));
                            }
                    ); //oneTime, can be reassign after highlightForOnlyOneResult
                    removeSelection();
                }

            });

            $('.currentChunk .selectize-input input').attr("readonly",'');

            highlightListForTrainingQ.forEach(function (item) {
                selectedText = item;
                $(".post").trigger("click");
            });
        });

    </script>
</content>

</body>
</html>