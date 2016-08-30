<%@ page import="crowdcausaltraining.QType" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="admin"/>
</head>
<body>

    <h2>Edit Testing Question</h2>
    <div class="row" style="text-align: center;">
        %{--<g:hasErrors bean="${q}">--}%
            %{--<ul>--}%
                %{--<g:eachError var="err" bean="${q}">--}%
                    %{--<li>${err}</li>--}%
                    %{--<g:each in="${err.codes}" var="code">--}%
                        %{--<li>${code}</li>--}%
                    %{--</g:each>--}%
                %{--</g:eachError>--}%
            %{--</ul>--}%
        %{--</g:hasErrors>--}%
        <g:hasErrors bean="${q}">
            <ul class="fieldError">
                <g:eachError var="err" bean="${q}">
                    <li><g:message error="${err}"/></li>
                </g:eachError>
            </ul>
        </g:hasErrors>

        <g:form mapping="updateTesting" params='[id:"${q.id}"]'>
            <g:select name='type' value="${q?.type?.id}"
                      from='${crowdcausaltraining.QType.findByType("Testing")}'
                      optionKey="id" optionValue="shortName"></g:select><br>

            Question:<br>
            <g:textArea name="questionText" value="${q.questionText}" rows="5" cols="60"/><br/>
            <button type="button" onclick="addAnswer()">Add Answer</button><br><br>
            Answers:<br>
            <div id="answersContainer">
                <g:each var="answer" in="${q.answers}">
                    <div>
                        <g:if test="${q.correctAnswer != null && answer.id == q.correctAnswer.id}">
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

<content tag="script">
    <script>

        function addAnswer(){
            $.ajax({
                url: "/admin/newTestingA"
            }).done(function(data) {
                $('#answersContainer').append( data);
            });
        }

        function removeAnswer(elem){
            $(elem).parent().remove();
        }

        function setCorrectAnswerIndex(){
            if($("input[type=radio]").length > 0 && $("input[type=radio]:checked").length == 0) {
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