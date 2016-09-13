package crowdcausaltraining

import groovy.json.JsonSlurper

class TrainingController {

    def index() {
        def worker = Owner.findOrCreateByTypeAndWorkerId("Worker",params.worker_id)
        def admin = Owner.findByType("Admin")
        def page = params.page.toInteger()
        def qType = params.qType //ShortNames: Type1, Type2, Type3
        def pageFactor = Settings.first().pageFactorTraining
        def qs = TrainingQ.findAllByType(QType.findByTypeAndShortName("Training", qType), [max: pageFactor, offset: pageFactor * (page-1)])
        def totalPageType1 = Math.ceil(TrainingQ.findAllByType(QType.findByTypeAndShortName("Training", "Type1")).size() / pageFactor).toInteger();
        def totalPageType2 = Math.ceil(TrainingQ.findAllByType(QType.findByTypeAndShortName("Training", "Type2")).size() / pageFactor).toInteger();
        def totalPageType3 = Math.ceil(TrainingQ.findAllByType(QType.findByTypeAndShortName("Training", "Type3")).size() / pageFactor).toInteger();
        [qs:qs, qType:qType, page:page, worker : worker, admin: admin,  totalPageType1:totalPageType1,totalPageType2:totalPageType2,totalPageType3:totalPageType3]
    }

    def save(){
        print params
        def worker = Owner.findOrSaveByTypeAndWorkerId("Worker",params.worker_id)
        def page = params.page.toInteger()
        def pageFactor = Settings.first().pageFactorTraining
        def qType = params.qType
        def qs = TrainingQ.findAllByType(QType.findByTypeAndShortName("Training", qType), [max: pageFactor, offset: pageFactor * (page-1)])
        def isError = false
        def totalPageType1 = Math.ceil(TrainingQ.findAllByType(QType.findByTypeAndShortName("Training", "Type1")).size() / pageFactor).toInteger();
        def totalPageType2 = Math.ceil(TrainingQ.findAllByType(QType.findByTypeAndShortName("Training", "Type2")).size() / pageFactor).toInteger();
        def totalPageType3 = Math.ceil(TrainingQ.findAllByType(QType.findByTypeAndShortName("Training", "Type3")).size() / pageFactor).toInteger();

        params.list("id").each  { qId ->
            def q = TrainingQ.get(qId)
            worker.trainingAs?.findAll{ it.question.id == q.id }.each { c->
                worker.removeFromTrainingAs(c)
                q.removeFromChunks(c)
            }

            q.save(flush:true)

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
            if(qType == "Type3") {
                if(totalPageType3 > page)
                    redirect(action: "index", params: [page: page+1, qType: qType, worker_id: worker.workerId])
                else
                    redirect(controller: "complete", action: "index", params: [worker_id: worker.workerId])
            }
            else
                redirect(action: "answer", params: [page:  page,qType:  qType,worker_id : worker.workerId])
        }
        else
            render(view: "index", model: [qs: qs, page: page, qType: qType, worker: worker,totalPageType1:totalPageType1,totalPageType2:totalPageType2,totalPageType3:totalPageType3])
    }

    def answer(){
        print params
        def admin = Owner.findByType("Admin")
        def worker = Owner.findByWorkerId(params.worker_id)
        def page = params.page.toInteger()
        def pageFactor = Settings.first().pageFactorTraining
        def totalPageType1 = Math.ceil(TrainingQ.findAllByType(QType.findByTypeAndShortName("Training", "Type1")).size() / pageFactor).toInteger();
        def totalPageType2 = Math.ceil(TrainingQ.findAllByType(QType.findByTypeAndShortName("Training", "Type2")).size() / pageFactor).toInteger();
        def totalPageType3 = Math.ceil(TrainingQ.findAllByType(QType.findByTypeAndShortName("Training", "Type3")).size() / pageFactor).toInteger();
        def qType = params.qType

        def qs = TrainingQ.findAllByType(QType.findByTypeAndShortName("Training", qType), [max: pageFactor, offset: pageFactor * (page-1)])

        [qs:qs, page:page,qType: qType, totalPageType1:totalPageType1,totalPageType2:totalPageType2,totalPageType3:totalPageType3, admin : admin, worker : worker]
    }


}
