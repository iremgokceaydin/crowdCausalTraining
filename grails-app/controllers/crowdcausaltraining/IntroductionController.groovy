package crowdcausaltraining

class IntroductionController {

    def index() {
        print params
        def worker = Owner.findOrCreateByTypeAndWorkerId("Worker",params.worker_id)
        worker.save(flush:true)
        [worker : worker]

    }

    def tutorial() {
        def worker = Owner.findOrCreateByTypeAndWorkerId("Worker",params.worker_id)
        worker.lastTestingPageVisitedByWorker = session["lastTestingType2PageVisited"] //type2 testing question
        worker.save()
        [worker : worker]
    }
}
