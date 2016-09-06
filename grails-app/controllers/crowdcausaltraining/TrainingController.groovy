package crowdcausaltraining

import groovy.json.JsonSlurper

class TrainingController {
    def trainingPageFactor = 1

    def index() {
        def worker = Owner.findOrCreateByTypeAndWorkerId("Worker",params.worker_id)
        def admin = Owner.findByType("Admin")
        def page = params.page.toInteger()
        def qType = params.qType //ShortNames: Type1, Type2, Type3
        def qs = TrainingQ.findAllByType(QType.findByTypeAndShortName("Training", qType), [max: trainingPageFactor, offset: trainingPageFactor * (page-1)])
        [qs:qs, qType:qType, page:page, worker : worker, admin: admin]
    }

    def save(){
        print params
        def admin = Owner.findByType("Admin")
        def worker = Owner.findOrSaveByTypeAndWorkerId("Worker",params.worker_id)
        def page = params.page.toInteger()
        def qType = params.qType
        def qs = TrainingQ.findAllByType(QType.findByTypeAndShortName("Training", qType), [max: trainingPageFactor, offset: trainingPageFactor * (page-1)])
        def totalPage = Math.ceil(TrainingQ.all.size() / trainingPageFactor).toInteger();
        def isError = false

        params.list("id").each  { qId ->
            print "here"+qId
            def q = TrainingQ.get(qId)
            def l = []
            l += worker.trainingAs?.findAll {it.question.id == q.id}

            l.each { chunk ->
                worker.removeFromTrainingAs(chunk)
                q.removeFromChunks(chunk)
                chunk.delete(flush:true)
            }

            params.list("numberOfChunks").each  { chunksNumber ->
                def totalChunksForOneQ = chunksNumber.toInteger()
                print totalChunksForOneQ
                for (def i = 0; i < totalChunksForOneQ; i++) {
                    def chunk = new TrainingA()
                    chunk.question = q
                    chunk.text = params.get("chunk-"+q.id+"-"+i+"-text")

                    def jsonSlurper = new JsonSlurper()
                    def highlights = jsonSlurper.parseText(params.get("chunk-"+q.id+"-"+i+"-highlights"))
                    highlights.each { highlight->
                        def h = new TrainingA_H()
                        h.text = highlight.value
                        h.referencedPost = TrainingQ_P.get(highlight.referencedPost.split("-")[1])
                        chunk.addToHighlights(h)
                    }
                    q.addToChunks(chunk)
                    worker.addToTrainingAs(chunk)
                }
            }
        }

        if(worker.save()) {
            print "size"+worker.trainingAs.size()
            redirect(action: "answer", params: [page:  page,qType:  qType,worker_id : worker.workerId])
        }
        else
            render(view: "index", model: [qs: qs, page: page, qType: qType, worker: worker])
    }

    def answer(){
        print params
        def admin = Owner.findByType("Admin")
        def worker = Owner.findByWorkerId(params.worker_id)
        def page = params.page.toInteger()
        def totalPage = Math.ceil(TrainingQ.all.size() / trainingPageFactor).toInteger();
        def qType = params.qType

        def qs = TrainingQ.findAllByType(QType.findByTypeAndShortName("Training", qType), [max: trainingPageFactor, offset: trainingPageFactor * (page-1)])

        [qs:qs, page:page,qType: qType, totalPage:totalPage, admin : admin, worker : worker]
    }


}
