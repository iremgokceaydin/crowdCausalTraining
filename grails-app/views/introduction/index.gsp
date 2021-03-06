<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <style>
        .centered{text-align: center;}
        .step{text-decoration:underline;font-weight:bold;font-size: 22px;}

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
    <h2>Introduction</h2>
    <p>Thank you for choosing to participate in our training! </p>

    <p>The basis of this project is to recruit regular people to help code causal knowledge in web forum posts in order to develop a stronger methodology for analyzing the development and evolution of knowledge, and thus gaining a better understanding of how people process and present information.</p>

    <p>All of our conversations every day exhibit multiple elements of communication. One of these is the ability to attribute cause to events or situations we're in. The human ability to comprehend causal structure or knowledge is almost inherent - even young children can identify that the boy cried wolf too many times, causing the villagers to not believe him when he was actually faced with the wolf.</p>

    <p>However, in order to develop an easy-to-apply coding methodology, we need help from people from outside our circle to help us refine it.</p>
    <p>That's where you come in.</p>
    <p>Even if you do not pass the training, we will appreciate your time and effort for helping us to test whether or not this training is effective and if we will be able to use it in the future as a tool for future workers.</p>

<h2>Identifying Causal Knowledge Contained in Statements</h2>

    <p>Identifying causal knowledge contained in people’s statements: some ground rules before you begin...</p>
    <h3>1. Causal knowledge is general.</h3>
    <p>Causal knowledge is generalized knowledge about how things (actions or properties) affect one another. Generalized knowledge is knowledge that applies broadly, and is not about a specific event. A single post is likely to contain many distinct causal statements, and these may be more or less explicit.</p>
    <ul>
        The post “Using my inhaler before I exercise helps me breathe easier” contains two causal

        statements. The first connects the use of an inhaler before exercise (an action) to the ease of

        breathing (a property of breathing). <br><br>

        (To help visualize causal knowledge, causes are coded as yellow and effects as grey and are

        labeled with superscripts and causal connections are colored red):<br><br>

        <span class="cause">Using an inhaler before exercising</span><sup>C1</sup> <span class="connector">increases</span> <span class="effect">ease of breathing</span><sup>E1</sup>. <br><br>

        However, the post author also reveals another piece of causal information: <br><br>

        <span class="cause">Exercising</span><sup>C2</sup> <span class="connector">decreases</span> <span class="effect">ease of breathing</span><sup>E1</sup><br><br>

        Note that although the cause in this statement (C2) is different than in the first statement, the

        property that is affected (E1) is the same.
    </ul>
    <hr>
    <h3>2. Causal statements have one or more causes and effects.</h3>
    <p>A single causal statement must contain at least one cause, and one effect, but there may be more than one of each.</p>
    <ul>
        The post “Running outside during pollen season is terrible! I start to wheeze and my chest feels

        really tight almost immediately,” contains one causal statement. However there are two causes

        and two effects. <br><br>

        <span class="cause">Running outside</span> <sup>C1</sup> and <span class="cause">during pollen season</span><sup>C2</sup> <span class="connector">increases</span> <span class="effect">wheezing</span><sup>E1</sup> and <span class="effect">chest tightness</span> <sup>E2</sup>. <br><br>

        Note that the “and” couples the causes (and effects) which are distinct but cannot be readily

        separated.
    </ul>

    <hr>
    <h3>3. Posts may have the order of cause and effect reversed</h3>
    <p>Sometimes a post expresses cause and effect in a reverse order, so pay careful attention to what you identify as a cause and what you determine to be an effect.</p>
    <ul>
        Sometimes posts will state the outcome of an action first, “I have really terrible acid reflux, it always

        seems to get worse when I eat dairy.” It may be tempting to write the effect (acid reflux) before the

        cause (eating dairy), but this won’t be correct! The correct interpretation is: <br><br>

        <span class="cause">Eating dairy</span><sup>C1</sup> <span class="connector">increases</span> <span class="effect"> Acid reflux</span><sup>E1</sup>.
    </ul>

    <hr>
    <h3>4. Questions can contain causal knowledge</h3>
    <p>Not all causal statements are direct. Sometimes a person might ask a question. Questions can be a way to express possible causal knowledge.</p>
    <ul>
        For example: “I get really terrible foot and leg cramps when I walk too quickly. I have exercise

        induced asthma. Could the cramps be a side effect?”<br><br>

        To help visualize causal knowledge, causes are coded as yellow and effects as gray:

        <span class="effect">I get really terrible cramps</span> when I <span class="cause">walk too quickly</span>. I have <span class="cause">exercise induced asthma</span>. Could the

        <span class="effect">cramps be a side effect</span>?” <br><br>

        What causal knowledge is being expressed here?<br>
        <ul>
            - Walking quickly causes cramps. Exercise induced asthma may cause cramps
        </ul>
    </ul>

    <hr>
    <h3>5. Sometimes there are multiple causes leading to a single effect</h3>
    <p>
        For example: My doctor tells me that asthma reduces oxygen levels, which might be the reason my

        feet and legs cramp when I exercise. <br><br>

        To help visualize causal knowledge, causes are coded as yellow and effects as gray:<br>

        “My doctor tells me that <span class="cause">asthma</span> <span class="effect">reduces oxygen levels</span>, which might be the reason my <span class="effect"> foot and

    legs cramp</span> when I <span class="cause">exercise</span>”.<br><br>

        In this post, reduced oxygen levels causes foot and leg cramps; asthma causes reduced oxygen

        levels.
    </p>

    <hr>
    <h3>6. Causal knowledge does not always appear in a single sentence!</h3>
    <p>Causal knowledge sometimes exhibits itself in more than once place throughout the post. Some people will write a lot in their post with a lot of context, so read carefully.</p>


    <hr>
    <h3>7. You may need to read a series of posts in order to understand the cause of a symptom and the effect of that symptom.</h3>
    <p>Meaning that you may have to read more than one post in the thread or forum to get the whole picture of what is going on.<br>
        For Example: Original Poster (OP), response, OP responds to responder, so on.</p><br>

<content tag="script">
    <script>
        var $target = $('#step1_icon');
        activateStep($target);

        $( document ).ready(function() {
            $(".next-step").click(function (e) {
                window.location.href = "/testing?worker_id=${worker.workerId}" + "&type=type1&page=1";
            });
        });

    </script>
</content>

</body>
</html>
