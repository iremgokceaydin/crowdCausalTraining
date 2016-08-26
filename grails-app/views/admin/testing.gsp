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
            <table border="3px">
                <tr style="font-weight:bold">
                    <td>Question</td>
                    <td>Answers</td>
                    <td>Actions</td>
                </tr>
                <g:each var="testingQuestion" in="${testingQuestions}">
                    <tr>
                        <td>${testingQuestion.questionText}</td>
                        <td style="column-width: 300px">
                            <g:each var="answer" in="${testingQuestion.answers}">
                                <g:if test="${testingQuestion.correctAnswer != null && answer.id == testingQuestion.correctAnswer.id}">
                                    <input type="radio" name="correctAnswer" checked="checked" value="${answer.id}" disabled="true"/>
                                </g:if>
                                <g:else>
                                    <input type="radio" name="correctAnswer" value="${answer.id}" disabled="true"/>
                                </g:else>

                                ${answer.answerText}<br>
                            </g:each>
                        </td>
                        <td><g:form >
                            <g:hiddenField name="question_id" value="${testingQuestion.id}" />
                            <g:actionSubmit value="Edit" action="editTestingQuestion"/>
                            <g:actionSubmit value="Delete" action="deleteTestingQuestion" onclick="return confirm('Are you sure you want to delete the question?')"/>
                        </g:form></td>
                    </tr>
                </g:each>
            </table>
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