<%@ page import="crowdcausaltraining.Owner" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
</head>
<body>

<h1>Training Task</h1>
<div class="row">

    <g:hasErrors bean="${worker}">
        <ul class="fieldError">
            <g:eachError var="err" bean="${worker}">
                <li><g:message error="${err}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>


    <g:if test="${qs.empty}">
        <p>There are no questions yet!</p>

    </g:if>
    <g:else>
        <g:each var="q" in="${qs}">
            <div class="col-md-6">
                <u>Posts:</u>
                <div class="alertMsg" id="addChunkAlert" style="display:none;">Add causal item first from the panel on the right.</div>
                <div id="posts">
                    <g:each var="p" in="${q.posts}">
                        <g:javascript>
                        var $div = createPost('${q.type.shortName}', '${p.postText}', '${p.id}', ${p.isLatest}, false, false);
                        $div.trigger('click');
                        </g:javascript>
                    </g:each>
                </div>
            </div>

            <div class="col-md-6">
                <u>Chunks:</u><br>

                <g:if test="${qType != 'Type1'}">
                    <button id="addChunk" type="button" class="btn btn-primary">Add</button>
                    <button id="removeChunk" type="button" class="btn btn-primary">Remove</button>
                </g:if>

                <button id="toggleAll" type="button" class="btn btn-primary" style="float:right;">Show All</button><br><br>

                <div id="chunks" class="chunks panel-group">
                    <g:each var="c" in="${q.chunks}">
                        <g:if test="${crowdcausaltraining.Owner.findByType("Admin").trainingAs.find{it.id == c.id} != null}">
                            <g:javascript>
                            createChunk('chunks', '${q.type.shortName}', false, false, '${worker.trainingAs.find{it.question.id==c.question.id}?.text}', "toggleAll");
                            </g:javascript>
                            <g:each var="h" in="${c.highlights}">
                                <g:javascript>
                                var selectedText = '${h.text}';
                                highlightAndAddToChunk("chunks","post-"+'${h.referencedPost.id}',selectedText,'${q.type.shortName}', false, false);
                                </g:javascript>
                            </g:each>
                        </g:if>
                    </g:each>
                </div>

            </div>

            <g:form action="save" name="formToSubmit">
                <fieldset id="inputsToSubmit">
                    <g:hiddenField name="id" value="${q.id}"/>
                    <g:hiddenField name="worker_id" value="${worker.workerId}"/>
                    <g:hiddenField name="qType" value="${qType}"/>
                    <g:hiddenField name="page" value="${page}"/>
                </fieldset>
            </g:form>
        </g:each>
    </g:else>
</div>


<content tag="script">
    <script>
        var $target = $('#step4_icon');
        activateStep($target);
        $( document ).ready(function() {
            if('${qs.empty}' == 'true')
                $(".next-step").hide()
            else {
                $(".next-step").click(function (e) {
                    return validateTrainingFormAndSubmit(e);
                });
            }

            $(".prev-step").click(function (e) {
                //$("#footer").hide();
                var page = ${page};
                if(page > 1){
                    window.location.href = "/training/answer?qType=${qType}&page=" + (page-1) + "&worker_id=${worker.workerId}";
                }
                else {
                    window.location.href = "/introduction/tutorial?worker_id=${worker.workerId}";
                }
            });
        });

        function validateTrainingFormAndSubmit(e) {
            e.preventDefault();
            if(prepareInputsforAdminTrainingChunksSubmit()) {
                $("#formToSubmit").submit();
                return true;
            }
            else
                return false;
        }

        $('#addChunk').click(function() {
            createChunk('chunks','${qType}', false, false, "", "toggleAll");
        });

        $('#removeChunk').click(function() {
            removeChunk();
        });

        $('#toggleAll').click(function() {
            if ($(this).attr("show") == "true"){
                if($("#chunks .chunk").length >= 1){
                    collapseAll("chunks", "toggleAll");
                }
            }
            else{
                if($("#chunks .chunk").length >= 1){
                    expandAll(false,"chunks", "toggleAll");
                }
            }
        });


    </script>
</content>

</body>
</html>