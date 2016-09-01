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
//        print params
//        def worker = Owner.findOrCreateByTypeAndWorkerId("Worker",params.worker_id)
//        def page = params.page.toInteger()
//        def qType = params.qType
//        def q = TrainingQ.get(params.id)
//        //def qs = TrainingQ.findAllByType(QType.findByTypeAndShortName("Training", qType), [max: trainingPageFactor, offset: trainingPageFactor * (page-1)])
//        Owner admin = Owner.findByType("Admin")
//
//        q.chunks.each { c->
//            if(admin.trainingAs.find{ it.id == c.id } != null)
//                admin.removeFromTrainingAs(c)
//        }
//        q.chunks.clear()
//
//        def numberOfChunks = params.numberOfChunks.toInteger()
//        for (def i = 0; i < numberOfChunks; i++) {
//            def chunk = new TrainingA()
//            chunk.question = q
//            chunk.text = params.get("chunk-"+i+"-text")
//
//            def jsonSlurper = new JsonSlurper()
//            def highlights = jsonSlurper.parseText(params.get("chunk-"+i+"-highlights"))
//            highlights.each { highlight->
//                def h = new TrainingA_H()
//                h.text = highlight.value
//                h.referencedPost = TrainingQ_P.get(highlight.referencedPost.split("-")[1])
//                chunk.addToHighlights(h)
//            }
//            q.addToChunks(chunk)
//
//        }
//        if(q.save()) { //validate: false, flush: true
//            q.chunks.each {admin.addToTrainingAs(it).save()}
//            redirect(action: "training")
//        }
//        else {
//            render(view: "editChunksOfTrainingQ", model: [q: q])
//        }
////        params.list('question').each  { q ->
////            worker.addToTestingAs(TestingA.get(params.get("answer_" + q)))
////        }
////
////
////        if(worker.save(flush: true)) { //validate: false, flush: true
////            redirect(action: "answer", params: [page:  page, worker_id: worker.workerId])
////
////        }
////        else {
////            render(view: "index", model: [qs:qs, page:page, worker : worker])
////        }
//
//
//
//
//
//
////        print params
////        def q = TrainingQ.get(params.id)
////        Owner admin = Owner.findByType("Admin")
//        q.chunks.each { c->
//            if(admin.trainingAs.find{ it.id == c.id } != null)
//                admin.removeFromTrainingAs(c)
//        }
//        q.chunks.clear()
//
//        def numberOfChunks = params.numberOfChunks.toInteger()
//        for (def i = 0; i < numberOfChunks; i++) {
//            def chunk = new TrainingA()
//            chunk.question = q
//            chunk.text = params.get("chunk-"+i+"-text")
//
//            def jsonSlurper = new JsonSlurper()
//            def highlights = jsonSlurper.parseText(params.get("chunk-"+i+"-highlights"))
//            highlights.each { highlight->
//                def h = new TrainingA_H()
//                h.text = highlight.value
//                h.referencedPost = TrainingQ_P.get(highlight.referencedPost.split("-")[1])
//                chunk.addToHighlights(h)
//            }
//            q.addToChunks(chunk)
//
//        }
//        if(q.save()) { //validate: false, flush: true
//            q.chunks.each {admin.addToTrainingAs(it).save()}
//            redirect(action: "training")
//        }
//        else {
//            render(view: "editChunksOfTrainingQ", model: [q: q])
//        }
    }


}
