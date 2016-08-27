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
            Answers:<br>
            <div id="answersContainer">
                <g:each var="answer" in="${question.answers}">
                    <div>
                        <g:if test="${question.correctAnswer != null && answer.id == question.correctAnswer.id}">
                            <input type="radio" name="correctAnswer" checked="checked" value="${answer.id}"/>
                        </g:if>
                        <g:else>
                            <input type="radio" name="correctAnswer" value="${answer.id}"/>
                        </g:else>
                        <g:textField name="answerText" value="${answer.answerText}" style="width:400px"/>
                        <button type="button" onclick="removeAnswer(this)">
                            <span><i class="glyphicon glyphicon-minus"></i> </span></button>
                    </div>
                    <br>
                </g:each>
            </div>
            <g:submitButton name="Submit" onclick="return setCorrectAnswerIndex();"/>
        </g:form><br>



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
                $('#answersContainer').append( data);
            });
        }

        function removeAnswer(elem){
            $(elem).parent().remove();
        }

        function setCorrectAnswerIndex(){
            if($("input[type=radio]:checked").length == 0) {
                alert('Please select a correct answer for this question!');
                return false;
            }
            else {
                $("input[type=radio]").each(function (index) {
                    if ($(this).prop('checked'))
                        $(this).val(index);
                });
                return confirm('Are you sure you want to submit the question?');
            }
        }

    </script>
</content>

</body>
</html>