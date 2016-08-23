<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
</head>
<body>

<div id="step2_testing" class="jumbotron" style="padding-bottom:10px;padding-top:10px;margin-bottom:10px">
    <h1>Simple Task</h1>
    <div class="row">
        <div class="col-md-6">
            <p class="question">Q1: Which of the following statements reflect the knowledge in the passage?</p>
            <p class="passage" id='passage1'></p>
            <p>
                <label class="checkbox-inline"><input name="q1a" id="q1a1" type="radio" value="0">&nbsp;</label><br>
                <label class="checkbox-inline"><input name="q1a" id="q1a2" type="radio" value="1">&nbsp;</label><br>
                <label class="checkbox-inline"><input name="q1a" id="q1a3" type="radio" value="2">&nbsp;</label><br>
            </p>
        </div>
        <div class="col-md-6">
            <p class="question">Q2: To which causal statement does the highlighted statement correspond?</p>
            <p class="passage" id='passage2'></p>
            <p>
                <label class="checkbox-inline"><input name="q2a" id="q2a1" type="radio" value="0">&nbsp;</label><br>
                <label class="checkbox-inline"><input name="q2a" id="q2a2" type="radio" value="1">&nbsp;</label><br>
                <label class="checkbox-inline"><input name="q2a" id="q2a3" type="radio" value="2">&nbsp;</label><br>
            </p>
        </div>
    </div>
</div>

<content tag="script">
    <script>
        var $target = $('#step2_icon');
        activateStep($target);
    </script>
</content>

</body>
</html>