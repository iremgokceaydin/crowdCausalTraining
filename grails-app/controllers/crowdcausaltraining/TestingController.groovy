package crowdcausaltraining


class TestingController {

    def index() {
        def worker = Owner.findOrCreateByTypeAndWorkerId("Worker",params.worker_id)
        def page = params.page.toInteger()
        def type = params.type //type1 or type2
        def pageFactor = Settings.first().pageFactorTesting
        def qs = []
        if(type == "type1") {
            session["lastTestingType1PageVisited"] = page
            qs = TestingQ.findAll("from TestingQ as a where a.type=:type", [type: QType.findByTypeAndShortName('Testing', 'Type1')], [max: pageFactor, offset: pageFactor * (page - 1)])
        }
        else {
            session["lastTestingType2PageVisited"] = page
            qs = TestingQ.findAll("from TestingQ as a where a.type=:type", [type: QType.findByTypeAndShortName('Testing', 'Type2')], [max: pageFactor, offset: pageFactor * (page - 1)])
        }
        [qs:qs, page:page, worker : worker, pageFactor: pageFactor, type:type]
    }

    def save(){
        print params
        def admin = Owner.findByType("Admin")
        def worker = Owner.findOrCreateByTypeAndWorkerId("Worker",params.worker_id)
        def page = params.page.toInteger()
        def pageFactor = Settings.first().pageFactorTesting
        def type = params.type //type1 or type2
        def qs = []
        if(type == "type1")
            qs = TestingQ.findAll("from TestingQ as a where a.type=:type",[type: QType.findByTypeAndShortName('Testing', 'Type1')], [max: pageFactor, offset: pageFactor * (page-1)])
        else
            qs = TestingQ.findAll("from TestingQ as a where a.type=:type",[type: QType.findByTypeAndShortName('Testing', 'Type2')], [max: pageFactor, offset: pageFactor * (page-1)])
        def isAlreadyPassed = false

        def numberOfCorrect = 0
        params.list('question').each  { q ->
            def workersAnswer = TestingA.get(params.get("answer_" + q))
            if(admin.testingAs.find {it.id == workersAnswer.id} != null){
                numberOfCorrect++
            }
            def workersPrevAnswer = worker.testingAs?.find {it.question.id == q.toInteger()}
            if(workersPrevAnswer != null) {
                worker.removeFromTestingAs(workersPrevAnswer)
            }
            worker.addToTestingAs(workersAnswer)
        }

        if((type == 'type1' && worker.isPassedTesting1) || (type == 'type2' && worker.isPassedTesting2))
            isAlreadyPassed = true

        if(numberOfCorrect >= Settings.first().numberOfCorrectTestingToFinish){
            if(type == 'type2')
                worker.isPassedTesting2 = true
            else
                worker.isPassedTesting1 = true
        }

        else if(worker.isPassedTesting1 == null)
            worker.isPassedTesting1 = false
        else if(worker.isPassedTesting2 == null)
            worker.isPassedTesting2 = false



        if(worker.save()) {
            redirect(action: "answer", params: [page:  page, worker_id: worker.workerId, type: type,isAlreadyPassed:isAlreadyPassed])

        }
        else {
            render(view: "index", model: [qs:qs, page:page, worker : worker, pageFactor: pageFactor, type: type])
        }
    }

    def answer(){
        def admin = Owner.findByType("Admin")
        def worker = Owner.findByWorkerId(params.worker_id)
        def type = params.type //type1 or type2
        def page = params.page.toInteger()
        def pageFactor = Settings.first().pageFactorTesting
        def totalPage = 0
        def qs = []
        if(type == 'type1') {
            totalPage = Math.ceil(TestingQ.findAll { type: QType.findByTypeAndShortName('Testing', 'Type1')}.size() / pageFactor).toInteger();
            qs = TestingQ.findAll("from TestingQ as a where a.type=:type",[type: QType.findByTypeAndShortName('Testing', 'Type1')], [max: pageFactor, offset: pageFactor * (page-1)])
        }
        else if(type == 'type2') {
            totalPage = Math.ceil(TestingQ.findAll {type: QType.findByTypeAndShortName('Testing', 'Type2')}.size() / pageFactor).toInteger();
            qs = TestingQ.findAll("from TestingQ as a where a.type=:type",[type: QType.findByTypeAndShortName('Testing', 'Type2')], [max: pageFactor, offset: pageFactor * (page-1)])
        }

        [qs:qs, page:page,totalPage:totalPage, pageFactor: pageFactor, admin : admin, worker : worker, type: type, isAlreadyPassed:params.isAlreadyPassed]
    }
}
