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
        <div id="posts">
            <g:each var="p" in="${q.posts}">
                <g:javascript>
                    var $div = createPost('${q.type.shortName}', '${p.postText}', '${p.id}', ${p.isLatest}, false, true);
                    $div.trigger('click');
                </g:javascript>
            </g:each>
        </div>
    </div>

    <div class="col-md-6">
        <u>Chunks:</u><br>

        <button id="addChunk" type="button" class="btn btn-primary">Add</button>
        <button id="removeChunk" type="button" class="btn btn-primary">Remove</button>
        <button id="toggleAll" type="button" class="btn btn-primary" style="float:right;">Show All</button><br><br>

        <div id="chunks" class="panel-group">
            <g:each var="c" in="${q.chunks}">
                <g:javascript>
                    createChunk('${c.id}', '${q.type.shortName}', false, true);
                </g:javascript>
                <g:each var="h" in="${c.highlights}">
                    <g:javascript>
                        var selectedText = '${h.text}';
                        highlightAndAddToChunk("post-"+'${h.referencedPost.id}',selectedText,'${q.type.shortName}', false, true);
                    </g:javascript>
                </g:each>
            </g:each>
        </div>

    </div>

    <g:form action="updateChunksOfTrainingQ">
        <fieldset id="inputsToSubmit">
            <g:hiddenField name="id" value="${q.id}"/>
        </fieldset>
        <div style="float:right">
            <g:submitButton name="Submit" onclick="return prepareInputsforAdminTrainingChunksSubmit();"/>
        </div>
    </g:form>

</div>

<content tag="script">
    <script id="scriptContainer">
        $( document ).ready(function() {

            $('#addChunk').click(function() {
                createChunk('${q.type.shortName}', false, true);
            });

            $('#removeChunk').click(function() {
                removeChunk();
            });

            $('#toggleAll').click(function() {
                if ($(this).attr("show") == "true"){
                    if($("#chunks .chunk").length >= 1){
                        collapseAll();
                    }
                }
                else{
                    if($("#chunks .chunk").length >= 1){
                        expandAll(false);
                    }
                }
            });

        });

    </script>
</content>

</body>
</html>