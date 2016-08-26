<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
</head>
<body>

<div id="admin_testing" class="jumbotron" style="padding-bottom:10px;margin-bottom:10px">
    <h1>Crowd Causal Project</h1>
    <h2>Admin Panel - Edit Testing Question</h2>
    <div class="row" style="text-align: center;">
        <g:hasErrors bean="${question}">
            <ul>
                <g:eachError var="err" bean="${question}">
                    <li>${err}</li>
                </g:eachError>
            </ul>
        </g:hasErrors>

        <g:form action="updateTestingQuestion">
            <g:hiddenField name="question_id" value="${question.id}"/>
            Question:<br>
            <g:textArea name="questionText" value="${question.questionText}" rows="5" cols="60"/><br/>
            <button type="button" onclick="addAnswer()">Add Answer</button><br><br>
            <g:submitButton name="Submit"/>
        </g:form><br>

        Answers:<br>
        <g:each var="answer" in="${question.answers}">
            <label class="checkbox-inline"><input name="q${question.id}a" id="q${question.id}a${answer.id}" type="radio" value="${answer.id}">&nbsp;</label><br>
        </g:each>

    </div>
</div>

<content tag="script">
    <script>
        $(document).ready(function () {
            $("#footer").hide();
        });

        function addAnswer(){
            $.ajax({
                url: "/admin/newTestingAnswer"
            }).done(function(data) {
                $('form').append( data);
            });
        }

        function removeAnswer(elem){
            $(elem).parent().remove();
        }

    </script>
</content>

</body>
</html>