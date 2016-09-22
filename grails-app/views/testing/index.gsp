<%@ page import="crowdcausaltraining.QType" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
</head>
<body>

<h1>Testing Examples</h1>
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
        <p>Answer all the question correctly within a page to be able to jump to training section!</p>
        <g:form action="save" name="formToSubmit">

            <g:hiddenField name="worker_id" value="${worker.workerId}"/>
            <g:hiddenField name="page" value="${page}"/>
            <g:hiddenField name="isTestingSuccessful" value="${isTestingSuccessful}"/>

            <g:each var="q" in="${qs}" status="i">
                <g:hiddenField name="question" value="${q.id}"/>
                <div><hr>
                    <g:if test="${q.type.id == QType.findByTypeAndShortName('Testing', 'Type1').id}">
                        <p class="question">Q-${i+1+(page-1)*pageFactorTesting}: Which of the following statements reflect the knowledge in the passage?</p>
                    </g:if>
                    <g:else>
                        <p class="question">Q-${i+1+(page-1)*pageFactorTesting}: To which causal statement does the highlighted statement correspond?</p>
                    </g:else>
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
            $("#step2nextA").hide();
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
                    window.location.href = "/testing/answer?page=" + (page-1) + "&worker_id=${worker.workerId}&isTestingSuccessful=${isTestingSuccessful}";
                }
                else {
                    window.location.href = "/introduction?worker_id=${worker.workerId}";
                }
            });
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