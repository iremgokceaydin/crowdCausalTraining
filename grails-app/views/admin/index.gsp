<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
</head>
<body>

<div id="step1_intro1" class="jumbotron" style="padding-bottom:10px;margin-bottom:10px">
    <h1>Crowd Causal Project</h1>
    <h2>Admin Panel</h2>
    <div style="text-align: center;">
        <g:link controller="admin" action="testing"><button type="button">Testing Questions</button></g:link>
        <g:link controller="admin" action="training"><button type="button">Training Questions</button></g:link>
    </div>

</div>

<content tag="script">
    <script>
        $(document).ready(function () {
            $("#footer").hide();
        });

    </script>
</content>

</body>
</html>
