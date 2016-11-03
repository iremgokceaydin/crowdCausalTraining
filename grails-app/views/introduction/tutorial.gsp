<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <style>
        h3{
            color: #3c90c1;
        }
        span.cause{
            background-color: yellow;
        }
        span.effect{
            background-color: grey;
        }
        span.connector{
            background-color: red;
        }
    </style>

</head>
<body>

<h1>Causal Crowd Coding</h1>
    <h2>Identifying the Variables Within Causal Knowledge and Identifying the Causal Relationship with a Causal Connector</h2>
    <p>After you have read through posts and identified statements that express causal knowledge, you will need to identify variables that express a cause or effect.<br>
    <ul>
    “Using my inhaler before I exercise helps me breath easier.”<br>
        <li><i>Variables:</i> inhaler, asthma symptoms</li>
        <li><i>Causal connector:</i> reduce</li>
        <li><i>Cause and effect relationship:</i> Using an inhaler before exercising reduces asthma symptoms.</li>
    </ul>

    </p><br>
    %{--<img src="${assetPath(src: 'dottedArrow2.png')}" class="img-responsive" alt="System" width="40px" style="position: absolute; margin-top: 50px;">--}%
    %{--<img src="${assetPath(src: 'dottedArrow.png')}" class="img-responsive" alt="System" width="80px" style="float: right;">--}%
    %{--<img src="${assetPath(src: 'system.png')}" class="img-responsive" alt="System" style="margin-left: 15%;width: 30%;float: left;">--}%
    %{--<img src="${assetPath(src: 'system.png')}" class="img-responsive" alt="System" style="margin-left: 5%;width: 30%;float: left;margin-right: 2%;">--}%

%{--<div style="width: 100%;">--}%
    %{--<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum</p>--}%
%{--</div>--}%


<content tag="script">
    <script>
        var $target = $('#step3_icon');
        activateStep($target);

        $( document ).ready(function() {
            $(".next-step").click(function (e) {
                window.location.href = "/training?qType=Type1&page=1" + "&worker_id=${worker.workerId}";
            });
            $(".prev-step").click(function (e) {//TODO fix the static variable
                window.location.href = "/testing?worker_id=${worker.workerId}&page=${worker.lastTestingPageVisitedByWorker}&type=type2";
            });
        });

    </script>
</content>

</body>
</html>
