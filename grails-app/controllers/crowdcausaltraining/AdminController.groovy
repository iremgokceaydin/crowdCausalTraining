package crowdcausaltraining

class AdminController {

    def index() { }

    def testing() {
        def testingQuestions = TestingQ.list()
        [testingQuestions:testingQuestions]
    }

    def newTestingQuestion(){
        def newTestingQ = new TestingQ()
        [newTestingQ:newTestingQ]
    }

    def createTestingQuestion(){
        print params
        def tQ = new TestingQ()
        tQ.questionText = params.questionText
        tQ.type = TestingType.get(params.type)
        params.list('answerText').eachWithIndex  { a, index ->
            def tA = new TestingA()
            tA.answerText = a
            if (params.containsKey("correctAnswer") && params.correctAnswer.toInteger() == index) {
                tQ.correctAnswer = tA
            }
            tQ.addToAnswers(tA)
        }

        if(tQ.save()) {
            redirect(action: "testing")
        }
        else {
//            def locale = Locale.getDefault()
//            //println locale
//            tQ.errors?.allErrors?.each{
//                println  messageSource.getMessage(it, locale)
//            }
            render(view: "newTestingQuestion", model: [newTestingQ: tQ])
        }
    }

    def newTestingAnswer(){
        print params
//        [answerCounter = params.answerCounter]
//        def newAnswer = new TestingA()
        render(template:"newTestingAnswer")
    }

    def editTestingQuestion(){
        def testingQ = TestingQ.get(params.question_id)
        [question:testingQ]
    }

    def updateTestingQuestion(){
        print params

        def tQ = TestingQ.get(params.question_id)

        print (params.answerText instanceof Collection)
        print (params.answerText instanceof List)
        print (params.answerText.getClass().isArray())
        print params.list('answerText')

        print tQ.questionText
        print tQ.answers.size()

        tQ.answers.clear()


        tQ.questionText = params.questionText
        tQ.type = TestingType.get(params.type)
        params.list('answerText').eachWithIndex  { a, index ->
            def tA = new TestingA()
            tA.answerText = a
            if (params.containsKey("correctAnswer") && params.correctAnswer.toInteger() == index) {
                tQ.correctAnswer = tA
            }
            tQ.addToAnswers(tA)
        }

        if(tQ.save()) {
            redirect(action: "testing")
        }
        else {
//            def locale = Locale.getDefault()
//            //println locale
//            tQ.errors?.allErrors?.each{
//                println  messageSource.getMessage(it, locale)
//            }
            render(view: "newTestingQuestion", model: [newTestingQ: tQ])
        }
    }

    def deleteTestingQuestion(){
        def testingQ = TestingQ.get(params.question_id)
        testingQ.delete(flush:true)
        redirect(action:"testing")
    }

    def training() { }
}
