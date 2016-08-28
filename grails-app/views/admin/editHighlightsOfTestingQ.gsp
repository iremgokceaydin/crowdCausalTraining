<%@ page import="crowdcausaltraining.TestingType" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="admin"/>
</head>
<body>

<h2>Edit Highlights of Testing Question</h2>
<div class="row">
    <div class="col-md-6">
        <u>Question:</u>
        <p id="questionText"> ${q.questionText} </p>
    </div>

    <div class="col-md-6">
        <g:hasErrors bean="${q}">
            <ul>
                <g:eachError var="err" bean="${q}">
                    <li>${err}</li>
                </g:eachError>
            </ul>
        </g:hasErrors>

        <g:form action="updateHighlightsOfTestingQ">
            <g:hiddenField name="id" value="${q.id}"/>


            <g:submitButton name="Submit"/>
        </g:form>
    </div>

</div>

</body>
</html>