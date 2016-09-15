<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
</head>
<body>

<h1>Testing Examples - Answers </h1>
<g:javascript>
    var numberOfCorrect = 0;
</g:javascript>
<g:each var="q" in="${qs}" status="i">
    <div class="row">
        <p class="passage" id="${q.id}">Q-${i+(page-1)*pageFactorTesting}: ${q.questionText}</p>
        <g:if test="${q.type.shortName} == 'Type2'">
            <g:each var="highlight" in="${q.highlights}">
                <g:javascript>
                    $('#${q.id}').highlight('${highlight}');
                </g:javascript>
            </g:each>
        </g:if>

        <div class="col-md-6">
            <u>Your Answer:</u> <img style="display: none" id="worker_answer_${q.id}_isCorrect" width="30px" height="30px" src="${assetPath(src: 'ok.png')}"/><img style="display: none" id="worker_answer_${q.id}_isWrong" width="30px" height="30px" src="${assetPath(src: 'cross.png')}"/>
            <p>
                <g:each var="a" in="${q.answers}">
                    <g:if test="${worker.testingAs != null && worker.testingAs.find {it.id == a.id} != null}">
                        <label class="checkbox-inline"><input name="worker_answer_${q.id}" type="radio" value="${a.id}" checked='checked' disabled>&nbsp;${a.answerText}</label>
                        <g:if test="${admin.testingAs.find {it.id == a.id} != null}">
                            <g:javascript>
                                $("#worker_answer_${q.id}_isCorrect").show();
                                numberOfCorrect++;
                            </g:javascript>
                        </g:if>
                        <g:else>
                            <g:javascript>
                                $("#worker_answer_${q.id}_isWrong").show();
                            </g:javascript>
                        </g:else>
                        <br>
                    </g:if>
                    <g:else>
                        <label class="checkbox-inline"><input name="worker_answer_${q.id}" type="radio" value="${a.id}" disabled>&nbsp;${a.answerText}</label><br>
                    </g:else>

                </g:each>
            </p>
        </div>
        <div class="col-md-6">
            <u>Suggested Answer:</u>
            <p>
                <g:each var="a" in="${q.answers}">
                    <g:if test="${admin.testingAs != null && admin.testingAs.find {it.id == a.id} != null}">
                        <label class="checkbox-inline"><input name="admin_answer_${q.id}" type="radio" value="${a.id}" checked='checked' disabled>&nbsp;${a.answerText}</label><br>
                    </g:if>
                    <g:else>
                        <label class="checkbox-inline"><input name="admin_answer_${q.id}" type="radio" value="${a.id}" disabled>&nbsp;${a.answerText}</label><br>
                    </g:else>

                </g:each>
            </p>
        </div>
    </div>
</g:each>


<content tag="script">
    <script>
        var $target = $('#step2_icon');
        activateStep($target);
        $( document ).ready(function() {
            var page = ${page};
            var totalPage = ${totalPage};


            if(numberOfCorrect == ${qs.size()}) {
                $("#step2next").text("Start Training");
                $("#step2next").click(function (e) {
                    window.location.href = "/introduction/tutorial?worker_id=${worker.workerId}";
                });
                $("#step2nextA").click(function (e) {
                    if (totalPage > page) {
                        window.location.href = "/testing?page=" + (page + 1) + "&worker_id=${worker.workerId}";
                    }
                    else
                        alert("In fact, this was the last page for testing questions. Please start training now.");
                });
            }

            else {
                $("#step2next").hide();
                $("#step2nextA").click(function (e) {
                    if (totalPage > page) {
                        window.location.href = "/testing?page=" + (page + 1) + "&worker_id=${worker.workerId}";
                    }
                    else {
                        window.location.href = "/complete/fail?worker_id=${worker.workerId}";
                    }
                });
            }

            $(".prev-step").click(function (e) {
                $("#footer").hide();
                var page = ${page};
                window.location.href = "/testing?page=" + (page) + "&worker_id=${worker.workerId}";

            });


        });

    </script>
</content>

</body>
</html>