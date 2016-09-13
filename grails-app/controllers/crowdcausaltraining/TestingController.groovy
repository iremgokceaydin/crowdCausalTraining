package crowdcausaltraining


class TestingController {

    def index() {
        def worker = Owner.findOrCreateByTypeAndWorkerId("Worker",params.worker_id)
        def page = params.page.toInteger()
        def pageFactor = Settings.first().pageFactorTesting
        def qs = TestingQ.findAll([max: pageFactor, offset: pageFactor * (page-1)])
        [qs:qs, page:page, worker : worker]
    }

    def save(){
        print params
        def worker = Owner.findOrCreateByTypeAndWorkerId("Worker",params.worker_id)
        def page = params.page.toInteger()
        def pageFactor = Settings.first().pageFactorTesting
        def qs = TestingQ.findAll([max: pageFactor, offset: pageFactor * (page-1)])

        params.list('question').each  { q ->
            print q
            def workersPrevAnswer = worker.testingAs?.find {it.question.id == q.toInteger()}
            print workersPrevAnswer
            if(workersPrevAnswer != null) {
                print "here"
                worker.removeFromTestingAs(workersPrevAnswer)
            }
            worker.addToTestingAs(TestingA.get(params.get("answer_" + q)))
        }


        if(worker.save()) {
            redirect(action: "answer", params: [page:  page, worker_id: worker.workerId])

        }
        else {
            render(view: "index", model: [qs:qs, page:page, worker : worker])
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

        [qs:qs, page:page,totalPage:totalPage, pageFactor: pageFactor, admin : admin, worker : worker]
    }


}
