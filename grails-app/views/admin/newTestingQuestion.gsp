<%@ page import="crowdcausaltraining.TestingType" %>
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

        <g:eachError bean="${newTestingQ}" var="error">
            ${error.field}: <g:message error="${error}" />
            //For Debugging the ERR-CODES
            <ul>
                <g:each in="${error.codes}" var="code">
                    <li>${code}</li>
                </g:each>
            </ul>
        </g:eachError>


        <g:form action="createTestingQuestion">
            <div class="col-md-6">
                Question:<br>
                <g:textArea name="questionText" value="${newTestingQ.questionText}" rows="5" cols="60"/><br/><br>
                <button type="button" onclick="addAnswer()">Add Answer</button><br><br>
                Answers:<br>
                <div id="answersContainer">
                    <g:each var="answer" in="${newTestingQ.answers}">
                        <div>
                            <g:if test="${answer.id == newTestingQ.correctAnswer.id}">
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
            </div>
            <div class="col-md-6">
                <g:select name='type' value="${newTestingQ?.type?.id}"
                          from='${TestingType.list()}'
                          optionKey="id" optionValue="shortName"></g:select>
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