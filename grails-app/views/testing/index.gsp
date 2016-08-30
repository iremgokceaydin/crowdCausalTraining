<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
</head>
<body>

<h1>Simple Task</h1>
<g:each class="row">
    <g:if test="${qs.empty}">
        <p>There are no questions yet!</p>
    </g:if>
    <g:else>
        <g:form action="save">
            <g:hiddenField name="worker_id" value="${worker.workerId}"/>
            <g:each var="q" in="${qs}">
            <div class="col-md-6">
                <p class="question">${q.questionText}</p>
                <p>
                    <g:each var="a" in="${q.answers}">
                        <label class="checkbox-inline"><input name="answer_${q.id}" type="radio" value="${a.id}">&nbsp;${a.answerText}</label><br>
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
            $(".next-step").click(function (e) {
                $("#footer").hide();
                if(${totalPage} > ${page}){
                    window.location.href = "/testing?page=" + (${page}+1);
                }
                else {
                    window.location.href = "/training";
                }
            });

            $(".prev-step").click(function (e) {
                $("#footer").hide();
                if(${page} > 1){
                    window.location.href = "/testing?page=" + (${page}-1);
                }
                else {
                    window.location.href = "/introduction";
                }
            });
        });
    </script>
</content>

</body>
</html>