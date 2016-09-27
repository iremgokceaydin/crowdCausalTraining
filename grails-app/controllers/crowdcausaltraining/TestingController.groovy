package crowdcausaltraining


class TestingController {

    def index() {
        def worker = Owner.findOrCreateByTypeAndWorkerId("Worker",params.worker_id)
        def page = params.page.toInteger()
        def pageFactor = Settings.first().pageFactorTesting
        def qs = TestingQ.findAll([max: pageFactor, offset: pageFactor * (page-1)])
        def firstType1 = null
        def firstType2 = null
        qs.each {q->
            if(firstType1 == null && q.type.id == QType.findByTypeAndShortName('Testing', 'Type1').id)
                firstType1 = q
            else if(firstType2 == null && q.type.id == QType.findByTypeAndShortName('Testing', 'Type2').id)
                firstType2 = q
        }
        def pageFactorTesting = Settings.first().pageFactorTesting
        def isTestingSuccessful = params.isTestingSuccessful
        [qs:qs, page:page, worker : worker, pageFactorTesting: pageFactorTesting, firstType1:firstType1, firstType2:firstType2,isTestingSuccessful:isTestingSuccessful]
    }

    def save(){
        print params
        def worker = Owner.findOrCreateByTypeAndWorkerId("Worker",params.worker_id)
        def page = params.page.toInteger()
        def pageFactor = Settings.first().pageFactorTesting
        def qs = TestingQ.findAll([max: pageFactor, offset: pageFactor * (page-1)])
        def pageFactorTesting = Settings.first().pageFactorTesting
        def isTestingSuccessful = params.isTestingSuccessful

        params.list('question').each  { q ->
            print q
            def workersPrevAnswer = worker.testingAs?.find {it.question.id == q.toInteger()}
            print workersPrevAnswer
            if(workersPrevAnswer != null) {
                worker.removeFromTestingAs(workersPrevAnswer)
            }
            worker.addToTestingAs(TestingA.get(params.get("answer_" + q)))
        }


        if(worker.save()) {
            redirect(action: "answer", params: [page:  page, worker_id: worker.workerId, pageFactorTesting: pageFactorTesting,isTestingSuccessful:isTestingSuccessful])

        }
        else {
            render(view: "index", model: [qs:qs, page:page, worker : worker, pageFactorTesting: pageFactorTesting,isTestingSuccessful:isTestingSuccessful])
        }
    }

    def answer(){
        def admin = Owner.findByType("Admin")
        def worker = Owner.findByWorkerId(params.worker_id)
        def pageFactor = Settings.first().pageFactorTesting
        def totalPage = Math.ceil(TestingQ.all.size() / pageFactor).toInteger();
        def page = params.page.toInteger()
        session["lastTestingPageVisited"] = page
        def qs = TestingQ.findAll([max: pageFactor, offset: pageFactor * (page-1)])
        def pageFactorTesting = Settings.first().pageFactorTesting
        def isTestingSuccessful = params.isTestingSuccessful
        [qs:qs, page:page,totalPage:totalPage, pageFactor: pageFactor, admin : admin, worker : worker, pageFactorTesting: pageFactorTesting,isTestingSuccessful:isTestingSuccessful]
    }


}
