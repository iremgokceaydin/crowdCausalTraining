<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
</head>
<body>

<h1>Causal Crowd Coding - C^3</h1>
<h2>Usage Scenario</h2>
<div style="width: 100%;float: left;margin-bottom:20px;">
    <img src="${assetPath(src: 'dottedArrow2.png')}" class="img-responsive" alt="System" width="40px" style="position: absolute; margin-top: 50px;">
    <img src="${assetPath(src: 'dottedArrow.png')}" class="img-responsive" alt="System" width="80px" style="float: right;">
    <img src="${assetPath(src: 'system.png')}" class="img-responsive" alt="System" style="margin-left: 15%;width: 30%;float: left;">
    <img src="${assetPath(src: 'system.png')}" class="img-responsive" alt="System" style="margin-left: 5%;width: 30%;float: left;margin-right: 2%;">
</div>
<div style="width: 100%;">
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum</p>
</div>


<content tag="script">
    <script>
        var $target = $('#step3_icon');
        activateStep($target);

        $( document ).ready(function() {
            $(".next-step").click(function (e) {
                window.location.href = "/training?qType=Type1&page=1" + "&worker_id=${worker.workerId}";
            });
            $(".prev-step").click(function (e) {//TODO fix the static variable
                window.location.href = "/testing/answer?page=${Math.ceil(crowdcausaltraining.TestingQ.all.size()/2).toInteger()}&worker_id=${worker.workerId}"; //TODO change it to dynamic pageFactor
            });
        });

    </script>
</content>

</body>
</html>
