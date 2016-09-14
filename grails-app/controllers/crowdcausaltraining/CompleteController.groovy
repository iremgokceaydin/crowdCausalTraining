package crowdcausaltraining

class CompleteController {

    def success() {
        print "here"
        def worker = Owner.findByWorkerId(params.worker_id)
        worker.isWorkerEligible = true
        worker.save()
        [worker:worker]
    }

    def fail() {
        print "there"
        def worker = Owner.findByWorkerId(params.worker_id)
        worker.isWorkerEligible = false
        worker.save()
        [worker:worker]
    }
}
