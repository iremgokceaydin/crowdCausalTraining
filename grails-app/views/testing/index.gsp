<%@ page import="crowdcausaltraining.QType" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
</head>
<body>

<h1>Testing Stage</h1>
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
        <g:if test="${type == 'type1'}">
            <h2>Simple Questions</h2>
            <p>To get you started, this set of posts will be used as the first training. You will be given a small chunk of text that you will then select the best possible answer that you think exhibits the causal knowledge being expressed in this text in the multiple choice options.</p>
            <p>Keep in mind that there is one correct answer.</p>
            <p style="color: #3c90c1">If you answer all the questions within one page correctly, you will be able to jump to the more complex questions in this phase.</p>
        </g:if>
        <g:elseif test="${type == 'type2'}">
            <h2>Complex Questions</h2>
            <p>Great job on passing the first test! This one is just like the first test, just the posts are a little bit longer and a tiny bit more complex.</p>
            <p>Again, select the best possible answer that you think exhibits the causal knowledge being expressed in that post in the multiple choice options and remember that there is only one correct answer.
            </p>
            <p style="color: #3c90c1">If you answer all the questions within one page correctly, you will be able to jump to the training phase.</p>
        </g:elseif>

        <g:form action="save" name="formToSubmit">

            <g:hiddenField name="worker_id" value="${worker.workerId}"/>
            <g:hiddenField name="page" value="${page}"/>
            <g:hiddenField name="type" value="${type}"/>

            <g:each var="q" in="${qs}" status="i">
                <g:hiddenField name="question" value="${q.id}"/>
                %{--<g:if test="${q.id == firstType1?.id}">--}%
                    %{--<br><br>--}%
                    %{--<p style="font-size: 22px; font-weight: bold;">For the posts below, which of the following statements reflects the causal knowledge that the speaker has?</p>--}%
                %{--</g:if>--}%
                %{--<g:elseif test="${q.id == firstType2?.id}">--}%
                    %{--<br><br>--}%
                    %{--<p style="font-size: 22px;font-weight: bold;">For the posts below, to which causal statement do the highlighted statements correspond?</p>--}%
                %{--</g:elseif>--}%
                <div><hr>
                    <p class="question">Q-${i+1+(page-1)*pageFactor}:
                    <p class="passage" id="${q.id}">${q.questionText}</p>
                    <g:if test="${q.type.id == QType.findByTypeAndShortName('Testing', 'Type2').id}">
                        <g:each var="highlight" in="${q.highlights}">
                            <g:javascript>
                                $('#${q.id}').highlight('${highlight}');
                            </g:javascript>
                        </g:each>
                    </g:if>
                    <p>
                        <g:each var="a" in="${q.answers}">
                            <g:if test="${worker.testingAs != null && worker.testingAs.find {it.id == a.id} != null}">
                                <label class="checkbox-inline"><input name="answer_${q.id}" type="radio" value="${a.id}" checked='checked'>&nbsp;${a.answerText}</label><br>
                            </g:if>
                            <g:else>
                                <label class="checkbox-inline"><input name="answer_${q.id}" type="radio" value="${a.id}">&nbsp;${a.answerText}</label><br>
                            </g:else>

                        </g:each>
                    </p>
                </div>
            </g:each>
        </g:form>
    </g:else>
</div>


<content tag="script">
    <script>
        var $target = $('#step2_icon');
        activateStep($target);
        $( document ).ready(function() {
            $("#step2nextM").hide();
            if('${qs.empty}' == 'true') {
                $("#step2next").hide();
            }
            else {
                $("#step2next").click(function (e) {
                    return validateTestingForm(e);
                });
            }

            $(".prev-step").click(function (e) {
                //$("#footer").hide();
                var page = ${page};
                if(page > 1){
                    window.location.href = "/testing/answer?worker_id=${worker.workerId}&page=" + (page - 1)+"&type=${type}";
                }
                else {
                    if('${type}' == 'type2')
                        window.location.href = "/testing/answer?worker_id=${worker.workerId}&page=${session["lastTestingType1PageVisited"]}&type=type1";
                    else
                        window.location.href = "/introduction?worker_id=${worker.workerId}";
                }
            });
            if('${type}' == 'type2'){
                if('${worker.isPassedTesting2}' == 'true'){
                    $("#step2nextM").text("Start Training");
                    $("#step2nextM").show();
                    $("#step2nextM").click(function (e) {
                        window.location.href = "/introduction/tutorial?worker_id=${worker.workerId}";
                    });
                }
            }

            else{
                if('${worker.isPassedTesting1}' == 'true'){
                    $("#step2nextM").text("Jump to Complex Questions");
                    $("#step2nextM").show();
                    $("#step2nextM").click(function (e) {
                        window.location.href = "/testing?worker_id=${worker.workerId}&page=1&type=type2";
                    });
                }
            }
        });

        function validateTestingForm(e) {
            if ($("input[name^='answer']:checked").length != $(".question").length) //pageFactor
            {
                alert("Please select an answer!");
                return false;
            }
            else{
                e.preventDefault();
                //$("#footer").hide();
                $("#formToSubmit").submit();
                return true;
            }
        }
    </script>
</content>

</body>
</html>