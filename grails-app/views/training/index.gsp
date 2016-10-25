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

        <g:if test="${qType == 'Type1'}">
            <h2>Goal (Task 1): Describe the causal knowledge in the highlighted texts.</h2>
            <p>
                Congratulations on passing testing stage! Now it’s time to get a little bit more complex again.


                In this set of posts, there will be highlighted portions of text that you will provide a simple sentence to describe the causal knowledge, for example: <br><br>

                “I was having an asthma attack, and so I went to the E.R.”<br>
                would translate into causally:<br>
                “going to the E.R. decreases asthma attack symptoms” or something similar.<br><br>


                Keep in mind that there can be more than one piece of causal knowledge being exhibited in the post, or there can be multiple instances of causal knowledge in just one section of the post.
            </p>

            <p>You can use the text fields in chunks to express the causal knowledge represented by highlighted variables.</p>
        </g:if>
        <g:elseif test="${qType == 'Type2'}">
            <h2>Goal (Task 2): Highlight the texts expressing causal knowledge and provide a simple sentence to describe that causal knowledge.</h2>
            <p>
                In this set of posts, after identifying statements that express causal knowledge, you will create chunks using the button "Add". Then, you will highlight portions of text from the posts which express causal knowledge by selecting them. Selection will automatically add the selected texts to the created and currently selected chunk. Then, you will express cause and effect relationships in your own words using the text field of each chunk.<br><br>

                A causal statement expresses a single cause and a single effect. If there are multiple causal statements in a post or across the posts you will express each one individually by creating new chunks.
            </p>
        </g:elseif>
        <g:else >
            <h2>Goal (Task 3): Same with the goal of Task 2, but this time there is no predefined answers.</h2>
            <p>
                In this final set of posts, you will be highlighting and then giving the causal knowledge explanations for each highlighted chunk. Exactly like the format in test three, just this time, on your own.<br><br>

                You will be graded by the researchers to determine if the training materials were effective, and if you will be asked to participate in the final task to formally code posts to help with our research.
            </p>
        </g:else>
        <g:each var="q" in="${qs}" status="j">
            <br>
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