package crowdcausaltraining

import org.aspectj.weaver.patterns.TypePatternQuestions

class TestingController {
    def testingPageFactor = 2

    def index() {
        def worker = Owner.findOrCreateByTypeAndWorkerId("Worker",params.worker_id)
        def page = params.page.toInteger()
        def qs = TestingQ.findAll([max: testingPageFactor, offset: testingPageFactor * (page-1)])
        [qs:qs, page:page, worker : worker]
    }

    def save(){
        print params
        def worker = Owner.findOrCreateByTypeAndWorkerId("Worker",params.worker_id)
        def page = params.page.toInteger()
        def qs = TestingQ.findAll([max: testingPageFactor, offset: testingPageFactor * (page-1)])

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
        print params
        def admin = Owner.findByType("Admin")
        def worker = Owner.findByWorkerId(params.worker_id)
        def totalPage = Math.ceil(TestingQ.all.size() / testingPageFactor).toInteger();
        def page = params.page.toInteger()
        def qs = TestingQ.findAll([max: testingPageFactor, offset: testingPageFactor * (page-1)])

        [qs:qs, page:page,totalPage:totalPage, pageFactor: testingPageFactor, admin : admin, worker : worker]
    }


}
