package crowdcausaltraining

class AdminController {

    def index() { }

    def testing() {
        def qs = TestingQ.list()
        [qs:qs]
    }

    def newTestingQ(){
        def q = new TestingQ()
        [q:q]
    }

    def createTestingQ(){
        print params
        def q = new TestingQ()
        q.questionText = params.questionText
        q.type = QType.get(params.type)
        params.list('answerText').eachWithIndex  { a, index ->
            def tA = new TestingA()
            tA.answerText = a
            if (params.containsKey("answer") && params.answer.toInteger() == index) {
                Owner.findByType("Admin").addToTestingAs(tA)
            }
            q.addToAnswers(tA)
        }

        if(q.save()) {
            Owner.findByType("Admin").save(flush:true)
            redirect(action: "testing")
        }
        else {
//            def locale = Locale.getDefault()
//            //println locale
//            tQ.errors?.allErrors?.each{
//                println  messageSource.getMessage(it, locale)
//            }
            render(view: "newTestingQ", model: [q: q])
        }
    }

    def newTestingA(){
        print params
        render(template:"newTestingA")
    }

    def editTestingQ(){
        def q = TestingQ.get(params.id)
        [q:q]
    }

    def updateTestingQ(){
        def q = TestingQ.get(params.id)
        q.answers.clear()


        if(params.type.toInteger() == QType.findByShortName('Type1').id)
            q.highlights.clear()

        if(q.questionText != params.questionText) {
            q.questionText = params.questionText
            q.highlights = []
        }
        q.type = QType.get(params.type)
        params.list('answerText').eachWithIndex  { a, index ->
            def tA = new TestingA()
            tA.answerText = a
            if (params.containsKey("answer") && params.answer.toInteger() == index) {
                Owner.findByType("Admin").addToTestingAs(tA)
            }
            q.addToAnswers(tA)
        }

        if(q.save()) { //validate: false, flush: true
            Owner.findByType("Admin").save(flush:true)
            redirect(action: "testing")
        }
        else {
//            def locale = Locale.getDefault()
//            //println locale
//            tQ.errors?.allErrors?.each{
//                println  messageSource.getMessage(it, locale)
//            }
            render(view: "editTestingQ", model: [q: q])
        }
    }

    def deleteTestingQ(){
        def q = TestingQ.get(params.id)
        Owner admin = Owner.findByType("Admin")
        q.answers.each { a->
            if(admin.testingAs.find{ it.id == a.id } != null)
                admin.removeFromTestingAs(a)
        }
        q.delete(flush:true)
        redirect(action:"testing")
    }

    def editHighlightsOfTestingQ(){
        def q = TestingQ.get(params.id)
        [q:q]
    }

    def updateHighlightsOfTestingQ(){
        print params
        def q = TestingQ.get(params.id)
        q.highlights = []
        params.list('highlight').each  {
            q.highlights.push(it)
        }
        if(q.save()) {
            redirect(action: "testing")
        }
        else {
            render(view: "editHighlightsOfTestingQ", model: [q: q])
        }
    }

    def training() { }
}
