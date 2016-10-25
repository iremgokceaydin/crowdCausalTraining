<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
</head>
<body>

<h1>Causal Crowd Coding - Failure</h1>
<h2 style="color:red">Dismissed!</h2>
<p>Sorry, this was the end of the questions! Unfortunately, you could not answer all of the questions in one of the testing pages correctly which is required to continue with the actual training stage. However, you can try again with another task in the future.</p>
<p>Thanks for your time!</p>


<content tag="script">
    <script>
        var $target = $('#step5_icon');
        activateStep($target);

        $( document ).ready(function() {
            $("#step5_progress_complete p").text("Failed!");
            $(".next-step").hide()
        });

    </script>
</content>

</body>
</html>
