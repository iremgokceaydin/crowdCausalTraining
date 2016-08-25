<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
</head>
<body>

<div id="admin_testing" class="jumbotron" style="padding-bottom:10px;margin-bottom:10px">
    <h1>Crowd Causal Project</h1>
    <h2>Admin Panel - Testing</h2>
    <div class="row">
        <g:if test="${testingQuestions.empty}">
            <p>There are no questions yet!</p>
        </g:if>
        <g:else>
            <g:each var="testingQuestion" in="${testingQuestions}" status="i">
                <div class="col-md-6">
                    <p class="question">Q${i}: ${testingQuestion.questionText}?</p>
                    <p>
                        <g:each var="answer" in="${testingQuestion.answers}" status="j">
                            <label class="checkbox-inline"><input name="q${i}a" id="q${i}a${j}" type="radio" value="j">&nbsp;</label><br>
                        </g:each>
                    </p>
                </div>
            </g:each>
        </g:else>

    </div>
</div>
<g:link action="newTestingQuestion"><button type="button">Add another question</button></g:link>

<content tag="script">
    <script>
        $(document).ready(function () {
            $("#footer").hide();
        });

    </script>
</content>

</body>
</html>