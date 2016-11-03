<%@ page import="crowdcausaltraining.Settings" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
</head>
<body>

<h1>Testing Stage - Answers </h1>
<p>You can compare your answers with the suggested ones:</p>
<g:each var="q" in="${qs}" status="i">
    <hr><div class="row">
        <p class="passage" id="${q.id}">Q-${i+1+(page-1)*pageFactor}: ${q.questionText}</p>
        <g:if test="${q.type.shortName} == 'Type2'">
            <g:each var="highlight" in="${q.highlights}">
                <g:javascript>
                    $('#${q.id}').highlight('${highlight}');
                </g:javascript>
            </g:each>
        </g:if>

        <div class="col-md-6">
            <u style="font-weight: bolder">Your Answer:</u>
                %{--<img style="display: none" id="worker_answer_${q.id}_isCorrect" width="30px" height="30px" src="${assetPath(src: 'ok.png')}"/>--}%
                %{--<img style="display: none" id="worker_answer_${q.id}_isWrong" width="30px" height="30px" src="${assetPath(src: 'cross.png')}"/>--}%
            <p>
                <g:each var="a" in="${q.answers}">
                    <g:if test="${worker.testingAs != null && worker.testingAs.find {it.id == a.id} != null}">
                        <label class="checkbox-inline"><input name="worker_answer_${q.id}" type="radio" value="${a.id}" checked='checked' disabled>&nbsp;${a.answerText}</label>
                        <g:if test="${admin.testingAs.find {it.id == a.id} != null}">
                            <g:javascript>
                                // $("#worker_answer_${q.id}_isCorrect").show();
                                $("#${q.id}").parent().css("background", "rgba(87, 187, 58, 0.23)");
                            </g:javascript>
                        </g:if>
                        <g:else>
                            <g:javascript>
                                // $("#worker_answer_${q.id}_isWrong").show();
                                $("#${q.id}").parent().css("background", "rgba(187, 58, 58, 0.23)");
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
            <u style="font-weight: bolder">Suggested Answer:</u>
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

<!-- Modal -->
<div class="modal fade" id="jumpToType2" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Jump to the Complex Questions</h4>
            </div>
            <div class="modal-body" style="text-align: center">
                <img width="30px" height="30px" src="${assetPath(src: 'ok.png')}"/> <br> Congratulations! <br>
                <p>All your answers are correct! Now, you can jump to the complex questions by clicking "Jump to Complex Questions" button in the page. Or, you can continue with other questions.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>

    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="jumpToTraining" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Jump to Training Stage</h4>
            </div>
            <div class="modal-body" style="text-align: center">
                <img width="30px" height="30px" src="${assetPath(src: 'ok.png')}"/> <br> Congratulations! <br>
                <p>All your answers are correct! Now, you can jump to the training stage by clicking "Start Training" button in the page. Or, you can continue with other questions.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>

    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="noQuestionLeftType1" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">End of Simple Questions</h4>
            </div>
            <div class="modal-body" style="text-align: center">
                <img width="30px" height="30px" src="${assetPath(src: 'exclamation.ico')}"/> <br>
                <p>That was the end of the simple questions in this stage. There is no question left. Please start jump to the complex questions!</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>

    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="noQuestionLeftType2" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">End of Testing Questions</h4>
            </div>
            <div class="modal-body" style="text-align: center">
                <img width="30px" height="30px" src="${assetPath(src: 'exclamation.ico')}"/> <br>
                <p>That was the end of the testing stage. There is no question left. Please start training now!</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>

    </div>
</div>

<content tag="script">
    <script>
        var $target = $('#step2_icon');
        activateStep($target);
        $( document ).ready(function() {
            var page = ${page};
            var totalPage = ${totalPage};

            if("${type}" == "type1"){
                if('${worker.isPassedTesting1}' == 'true') {
                    if('${isAlreadyPassed}' == 'false')
                        $('#jumpToType2').modal('show');
                    $("#step2next").text("Jump to Complex Questions");
                    $("#step2next").click(function (e) {
                        window.location.href = "/testing?worker_id=${worker.workerId}&page=1&type=type2";
                    });
                    $("#step2nextM").click(function (e) {
                        if (totalPage > page) {
                            window.location.href = "/testing?worker_id=${worker.workerId}&page=" + (page + 1)+"&type=${type}";
                        }
                        else{
                            $('#noQuestionLeftType1').modal('show');
                        }
                    });
                }
                else {
                    $("#step2next").hide();
                    $("#step2nextM").click(function (e) {
                        if (totalPage > page) {
                            window.location.href = "/testing?worker_id=${worker.workerId}&page=" + (page + 1) + "&type=${type}";
                        }
                        else {
                            window.location.href = "/complete/fail?worker_id=${worker.workerId}";
                        }
                    });
                }
            }
            else{
                if('${worker.isPassedTesting2}' == 'true') {
                    if ('${isAlreadyPassed}' == 'false')
                        $('#jumpToTraining').modal('show');
                    $("#step2next").text("Start Training");
                    $("#step2next").click(function (e) {
                        window.location.href = "/introduction/tutorial?worker_id=${worker.workerId}";
                    });
                    $("#step2nextM").click(function (e) {
                        if (totalPage > page) {
                            window.location.href = "/testing?worker_id=${worker.workerId}&page=" + (page + 1)+"&type=${type}";
                        }
                        else{
                            $('#noQuestionLeftType2').modal('show');
                        }
                    });
                }
                else {
                    $("#step2next").hide();
                    $("#step2nextM").click(function (e) {
                        if (totalPage > page) {
                            window.location.href = "/testing?worker_id=${worker.workerId}&page=" + (page + 1) + "&type=${type}";
                        }
                        else {
                            window.location.href = "/complete/fail?worker_id=${worker.workerId}";
                        }
                    });
                }
            }

            $(".prev-step").click(function (e) {
                $("#footer").hide();
                window.location.href = "/testing?worker_id=${worker.workerId}&page=" + (page)+"&type=${type}";

            });


        });

    </script>
</content>

</body>
</html>