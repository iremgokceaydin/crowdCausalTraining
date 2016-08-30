<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
</head>
<body>

<h1>Training Task</h1>
<div class="row">
    <g:if test="${qs.empty}">
        <p>There are no questions yet!</p>

    </g:if>
    <g:else>
        <g:form action="save" name="formToSubmit">
            <g:hiddenField name="worker_id" value="${worker.workerId}"/>
            <g:hiddenField name="page" value="${page}"/>
            %{--<g:each var="q" in="${qs}">--}%
                %{--<g:hiddenField name="question" value="${q.id}"/>--}%
                %{--<div class="col-md-6">--}%
                    %{--<p class="question" id="${q.type.shortName}">${q.questionText}</p>--}%
                    %{--<g:if test="${q.type.shortName} == 'Type2'">--}%
                        %{--<g:each var="highlight" in="${q.highlights}">--}%
                            %{--<g:javascript>--}%
                                %{--$('#Type2').highlight('${highlight}');--}%
                            %{--</g:javascript>--}%
                        %{--</g:each>--}%
                    %{--</g:if>--}%
                    %{--<p>--}%
                        %{--<g:each var="a" in="${q.answers}">--}%
                            %{--<label class="checkbox-inline"><input name="answer_${q.id}" type="radio" value="${a.id}">&nbsp;${a.answerText}</label><br>--}%
                        %{--</g:each>--}%
                    %{--</p>--}%
                %{--</div>--}%
            %{--</g:each>--}%
        </g:form>
    </g:else>
</div>


<content tag="script">
    <script>
        var $target = $('#step3_icon');
        activateStep($target);
        $( document ).ready(function() {

        });


    </script>
</content>

</body>
</html>