<%@ page import="crowdcausaltraining.Owner" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
</head>
<body>

<h1>Training Stage</h1>
<div class="row">

    <g:hasErrors bean="${worker}">
        <ul class="fieldError">
            <g:eachError var="err" bean="${worker}">
                <li><g:message error="${err}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>


    <g:if test="${qs.empty}">
        <p>There are no examples yet!</p>

    </g:if>
    <g:else>
        <div style="color: #4294d3;">
            <p>
                <span style="text-decoration:underline;font-weight:bold;">STEP ONE: </span><br>
                <span>Identifying causal knowledge contained in people’s statements.</span>
            </p>
            <p>
                <span style="text-decoration:underline;font-weight:bold;">STEP TWO: </span><br>
                <span>Identifying the variables within this causal knowledge.</span>
            </p>
            <p>
                <span style="text-decoration:underline;font-weight:bold;">STEP THREE: </span><br>
                <span>Rewrite them so that cause and effect are clear.</span>
            </p>
        </div>


        <g:if test="${qType == 'Type1'}">
            <p>Task 1 : Enter an expression for the causal knowledge in each chunk. Use the text fields in chunks to express the causal knowledge represented by highlighted variables.</p>
        </g:if>
        <g:elseif test="${qType == 'Type2'}">
            <p>After you have identified statements that express causal knowledge and the variables (by highlighting them) that allow a statement to express causal knowledge you will express cause and effect relationships with your own words in the given text field of each chunk.</p>
            <p>A causal statement expresses a single cause and a single effect. If there are multiple causal statements in a post or across the posts you will express each one individually by creating new chunks.</p>
            <p>Task 2: Create chunks for posts!</p>
        </g:elseif>
        <g:else >
            <p>After you have identified statements that express causal knowledge and the variables (by highlighting them) that allow a statement to express causal knowledge you will express cause and effect relationships with your own words in the given text field of each chunk.</p>
            <p>A causal statement expresses a single cause and a single effect. If there are multiple causal statements in a post or across the posts you will express each one individually by creating new chunks.</p>
            <h3>Task 3: Create chunks for posts and it will be evaluated later!</h3>
        </g:else>
        <g:each var="q" in="${qs}" status="j">
            <div class="col-md-6">
                <u>Q-${j+1+(page-1)*pageFactorTraining} Posts:</u><br>
                <div class="alertMsg" id="addChunkAlert" style="display:none;">Add causal item first from the panel on the right.</div>
                <g:if test="${qType == 'Type1' || ((qType == 'Type2' || qType == 'Type3') && !worker?.trainingAs?.findAll{it.question.id==q.id}.empty)}">
                    <div id="posts-${q.id}" class="posts">
                        <g:each var="p" in="${q.posts}">
                            <g:javascript>
                            var $div = createPost('${q.id}','${q.type.shortName}', '${p.postText}', '${p.id}', ${p.isLatest}, false, false, false);
                            $div.trigger('click');
                            </g:javascript>
                        </g:each>
                    </div>
                </g:if>
                <g:elseif test="${(qType == 'Type2' || qType == 'Type3') && worker?.trainingAs?.findAll{it.question.id==q.id}.empty}">
                    <button id="showPosts-${q.id}" type="button" class="btn btn-primary showPosts" questionId="${q.id}" attempt="0">Show Previous Posts</button>
                    <div id="posts-${q.id}" class="posts">
                            <g:javascript>
                            var $div = createPost('${q.id}','${q.type.shortName}', '${q.latestPost().postText}', '${q.latestPost().id}', true, false, false, false);
                            $div.trigger('click');
                            </g:javascript>
                    </div>
                </g:elseif>
            </div>

            <div class="col-md-6">
                <u>Chunks:</u><br>
                <g:if test="${qType == 'Type1'}">
                    <g:if test="${!(admin.trainingAs?.findAll {it.question.id == q.id}?.empty)}">
                        <button id="toggleAll-${q.id}" type="button" class="btn btn-primary toggleAll" style="float:right;" questionId="${q.id}">Show All</button><br><br>
                        <div id="chunks-${q.id}" class="chunks panel-group">
                            <g:each var="c" in="${admin.trainingAs.findAll {it.question.id == q.id}}" status="i">
                                <g:if test="${worker?.trainingAs?.findAll{it.question.id==c.question.id}.empty}">
                                    <g:javascript>
                                        createChunk('${q.id}', '${q.type.shortName}', false, false, '');
                                    </g:javascript>
                                </g:if>
                                <g:else>
                                    <g:javascript>
                                        createChunk('${q.id}', '${q.type.shortName}', false, false, '${worker?.trainingAs?.findAll{it.question.id==c.question.id}?.collect()[i].text}');
                                    </g:javascript>
                                </g:else>
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
                        <p>There are no chunks added yet!</p>
                    </g:else>
                </g:if>
                <g:elseif test="${qType == 'Type2' || qType == 'Type3'}">
                    <g:if test="${qType == 'Type2' && (admin.trainingAs?.findAll {it.question.id == q.id}?.empty)}">
                        <p>There are no chunks added yet for this example!</p>
                    </g:if>
                    <g:else>
                        <button id="addChunk-${q.id}" type="button" class="btn btn-primary addChunk" questionId="${q.id}">Add</button>
                        <button id="removeChunk-${q.id}" type="button" class="btn btn-primary removeChunk" questionId="${q.id}">Remove</button>
                        <button id="toggleAll-${q.id}" type="button" class="btn btn-primary toggleAll" style="float:right;" questionId="${q.id}">Show All</button><br><br>
                        <div id="chunks-${q.id}" class="chunks panel-group">
                            <g:each var="c" in="${worker.trainingAs.findAll {it.question.id == q.id}}">
                                <g:javascript>
                                createChunk('${q.id}', '${q.type.shortName}', false, false, '${c.text}');
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
                    </g:else>
                </g:elseif>

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
                    if($('.chunk').length == 0) {
                        alert("Add chunks first!");
                        return false;
                    }
                    else {
                        var qIds = ${qs.collect{it.id}};
                        var allOkay = [];
                        for (var i = 0; i < qIds.length; i++) {
                            allOkay.push(prepareInputsforAdminTrainingChunksSubmit(qIds[i]));
                        }
                        if (allOkay.includes(false))
                            return false;
                        else {
                            $("#formToSubmit").submit();
                            return true;
                        }
                    }
                });
            }

            $(".prev-step").click(function (e) {
                //$("#footer").hide();
                var page = ${page};
                var totalPageType1 = ${totalPageType1};
                var totalPageType2 = ${totalPageType2};
                var totalPageType3 = ${totalPageType3};

                if('${qType}' == 'Type1') {
                    if (page > 1) {
                        window.location.href = "/training/answer?qType=Type1&page=" + (page - 1) + "&worker_id=${worker.workerId}";
                    }
                    else {
                        window.location.href = "/introduction/tutorial?worker_id=${worker.workerId}";
                    }
                }
                else if('${qType}' == 'Type2') {
                    if (page > 1) {
                        window.location.href = "/training/answer?qType=Type2&page=" + (page - 1) + "&worker_id=${worker.workerId}";
                    }
                    else {
                        if(totalPageType1 > 0)
                            window.location.href = "/training/answer?qType=Type1&page="+totalPageType1+"&worker_id=${worker.workerId}";
                        else
                            window.location.href = "/introduction/tutorial?worker_id=${worker.workerId}";
                    }
                }
                else if('${qType}' == 'Type3') {
                    if (page > 1) {
                        window.location.href = "/training?qType=Type3&page=" + (page - 1) + "&worker_id=${worker.workerId}";
                    }
                    else {
                        if(totalPageType2 > 0)
                            window.location.href = "/training/answer?qType=Type2&page="+totalPageType2+"&worker_id=${worker.workerId}";
                        else if(totalPageType1 > 0)
                            window.location.href = "/training/answer?qType=Type1&page="+totalPageType1+"&worker_id=${worker.workerId}";
                        else
                            window.location.href = "/introduction/tutorial?worker_id=${worker.workerId}";
                    }
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

        $('.showPosts').click(function() {
            var $button = $(this);
            var qId = $button.attr("questionId");
            var attempt = parseInt($button.attr("attempt"));
            $.ajax({
                url: "/training/showPosts?qId="+qId+"&attempt="+attempt
            }).done(function(data) {
                $("body").append(data);
                if(data.indexOf("alert") == -1){
                    $button.attr("attempt", attempt+1);
                    $("#posts-"+qId).animate({
                        scrollTop: 0
                    }, 500);
                }
            });
        });

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