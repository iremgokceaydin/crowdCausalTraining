<%@ page import="crowdcausaltraining.QType" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="admin"/>
</head>
<body>

    <h2>New Testing Question</h2>
    <div class="row" style="text-align: center;">
        %{--<g:eachError bean="${q}" var="error">--}%
            %{--${error.field}: <g:message error="${error}" />--}%
            %{--<ul>--}%
                %{--<g:each in="${error.codes}" var="code">--}%
                    %{--<li>${code}</li>--}%
                %{--</g:each>--}%
            %{--</ul>--}%
        %{--</g:eachError>--}%
        <g:if test="${errors != null && !errors.empty}">
            <ul class="fieldError">
                <g:each var="err" in="${errors}">
                    <li><g:message error="${err}"/></li>
                </g:each>
            </ul>
        </g:if>


        <g:form action="createTestingQ">
            <g:select name='type' value="${q?.type?.id}"
                      from='${QType.findAllByType("Testing")}'
                      optionKey="id" optionValue="shortAndLongName"></g:select><br><br>

            Question:<br>
            <g:textArea name="questionText" value="${q.questionText}" rows="5" cols="60"/><br><br>
            <button type="button" onclick="addAnswer()">Add Answer</button><br><br>
            Answers:<br>
            <div id="answersContainer">
                <g:each var="answer" in="${q.answers}">
                    <div>
                        <g:if test="${crowdcausaltraining.Owner.findByType("Admin").testingAs.find {it.id == answer.id} != null}">
                            <input type="radio" name="answer" checked="checked" value="${answer.id}"/>
                        </g:if>
                        <g:else>
                            <input type="radio" name="answer" value="${answer.id}"/>
                        </g:else>
                        <g:textField name="answerText" value="${answer.answerText}" style="width:400px"/>
                        <button type="button" onclick="removeAnswer(this)">
                            <span><i class="glyphicon glyphicon-minus"></i> </span></button>
                    </div>
                    <br>
                </g:each>
            </div>
            <g:submitButton name="Submit" onclick="return setAnswerIndex();"/>
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

        function setAnswerIndex(){
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