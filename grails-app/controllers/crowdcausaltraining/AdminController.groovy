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

    def newTestingAnswer(){
        def newAnswer = new TestingA()
        render(template:"newTestingAnswer", model:[newAnswer:newAnswer])
    }

    def createTestingAnswer(){

    }

    def createTestingQuestion(){
        print params
        def tQ = new TestingQ(params.questionText)
        if(tQ.save()) {

            redirect(action: "testing")
        }
        else
            render(view:"newTestingQuestion", model:[newTestingQ:tQ])
    }

    def training() { }
}
