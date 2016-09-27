<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
        <g:layoutTitle default="Crowd Causal"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico" />
    <asset:stylesheet src="application.css"/>
    <asset:javascript src="application.js"/>

    <g:layoutHead/>
</head>
<body style="font-family: 'Oswald'">

<div class="container">
    <div class="jumbotron" style="padding-bottom:10px;margin-bottom:10px">
        <g:link mapping="introduction" params='[worker_id:"1"]'><input type="button" value="Worker Pages"/></g:link>
        <g:link controller="admin" action="index"><input type="button" value="Admin Page"/></g:link>
        <h1>Causal Crowd Coding - Admin Panel</h1>
        <g:layoutBody/>
    </div>


</div>



<div id="spinner" class="spinner" style="display:none;">
    <g:message code="spinner.alt" default="Loading&hellip;"/>
</div>

<g:pageProperty name="page.script"/>

</body>
</html>
