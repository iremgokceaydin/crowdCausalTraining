<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <style>
        .centered{text-align: center;}
        .step{text-decoration:underline;font-weight:bold;font-size: 22px;}
    </style>
</head>
<body>

    <h1>Causal Crowd Coding</h1>
    <h2>Introduction</h2>
    <p>All of our conversations every day exhibit multiple elements of communication. One of these is the ability to attribute cause to events or situations we're in. The human ability to comprehend causal structure or knowledge is almost inherent - even young children can identify that the boy cried wolf too many times, causing the villagers to not believe him when he was actually faced with the wolf.</p>

    <p>The basis of this project is to recruit regular people to help code causal knowledge in web forum posts in order to develop a stronger methodlogy for analyzing the development and evolution of knowledge, and thus gainging a better understanding of how people process and present information.</p>

    <p>However, in order to develop an easy-to-apply methodology, we need help from people from outside our circle to help us refine it.</p>

    <p>That's where you come in.</p>
<hr>

<p style="text-align: center; color: #3c90c1">This methodology is a multi-stage process whereby the first step is to identify the causal sentences and then write them in the way as you would write “x causes y".</p>
<p style="text-align: center;">Before you begin coding, however, there are steps involved to draw out the statements and to help the work go more smoothly and efficiently:</p>

<p class="centered">
    <span class="step">STEP ONE: </span><br>
    <span>Identify cause and effect relationships in the text.</span>
</p>
<p class="centered">
    <span class="step">STEP TWO: </span><br>
    <span>Rewrite them so that cause and effect are clear.</span>
</p>
<p class="centered">
    <span class="step">STEP THREE: </span><br>
    <span>Relabel these as properties, quantities, or events.**These can be either degree or existence.</span>
</p>
<p class="centered">
    <span class="step">STEP FOUR: </span><br>
    <span>Code the causal connector using the provided codes.</span>
</p>
<p class="centered">
    <span class="step">STEP FIVE: </span><br>
    <span>Identify commonalities between multiple causal sequences and combine them into a graph (or spreadsheet).</span>
</p>


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
