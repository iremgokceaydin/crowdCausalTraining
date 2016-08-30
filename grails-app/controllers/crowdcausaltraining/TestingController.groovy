package crowdcausaltraining

class TestingController {

    def index() {
        def worker = Worker.findOrCreateByWorkerId(params.worker_id)
        def testingPageFactor = 2
        def totalTestingPage = Math.ceil(TestingQ.all.size() / testingPageFactor);
        def page = params.page.toInteger()
        def qs = TestingQ.findAll([max: testingPageFactor, offset: (testingPageFactor * page)-1])
        [qs:qs, page:page, totalPage: totalTestingPage, worker : worker]
    }

    def save(){
        def worker = Worker.findOrCreateByWorkerId(params.worker_id)
        def page = params.page.toInteger()

        if(q.save()) { //validate: false, flush: true
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


}
