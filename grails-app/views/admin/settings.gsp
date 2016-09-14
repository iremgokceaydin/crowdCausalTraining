<!doctype html>
<html>
<head>
    <meta name="layout" content="admin"/>
</head>
<body>



<div class="row">
    <h2>Settings</h2>
    <g:hasErrors bean="${settings}">
        <ul class="fieldError">
            <g:eachError var="err" bean="${settings}">
                <li><g:message error="${err}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <br>
    <g:form action="updateSettings">
        <table border="3px">
            <tr style="font-weight:bold">
                <td>Testing Page Factor</td>
                <td>Training Page Factor</td>
                <td>Correct Number of Answer for Testing </td>
                <td>Show Previous Training Posts Factor</td>
            </tr>
            <tr>
                <td><input name="pageFactorTesting" value="${settings.pageFactorTesting}"></td>
                <td><input name="pageFactorTraining" value="${settings.pageFactorTraining}"></td>
                <td><input name="numberOfCorrectTestingToFinish" value="${settings.numberOfCorrectTestingToFinish}"></td>
                <td><input name="showPreviousTrainingPostsFactor" value="${settings.showPreviousTrainingPostsFactor}"></td>

            </tr>
        </table><br>
        <g:submitButton name="Update"/>
    </g:form>
    <br>
</div>

</body>
</html>