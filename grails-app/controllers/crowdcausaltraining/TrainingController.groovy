package crowdcausaltraining

import groovy.json.JsonSlurper

class TrainingController {
    def trainingPageFactor = 1

    def index() {
        def worker = Owner.findOrCreateByTypeAndWorkerId("Worker",params.worker_id)
        def page = params.page.toInteger()
        def qType = params.qType //ShortNames: Type1, Type2, Type3
        def qs = TrainingQ.findAllByType(QType.findByTypeAndShortName("Training", qType), [max: trainingPageFactor, offset: trainingPageFactor * (page-1)])
        [qs:qs, qType:qType, page:page, worker : worker]
    }

    def save(){
        print params
        def worker = Owner.findOrCreateByTypeAndWorkerId("Worker",params.worker_id)
        def admin = Owner.findByType("Admin")
        def page = params.page.toInteger()
        def qType = params.qType
        def q = TrainingQ.get(params.id)
        def qs = TrainingQ.findAllByType(QType.findByTypeAndShortName("Training", qType), [max: trainingPageFactor, offset: trainingPageFactor * (page-1)])


        q.chunks.each { c->
            if(worker.trainingAs.find{ it.question.id == c.question.id } != null)
                worker.removeFromTrainingAs(c)
        }


        def numberOfChunks = params.numberOfChunks.toInteger()
        for (def i = 0; i < numberOfChunks; i++) {
            def chunk = new TrainingA()
            chunk.question = q
            chunk.text = params.get("chunk-"+i+"-text")

            def jsonSlurper = new JsonSlurper()
            def highlights = jsonSlurper.parseText(params.get("chunk-"+i+"-highlights"))
            highlights.each { highlight->
                def h = new TrainingA_H()
                h.text = highlight.value
                h.referencedPost = TrainingQ_P.get(highlight.referencedPost.split("-")[1])
                chunk.addToHighlights(h)
            }
            q.addToChunks(chunk)
            worker.addToTrainingAs(chunk).save(flush:true)

        }
        if(q.save()) { //validate: false, flush: true
            redirect(action: "answer", params: [page:  page,qType:  qType, worker_id: worker.workerId])
        }
        else {
            render(view: "index", model: [qs:qs, page:page,qType:  qType, worker : worker])
        }
    }

    def answer(){
        print params
        def admin = Owner.findByType("Admin")
        def worker = Owner.findByWorkerId(params.worker_id)
        def page = params.page.toInteger()
        def totalPage = Math.ceil(TrainingQ.all.size() / trainingPageFactor).toInteger();
        def qType = params.qType

        def qs = TrainingQ.findAllByType(QType.findByTypeAndShortName("Training", qType), [max: trainingPageFactor, offset: trainingPageFactor * (page-1)])

        [qs:qs, page:page,qType: qType, totalPage:totalPage, pageFactor: trainingPageFactor, admin : admin, worker : worker]
    }


}
