package crowdcausaltraining

class TrainingController {
    def trainingPageFactor = 1

    def index() {
        def worker = Worker.findOrCreateByWorkerId(params.worker_id)
        def page = params.page.toInteger()
        def qs = TrainingQ.findAll([max: trainingPageFactor, offset: trainingPageFactor * (page-1)])
        [qs:qs, page:page, pageFactor: trainingPageFactor, worker : worker]
    }
}
