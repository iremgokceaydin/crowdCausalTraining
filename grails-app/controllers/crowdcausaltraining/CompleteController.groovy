package crowdcausaltraining

class CompleteController {

    def success() {
        def worker = Owner.findByWorkerId(params.worker_id)
        worker.isWorkerEligible = true
        worker.save()
    }

    def fail() {
        def worker = Owner.findByWorkerId(params.worker_id)
        worker.isWorkerEligible = false
        worker.save()
    }
}
