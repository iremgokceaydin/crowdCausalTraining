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
        <g:if test="${qType == 'Type1'}">
            <h2>Task 1 : Enter text for each chunk!</h2>
        </g:if>
        <g:elseif test="${qType == 'Type2'}">
            <h2>Task 2: Create chunks for posts!</h2>
        </g:elseif>
        <g:else >
            <h2>Task 3: Create chunks for posts and it will be evaluated later!</h2>
        </g:else>
        <g:each var="q" in="${qs}">
            <div class="col-md-6">
                <u>Posts:</u>
                <div class="alertMsg" id="addChunkAlert" style="display:none;">Add causal item first from the panel on the right.</div>
                <div id="posts-${q.id}">
                    <g:each var="p" in="${q.posts}">
                        <g:javascript>
                        var $div = createPost('${q.id}','${q.type.shortName}', '${p.postText}', '${p.id}', ${p.isLatest}, false, false);
                        $div.trigger('click');
                        </g:javascript>
                    </g:each>
                </div>
            </div>

            <div class="col-md-6">
                <u>Chunks:</u><br>
                <g:if test="${!(admin.trainingAs?.findAll {it.question.id == q.id}?.empty)}">

                    <g:if test="${qType != 'Type1'}">
                        <button id="addChunk-${q.id}" type="button" class="btn btn-primary addChunk" questionId="${q.id}">Add</button>
                        <button id="removeChunk-${q.id}" type="button" class="btn btn-primary removeChunk" questionId="${q.id}">Remove</button>
                    </g:if>

                    <button id="toggleAll-${q.id}" type="button" class="btn btn-primary toggleAll" style="float:right;" questionId="${q.id}">Show All</button><br><br>

                    <div id="chunks-${q.id}" class="chunks panel-group">
                        <g:each var="c" in="${admin.trainingAs.findAll {it.question.id == q.id}}">
                            <g:javascript>
                            createChunk('${q.id}', '${q.type.shortName}', false, false, '${worker.trainingAs.find{it.question.id==c.question.id}?.text}');
                            </g:javascript>
                            <g:each var="h" in="${c.highlights}">
                                <g:javascript>
                                var selectedText = '${h.text}';
                                highlightAndAddToChunk("${q.id}","post-"+'${h.referencedPost.id}',selectedText,'${q.type.shortName}', false, false);
                                </g:javascript>
                            </g:each>
                        </g:each>
                        <g:javascript>
                            expandAll(false,"${q.id}");
                        </g:javascript>
                    </div>
                </g:if>
                <g:else>
                    <p>There is no chunks added yet!</p>
                </g:else>

            </div>

        </g:each>
        <g:form action="save" name="formToSubmit">
            <fieldset id="inputsToSubmit" style="border:none;">
                <g:hiddenField name="worker_id" value="${worker.workerId}"/>
                <g:hiddenField name="qType" value="${qType}"/>
                <g:hiddenField name="page" value="${page}"/>
            </fieldset>
        </g:form>
    </g:else>
</div>


<content tag="script">
    <script>
        var $target = $('#step4_icon');
        activateStep($target);
        $( document ).ready(function() {
            if('${qs.empty}' == 'true' || ('${qType}' == 'Type1' && $('.chunk').length == 0))
                $(".next-step").hide();
            else {
                $(".next-step").click(function (e) {
                    e.preventDefault();
                    var qIds = ${qs.collect{it.id}};
                    for(var i = 0; i < qIds.length; i++){
                        prepareInputsforAdminTrainingChunksSubmit(qIds[i]);
                    }
                    $("#formToSubmit").submit();
                    return true;
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

//        function validateTrainingFormAndSubmit(e) {
//            e.preventDefault();
//            if(prepareInputsforAdminTrainingChunksSubmit()) {
//                $("#formToSubmit").submit();
//                return true;
//            }
//            else
//                return false;
//        }

        $('.addChunk').click(function() {
            createChunk($(this).attr("questionId"),'${qType}', false, false, "");
        });

        $('.removeChunk').click(function() {
            removeChunk($(this).attr("questionId"));
        });

        $('.toggleAll').click(function() {
            if ($(this).attr("show") == "true"){
                if($("#" + "chunks-"+$(this).attr("questionId") + " .chunk").length >= 1){
                    collapseAll($(this).attr("questionId"));
                }
            }
            else{
                if($("#" + "chunks-"+$(this).attr("questionId") + " .chunk").length >= 1){
                    expandAll(false,$(this).attr("questionId"));
                }
            }
        });


    </script>
</content>

</body>
</html>