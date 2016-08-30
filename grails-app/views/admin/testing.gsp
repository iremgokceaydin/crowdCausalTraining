<!doctype html>
<html>
<head>
    <meta name="layout" content="admin"/>
</head>
<body>



    <div class="row">
        <h2>Testing Questions</h2>
        <g:if test="${qs.empty}">
            <p>There are no questions yet!</p>
        </g:if>
        <g:else>
            <table border="3px">
                <tr style="font-weight:bold">
                    <td>Type</td>
                    <td>Question</td>
                    <td>Answers</td>
                    <td>Highlights</td>
                    <td>Actions</td>
                </tr>
                <g:each var="q" in="${qs}">
                    <tr>
                        <td>${q.type.shortName}</td>
                        <td style="width: 50%;" id="${q.type.shortName}">${q.questionText}</td>
                        <td>
                            <g:each var="answer" in="${q.answers}">
                                <g:if test="${q.correctAnswer != null && answer.id == q.correctAnswer.id}">
                                    <input type="radio" name="correctAnswer_${q.id}" checked="checked" value="${answer.id}" disabled="true"/>
                                </g:if>
                                <g:else>
                                    <input type="radio" name="correctAnswer_${q.id}" value="${answer.id}" disabled="true"/>
                                </g:else>

                                ${answer.answerText}<br>
                            </g:each>
                        </td>
                        <td>
                            <ul>
                            <g:each var="highlight" in="${q.highlights}">
                                <li>${highlight}</li>
                                <g:javascript>
                                    $('#Type2').highlight('${highlight}');
                                </g:javascript>
                            </g:each>
                            </ul>
                        </td>
                        <td style="width: 5%;">
                            <g:link mapping="editTesting" params='[id:"${q.id}"]'><input type="button" value="Edit"/></g:link>

                            <g:if test="${q.type.id == crowdcausaltraining.QType.findWhere(type: "Testing", shortName: "Type2").id}">
                                <g:link mapping="editTestingHighlights" params='[id:"${q.id}"]'><input type="button" value="Highlights"/></g:link>
                            </g:if>
                            <g:link action="deleteTestingQ" params='[id:"${q.id}"]' onclick="return confirm('Are you sure you want to delete the question?')"><input type="button" value="Delete"/></g:link>
                        </td>
                    </tr>
                </g:each>
            </table>
        </g:else>
        <br>
        <g:link mapping="newTesting"><button type="button">Add another question</button></g:link>
    </div>

</body>
</html>