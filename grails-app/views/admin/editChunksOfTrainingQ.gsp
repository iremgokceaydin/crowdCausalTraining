<%@ page import="crowdcausaltraining.QType" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="admin"/>
</head>
<body>

<h2>Edit Chunks of Training Question</h2>

    <g:hasErrors bean="${q}">
        <ul>
            <g:eachError var="err" bean="${q}">
                <li>${err}</li>
                <g:each in="${err.codes}" var="code">
                    <li>${code}</li>
                </g:each>
            </g:eachError>
        </ul>
    </g:hasErrors>

    <g:hasErrors bean="${q}">
        <ul>
            <g:eachError var="err" bean="${q}">
                <li>${err}</li>
            </g:eachError>
        </ul>
    </g:hasErrors>
<div class="row">
    <div class="col-md-6">
        <u>Posts:</u>
        <div class="alertMsg" id="addChunkAlert" style="display:none;">Add causal item first from the panel on the right.</div>
        <div id="posts-${q.id}">
            <g:each var="p" in="${q.posts}">
                <g:javascript>
                    var $div = createPost('${q.id}','${q.type.shortName}', '${p.postText}', '${p.id}', ${p.isLatest}, false, true, false);
                    $div.trigger('click');
                </g:javascript>
            </g:each>
        </div>
    </div>

    <div class="col-md-6">
        <u>Chunks:</u><br>

        <button id="addChunk-${q.id}" type="button" class="btn btn-primary">Add</button>
        <button id="removeChunk-${q.id}" type="button" class="btn btn-primary">Remove</button>
        <button id="toggleAll-${q.id}" type="button" class="btn btn-primary" style="float:right;">Show All</button><br><br>

        <div id="chunks-${q.id}" class="chunks panel-group">
            <g:each var="c" in="${admin.trainingAs?.findAll {it.question.id == q.id}?}">
                <g:javascript>
                    createChunk('${q.id}', '${q.type.shortName}', false, true, '${c.text}');
                </g:javascript>
                <g:each var="h" in="${c.highlights}">
                    <g:javascript>
                        var selectedText = '${h.text}';
                        highlightAndAddToChunk('${q.id}',"post-"+'${h.referencedPost.id}',selectedText,'${q.type.shortName}', false, true);
                    </g:javascript>
                </g:each>
            </g:each>
        </div>

    </div>

    <g:form action="updateChunksOfTrainingQ">
        <fieldset id="inputsToSubmit" style="border:none;">
        </fieldset>
        <div style="float:right">
            <g:submitButton name="Submit" onclick="return prepareInputsforAdminTrainingChunksSubmit(${q.id});"/>
        </div>
    </g:form>

</div>

<content tag="script">
    <script id="scriptContainer">
        $( document ).ready(function() {

            $('#addChunk-${q.id}').click(function() {
                createChunk('${q.id}','${q.type.shortName}', false, true, "");
            });

            $('#removeChunk-${q.id}').click(function() {
                removeChunk('${q.id}');
            });

            $('#toggleAll-${q.id}').click(function() {
                if ($(this).attr("show") == "true"){
                    if($("#chunks-${q.id} .chunk").length >= 1){
                        collapseAll('${q.id}');
                    }
                }
                else{
                    if($("#chunks-${q.id} .chunk").length >= 1){
                        expandAll(false,'${q.id}');
                    }
                }
            });

        });

    </script>
</content>

</body>
</html>