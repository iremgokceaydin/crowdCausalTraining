package crowdcausaltraining

class IntroductionController {

    def index() {
        print params
        def worker = Worker.findOrCreateByWorkerId(params.worker_id) //params.worker_id
        worker.save(flush:true)
        [worker : worker]

    }
}
