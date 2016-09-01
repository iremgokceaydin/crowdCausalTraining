<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
</head>
<body>

<h1>Training Task</h1>


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
            <div class="row">
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
            <div class="row">
                <div class="col-md-6">
                    <u>Your Chunks:</u><br>

                    <button id="toggleAll-1" type="button" class="btn btn-primary" style="float:right;">Show All</button><br><br>

                    <div id="chunks-1" class="panel-group">
                        <g:each var="c" in="${q.chunks}">
                            <g:if test="${worker.trainingAs.find{it.id == c.id} != null}">
                                <g:javascript>
                                    createChunk('chunks-1', '${q.type.shortName}', true, false,'${c.text}', "toggleAll-1");
                                </g:javascript>
                                <g:each var="h" in="${c.highlights}">
                                    <g:javascript>
                                        var selectedText = '${h.text}';
                                        highlightAndAddToChunk("chunks-1","post-"+'${h.referencedPost.id}',selectedText,'${q.type.shortName}', false, false);
                                    </g:javascript>
                                </g:each>
                            </g:if>
                        </g:each>
                    </div>
                </div>

                <div class="col-md-6">
                    <u>Correct Chunks:</u><br>

                    <button id="toggleAll-2" type="button" class="btn btn-primary" style="float:right;">Show All</button><br><br>

                    <div id="chunks-2" class="panel-group">
                        <g:each var="c" in="${q.chunks}">
                            <g:if test="${admin.trainingAs.find{it.id == c.id} != null}">
                                <g:javascript>
                                    createChunk('chunks-2', '${q.type.shortName}', true, true,'${c.text}', "toggleAll-2");
                                </g:javascript>
                                <g:each var="h" in="${c.highlights}">
                                    <g:javascript>
                                        var selectedText = '${h.text}';
                                        highlightAndAddToChunk("chunks-2","post-"+'${h.referencedPost.id}',selectedText,'${q.type.shortName}', false, false);
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
                        <g:hiddenField name="page" value="${page}"/>
                    </fieldset>
                </g:form>
            </div>
        </g:each>
    </g:else>



<content tag="script">
    <script>
        var $target = $('#step4_icon');
        activateStep($target);
        $( document ).ready(function() {
            $(".next-step").text("Continue");
            $(".next-step").click(function (e) {
                var page = ${page};
                var totalPage = ${totalPage};
                if (totalPage > page)
                {
                    window.location.href = "/training?qType=${qType}&page=" + (page+1) + "&worker_id=${worker.workerId}";
                }
                else
                {
                    window.location.href = "/complete?worker_id=${worker.workerId}";
                }
            });

            $(".prev-step").click(function (e) {
                //$("#footer").hide();
                var page = ${page};
                window.location.href = "/training?qType=${qType}&page=" + page + "&worker_id=${worker.workerId}";
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

        $('#toggleAll-1').click(function() {
            if ($(this).attr("show") == "true"){
                if($("#chunks-1 .chunk").length >= 1){
                    collapseAll("chunks-1", "toggleAll-1");
                }
            }
            else{
                if($("#chunks-1 .chunk").length >= 1){
                    expandAll(false,"chunks-1", "toggleAll-1");
                }
            }
        });

        $('#toggleAll-2').click(function() {
            if ($(this).attr("show") == "true"){
                if($("#chunks-2 .chunk").length >= 1){
                    collapseAll("chunks-2", "toggleAll-2");
                }
            }
            else{
                if($("#chunks-2 .chunk").length >= 1){
                    expandAll(false,"chunks-2", "toggleAll-2");
                }
            }
        });


    </script>
</content>

</body>
</html>