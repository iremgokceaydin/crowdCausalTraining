package crowdcausaltraining

class IntroductionController {

    def index() {
        def worker = Worker.findOrCreateByWorkerId(params.worker_id)
        [worker : worker]

    }
}
