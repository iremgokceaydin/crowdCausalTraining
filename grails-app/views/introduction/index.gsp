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
    <p>Thank you for choosing to participate in our training! </p>

    <p>The basis of this project is to recruit regular people to help code causal knowledge in web forum posts in order to develop a stronger methodology for analyzing the development and evolution of knowledge, and thus gaining a better understanding of how people process and present information.</p>

    <p>All of our conversations every day exhibit multiple elements of communication. One of these is the ability to attribute cause to events or situations we're in. The human ability to comprehend causal structure or knowledge is almost inherent - even young children can identify that the boy cried wolf too many times, causing the villagers to not believe him when he was actually faced with the wolf.</p>

    <p>However, in order to develop an easy-to-apply coding methodology, we need help from people from outside our circle to help us refine it.</p>
    <p>That's where you come in.</p>
    <p>Even if you do not pass the training, we will appreciate your time and effort for helping us to test whether or not this training is effective and if we will be able to use it in the future as a tool for future workers.</p>


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
