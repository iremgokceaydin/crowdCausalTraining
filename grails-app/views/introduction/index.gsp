<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
</head>
<body>

    <h1>Causal Crowd Coding - C^3</h1>
    <h2>Welcome!</h2>
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum</p>


<content tag="script">
    <script>
        var $target = $('#step1_icon');
        activateStep($target);

        $( document ).ready(function() {
            $(".next-step").click(function (e) {
                window.location.href = "/testing?worker_id=${worker.workerId}" + "&page=1";
            });
        });

    </script>
</content>

</body>
</html>
