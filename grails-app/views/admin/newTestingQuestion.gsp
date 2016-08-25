<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
</head>
<body>

<div id="admin_testing" class="jumbotron" style="padding-bottom:10px;margin-bottom:10px">
    <h1>Crowd Causal Project</h1>
    <h2>Admin Panel - New Testing Question</h2>
    <div class="row" style="text-align: center;">
        <g:hasErrors bean="${newTestingQ}">
            <ul>
                <g:eachError var="err" bean="${newTestingQ}">
                    <li>${err}</li>
                </g:eachError>
            </ul>
        </g:hasErrors>

        <g:form action="createTestingQuestion">
            Question:<br>
            <g:textArea name="questionText" value="${newTestingQ.questionText}" rows="5" cols="60"/><br/><br>
            <button type="button" onclick="addAnswer()">Add Answer</button><br><br>
            <g:submitButton name="Submit"/>
        </g:form>

        <g:each var="answer" in="${newTestingQ.answers}">
            <label class="checkbox-inline"><input name="q${newTestingQ.id}a" id="q${newTestingQ.id}a${answer.id}" type="radio" value="${answer.id}">&nbsp;</label><br>
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