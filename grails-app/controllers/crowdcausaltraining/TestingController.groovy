package crowdcausaltraining

class TestingController {
    def testingPageFactor = 2

    def index() {
        def worker = Worker.findOrCreateByWorkerId(params.worker_id)
        def page = params.page.toInteger()
        def qs = TestingQ.findAll([max: testingPageFactor, offset: testingPageFactor * (page-1)])
        [qs:qs, page:page, pageFactor: testingPageFactor, worker : worker]
    }

    def save(){
        print params
        def worker = Worker.findOrCreateByWorkerId(params.worker_id)
        def totalPage = Math.ceil(TestingQ.all.size() / testingPageFactor).toInteger();
        def page = params.page.toInteger()
        def qs = TestingQ.findAll([max: testingPageFactor, offset: testingPageFactor * (page-1)])

        params.list('question').each  { q ->
            worker.addToTestingQs(TestingQ.get(q))
            worker.addToTestingAs(TestingA.get(params.get("answer_" + q)))
        }


        if(worker.save(flush: true)) { //validate: false, flush: true
            if (totalPage > page)
            {
                redirect(action: "index", params: [page:  page+1, worker_id: worker.workerId])
            }
            else
            {
                redirect(controller: "training", action: "index", params: [page:  1, worker_id: worker.workerId])
            }
        }
        else {
            render(view: "index", model: [qs:qs, page:page, worker : worker])
        }
    }


}
