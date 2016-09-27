<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <style> h3{color: #3c90c1;}</style>
</head>
<body>

<h1>Causal Crowd Coding</h1>
<h2>How To</h2>
<div style="width: 100%;float: left;margin-bottom:20px;">
    <p>Identifying causal knowledge contained in people’s statements: some ground rules before you begin...</p>
    <h3>1. Causal knowledge is general.</h3>
    <p>Causal knowledge is generalized knowledge about how things (actions or properties) affect one another.  Generalized knowledge is knowledge that applies broadly, and is not about a specific event.

    A single post is likely to contain many distinct causal statements, and these may be more or less explicit.</p>

    <hr>
    <h3>2. Causal statements have one or more causes and effects.</h3>
    <p>A single causal statement must contain at least one cause, and one effect, but there may be more than one of each.</p>

    <hr>
    <h3>3. Posts may have the order of cause and effect reversed</h3>
    <p>Sometimes a post expresses cause and effect in a reverse order, so pay careful attention to what you identify as a cause and what you determine to be an effect.</p>

    <hr>
    <h3>4. Questions can contain causal knowledge</h3>
    <p>Not all causal statements are direct. Sometimes a person might ask a question. Questions can be a way to express possible causal knowledge.</p>

    <hr>
    <h3>5. Sometimes there are multiple causes leading to a single effect</h3>
    <p>In our case, this effect would be a symptom, since we're coding an asthma forum.</p>

    <hr>
    <h3>6. Causal knowledge does not always appear in a single sentence!</h3>
    <p>Causal knowledge sometimes exhibits itself in more than once place throughout the post. Some people will write a lot in their post with a lot of context, so read carefully.</p>


    <hr>
    <h3>7. You may need to read a series of posts in order to understand the cause of a symptom and the effect of that symptom.</h3>
    <p>Meaning that you may have to read more than one post in the thread or forum to get the whole picture of what is going on.<br>
        For Example: Original Poster (OP), response, OP responds to responder, so on.</p><br>


    <h2>Usage Scenario</h2>
    <p>After you have read through posts and identified statements that express causal knowledge, you will need to identify variables that express a cause or effect.<br>

    </p><br>
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
                window.location.href = "/testing/answer?page=${worker.lastTestingPageVisitedByWorker}&worker_id=${worker.workerId}&isTestingSuccessful=true";
            });
        });

    </script>
</content>

</body>
</html>
