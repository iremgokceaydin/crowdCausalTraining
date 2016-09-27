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
<body>

    <div class="container">
        <div class="jumbotron" style="padding-bottom:10px;margin-bottom:10px">
            <sec:ifLoggedIn>
                <sec:ifAllGranted roles='ROLE_ADMIN'>
                    <g:link controller="admin" action="index"><input type="button" value="Admin Page"/></g:link>
                </sec:ifAllGranted>
            </sec:ifLoggedIn>

            <g:layoutBody/>
        </div>

        <div id="footer" class="row" style="display:none;">
            <section style="margin-top:-20px">
                <div class="wizard">
                    <div class="wizard-inner">
                        <div class="connecting-line"></div>
                        <ul class="nav nav-tabs" role="tablist">

                            <li id='step1_icon' role="presentation" class="disabled">
                                <a href="#step1_progress" data-toggle="tab" aria-controls="step1_progress" role="tab" title="Introduction">
                                    <span class="round-tab">
                                        <i class="glyphicon glyphicon-book"></i>
                                    </span>
                                </a>
                            </li>

                            <li id='step2_icon' role="presentation" class="disabled">
                                <a href="#step2_progress" data-toggle="tab" aria-controls="step2_progress" role="tab" title="Testing">
                                    <span class="round-tab">
                                        <i class="glyphicon glyphicon-check"></i>
                                    </span>
                                </a>
                            </li>
                            <li id='step3_icon' role="presentation" class="disabled">
                                <a href="#step3_progress" data-toggle="tab" aria-controls="step3_progress" role="tab" title="Tutorial">
                                    <span class="round-tab">
                                        <i class="glyphicon glyphicon-list-alt"></i>
                                    </span>
                                </a>
                            </li>
                            <li id='step4_icon' role="presentation" class="disabled">
                                <a href="#step4_progress" data-toggle="tab" aria-controls="step4_progress" role="tab" title="Training">
                                    <span class="round-tab">
                                        <i class="glyphicon glyphicon-pencil"></i>
                                    </span>
                                </a>
                            </li>
                            <li id='step5_icon' role="presentation" class="disabled">
                                <a href="#step5_progress_complete" data-toggle="tab" aria-controls="step5_progress_complete" role="tab" title="Complete">
                                    <span class="round-tab">
                                        <i class="glyphicon glyphicon-ok"></i>
                                    </span>
                                </a>
                            </li>
                        </ul>
                    </div>


                    <div class="tab-content">
                        <div class="tab-pane" role="tabpanel" id="step1_progress">
                            <h3>Introduction</h3>
                            %{--<p>Introduction</p>--}%
                            <ul class="list-inline pull-right">
                                <li><button id="step1next" name="step1next" type="button" class="btn btn-primary next-step">Continue</button></li>
                            </ul>
                        </div>
                        <div class="tab-pane" role="tabpanel" id="step2_progress">
                            <h3>Testing</h3>
                            %{--<p>Testing</p>--}%
                            <ul class="list-inline pull-right">
                                <li><button id="step2prev" name="step2prev" type="button" class="btn btn-default prev-step">Previous</button></li>
                                <li><button id="step2nextA" name="step2next" type="button" class="btn btn-primary next-step">See More Questions</button></li>
                                <li><button id="step2next" name="step2next" type="button" class="btn btn-primary next-step">Save and continue</button></li>
                            </ul>
                        </div>
                        <div class="tab-pane" role="tabpanel" id="step3_progress">
                            <h3>Tutorial</h3>
                            %{--<p>Tutorial</p>--}%
                            <ul class="list-inline pull-right">
                                <li><button id="step3prev" name="step3prev" type="button" class="btn btn-default prev-step">Previous</button></li>
                                <li><button id="step3next" name="step3next" type="button" class="btn btn-primary next-step">Continue</button></li>
                            </ul>
                        </div>
                        <div class="tab-pane" role="tabpanel" id="step4_progress">
                            <h3>Training</h3>
                            %{--<p>Training</p>--}%
                            <ul class="list-inline pull-right">
                                <li><button id="step4prev" name="step4prev" type="button" class="btn btn-default prev-step">Previous</button></li>
                                <li><button id="step4next" name="step4next" type="button" class="btn btn-primary btn-info-full next-step">Save and Continue</button></li>
                            </ul>
                        </div>
                        <div class="tab-pane" role="tabpanel" id="step5_progress_complete">
                            <h3>Completed</h3>
                            %{--<p>Completed all steps.</p>--}%
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </section>
        </div>

    </div>



    <div id="spinner" class="spinner" style="display:none;">
        <g:message code="spinner.alt" default="Loading&hellip;"/>
    </div>

    <g:pageProperty name="page.script"/>

</body>
</html>
