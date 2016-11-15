<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
</head>
<body>

<h1>Training Stage - Answers</h1>


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
            <h2>Task 1 : Answers</h2>
        </g:if>
        <g:else test="${qType == 'Type2'}">
            <h2>Task 2: Answers</h2>
        </g:else>
        <p>You can compare your answers with the suggested ones in the following section.</p>
        <g:each var="q" in="${qs}" status="i">
            <g:javascript>
                totalNumberofPosts = ${q.posts.size()};
            </g:javascript>
            <div class="row answerPost">
                <u>Q-${i+1+(page-1)*pageFactorTraining} Post(s):</u>
                <div class="alertMsg" id="addChunkAlert" style="display:none;">Add causal item first from the panel on the right.</div>
                <div id="posts-${q.id}" class="posts">
                    <g:each var="p" in="${q.posts}">
                        <g:javascript>
                            var $div = createPost('${q.id}','${q.type.shortName}', '${p.postText}', '${p.id}', ${p.isLatest}, false, false, false);
                            $div.trigger('click');
                        </g:javascript>
                    </g:each>
                </div>
            </div><br>
            <div class="row">
                <div class="col-md-5 answerChunks">
                    <u>Your Chunks:</u><br>

                    <button id="toggleAll-${q.id}-w" type="button" class="btn btn-primary toggleAll" style="float:right;" questionId="${q.id}-w">Show All</button><br><br>

                    <div id="chunks-${q.id}-w" class="chunks panel-group">
                        <g:each var="c" in="${worker.trainingAs?.findAll {it.question.id == q.id}}">
                            <g:javascript>
                                createChunk('${q.id}-w', '${q.type.shortName}', true, false,'${c.text}');
                            </g:javascript>
                            <g:each var="h" in="${c.highlights}">
                                <g:javascript>
                                    var selectedText = '${h.text}';
                                    highlightAndAddToChunk('${q.id}-w',"post-"+'${h.referencedPost.id}',selectedText,'${q.type.shortName}', false, false);
                                </g:javascript>
                            </g:each>
                        </g:each>
                        <g:javascript>
                            expandAll(true,"${q.id}-w");
                        </g:javascript>
                    </div>
                </div>

                <div class="col-md-5 answerChunks">
                    <u>Suggested Chunks:</u><br>

                    <button id="toggleAll-${q.id}-a" type="button" class="btn btn-primary toggleAll" style="float:right;" questionId="${q.id}-a">Show All</button><br><br>

                    <div id="chunks-${q.id}-a" class="chunks panel-group">
                        <g:each var="c" in="${admin.trainingAs?.findAll {it.question.id == q.id}}">
                            <g:javascript>
                                createChunk('${q.id}-a', '${q.type.shortName}', true, true,'${c.text}');
                            </g:javascript>
                            <g:each var="h" in="${c.highlights}">
                                <g:javascript>
                                    var selectedText = '${h.text}';
                                    highlightAndAddToChunk("${q.id}-a","post-"+'${h.referencedPost.id}',selectedText,'${q.type.shortName}', false, false);
                                </g:javascript>
                            </g:each>
                        </g:each>
                        <g:javascript>
                            expandAll(true,"${q.id}-a");
                        </g:javascript>
                    </div>

                </div>

                <g:form action="save" name="formToSubmit">
                    <fieldset id="inputsToSubmit" style="border:none;">
                        <g:hiddenField name="id" value="${q.id}"/>
                        <g:hiddenField name="worker_id" value="${worker.workerId}"/>
                        <g:hiddenField name="page" value="${page}"/>
                    </fieldset>
                </g:form>
            </div>
            <br>
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
                var totalPageType1 = ${totalPageType1};
                var totalPageType2 = ${totalPageType2};
                var totalPageType3 = ${totalPageType3};

                if('${qType}' == 'Type1') {
                    if (totalPageType1 > page) {
                        window.location.href = "/training?qType=Type1&page=" + (page + 1) + "&worker_id=${worker.workerId}";
                    }
                    else {
                        if(totalPageType2 > 0)
                            window.location.href = "/training?qType=Type2&page=1&worker_id=${worker.workerId}";
                        else if(totalPageType3 > 0)
                            window.location.href = "/training?qType=Type3&page=1&worker_id=${worker.workerId}";
                        else
                            window.location.href = "/complete/success?worker_id=${worker.workerId}";
                    }
                }
                else if('${qType}' == 'Type2') {
                    if (totalPageType2 > page) {
                        window.location.href = "/training?qType=Type2&page=" + (page + 1) + "&worker_id=${worker.workerId}";
                    }
                    else {
                        if(totalPageType3 > 0)
                            window.location.href = "/training?qType=Type3&page=1&worker_id=${worker.workerId}";
                        else
                            window.location.href = "/complete/success?worker_id=${worker.workerId}";
                    }
                }
                else if('${qType}' == 'Type3') {
                    if (totalPageType3 > page) {
                        window.location.href = "/training?qType=Type3&page=" + (page + 1) + "&worker_id=${worker.workerId}";
                    }
                    else {
                        window.location.href = "/complete/success?worker_id=${worker.workerId}";
                    }
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

        $('.toggleAll').click(function() {
            if ($(this).attr("show") == "true"){
                if($("#" + "chunks-"+$(this).attr("questionId") + " .chunk").length >= 1){
                    collapseAll($(this).attr("questionId"));
                }
            }
            else{
                if($("#" + "chunks-"+$(this).attr("questionId") + " .chunk").length >= 1){
                    expandAll(true,$(this).attr("questionId"));
                }
            }
        });


    </script>
</content>

</body>
</html>