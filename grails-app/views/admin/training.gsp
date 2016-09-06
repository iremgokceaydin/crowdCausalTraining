<%@ page import="crowdcausaltraining.Owner; crowdcausaltraining.QType" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="admin"/>
</head>
<body>



<div class="row">
    <h2>Training Questions</h2>
    <g:if test="${qs.empty}">
        <p>There are no questions yet!</p>
    </g:if>
    <g:else>
        <table border="3px">
            <tr style="font-weight:bold">
                <td>Type</td>
                <td>Posts</td>
                <td>Chunks</td>
                <td>Actions</td>
            </tr>
            <g:each var="q" in="${qs}">
                <tr>
                    <td style="width: 5%">${q.type.shortName}</td>
                    <td style="width: 60%">
                        <g:each var="post" in="${q.posts}">
                            <li id="post-${post.id}">${post.postText}</li>
                        </g:each>

                    </td>
                    <td>
                        <table border="1px" style="width: 100%;">
                        <g:each var="chunk" in="${crowdcausaltraining.Owner.findByType("Admin").trainingAs?.findAll {it.question.id == q.id}}">
                            <tr>
                                <td>
                                    <g:each var="h" in="${chunk.highlights}">
                                        <li>${h.text}</li>
                                        <g:javascript>
                                            $('#post-${h.referencedPostId}').highlight('${h.text}');
                                        </g:javascript>
                                    </g:each><br>
                                    ${chunk.text}
                                </td>
                            </tr>
                        </g:each>
                        </table>
                    </td>
                    <td style="width: 5%;">
                        <g:link mapping="editTraining" params='[id:"${q.id}"]'><input type="button" value="Edit"/></g:link>
                        <g:if test="${q.type != crowdcausaltraining.QType.findByTypeAndShortName("Training", "Type3")}">
                            <g:link mapping="editTrainingChunks" params='[id:"${q.id}"]'><input type="button" value="Chunks"/></g:link>
                        </g:if>
                        <g:link action="deleteTrainingQ" params='[id:"${q.id}"]' onclick="return confirm('Are you sure you want to delete the question?')"><input type="button" value="Delete"/></g:link>
                    </td>
                </tr>
            </g:each>
        </table>
    </g:else>
    <br>
    <g:link mapping="newTraining"><button type="button">Add another question</button></g:link>
</div>

</body>
</html>