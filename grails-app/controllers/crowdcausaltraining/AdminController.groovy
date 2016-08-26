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
        def isThereError = false
        def tQ = new TestingQ()
        tQ.questionText = params.questionText
        params.answerText.eachWithIndex  { a, index ->
            def tA = new TestingA()
            tA.answerText = a
            if (params.correctAnswer.toInteger() == index) {
                tQ.correctAnswer = tA
            }
            if(tQ.addToAnswers(tA).save()) {
                isThereError = false
            }
            else
                isThereError = true
        }

        if(!isThereError) {
            redirect(action: "testing")
        }
        else
            render(view:"newTestingQuestion", model:[newTestingQ:tQ])
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

    def deleteTestingQuestion(){
        def testingQ = TestingQ.get(params.question_id)
        testingQ.delete()
    }

    def training() { }
}
