package crowdcausaltraining

import groovy.json.JsonSlurper

class AdminController {

    def index() { }

    //TESTING

    def testing() {
        def qs = TestingQ.list()
        [qs:qs]
    }

    def newTestingQ(){
        def q = new TestingQ()
        [q:q]
    }

    def createTestingQ(){ //ToDo unique constraint
        print params
        def admin = Owner.findByType("Admin")
        def isError = false

        def q = new TestingQ()
        q.questionText = params.questionText
        q.type = QType.get(params.type)
        params.list('answerText').eachWithIndex  { a, index ->
            def tA = new TestingA()
            tA.answerText = a
            q.addToAnswers(tA)
            if(!q.save(flush:true)){
                isError = true
                def temp_q = q
                def errors = q.errors.allErrors
                q.answers.each { b->
                    if(admin.testingAs.find{ it.id == b.id } != null)
                        admin.removeFromTestingAs(b)
                }
                q.delete(flush: true)
                admin.save()
                render(view: "newTestingQ", model: [q: temp_q, errors:errors])
            }
            else {
                if (params.containsKey("answer") && params.answer.toInteger() == index) {
                    admin.addToTestingAs(tA)
                }
            }
        }

        if(!isError) {
            admin.save()
            redirect(action: "testing")
        }
    }

    def newTestingA(){
        print params
        render(template:"newTestingA")
    }

    def editTestingQ(){
        def q = TestingQ.get(params.id)
        [q:q]
    }

    def updateTestingQ(){
        def q = TestingQ.get(params.id)
        def admin = Owner.findByType("Admin")
        def isError = false

        q.answers.each {a ->
            if(admin.testingAs.find {it.id == a.id})
                admin.removeFromTestingAs(a)
        }

        q.answers.clear()
        q.save(flush:true)

        if(params.questionText != q.questionText) //TODO: should not be like this but because the unique constraint fails with update somehow I needed to
            q.questionText = params.questionText
        q.type = QType.get(params.type)
        if(q.type == QType.findByTypeAndShortName("Testing", "Type1"))
            q.highlights = []

        params.list('answerText').eachWithIndex  { a, index ->
            def tA = new TestingA()
            tA.answerText = a
            q.addToAnswers(tA)
            if(!q.save(flush:true)){
                isError = true
            }
            else {
                if (params.containsKey("answer") && params.answer.toInteger() == index) {
                    admin.addToTestingAs(tA).save(flush:true)
                }
            }
        }

        if(!isError) {
            admin.save()
            redirect(action: "testing")
        }
        else{
            render(view: "editTestingQ", model: [q: q])
        }
    }

    def deleteTestingQ(){
        def q = TestingQ.get(params.id)
        Owner admin = Owner.findByType("Admin")
        q.answers.each { a->
            if(admin.testingAs.find{ it.id == a.id } != null)
                admin.removeFromTestingAs(a)
        }
        q.delete()
        redirect(action:"testing")
    }

    def editHighlightsOfTestingQ(){
        def q = TestingQ.get(params.id)
        [q:q]
    }

    def updateHighlightsOfTestingQ(){
        print params
        def q = TestingQ.get(params.id)
        q.highlights = []
        params.list('highlight').each  {
            q.highlights.push(it)
        }
        if(q.save()) {
            redirect(action: "testing")
        }
        else {
            render(view: "editHighlightsOfTestingQ", model: [q: q])
        }
    }

    //TRAINING

    def training() {
        def qs = TrainingQ.list()
        [qs:qs]
    }

    def newTrainingQ(){
        def q = new TrainingQ()
        [q:q]
    }

    def newTrainingQ_P(){
        print params
        render(template:"newTrainingQ_P")
    }

    //TODO check validation for child as well
    def createTrainingQ(){
        print params
        def q = new TrainingQ()
        def isError = false
        q.type = QType.get(params.type)
        params.list('postText').eachWithIndex  { pT, index ->
            def tQ_P = new TrainingQ_P()
            tQ_P.postText = pT
            if (params.containsKey("latestPost") && params.latestPost.toInteger() == index) {
                tQ_P.isLatest = true
            }

            q.addToPosts(tQ_P)
            if(!q.save(flush:true)){
                isError = true
                def temp_q = q
                def errors = q.errors.allErrors
                q.delete(flush: true)
                render(view: "newTrainingQ", model: [q: temp_q, errors:errors])
            }
        }
        if(!isError) {
            redirect(action: "training")
        }
    }

    def editTrainingQ(){
        def q = TrainingQ.get(params.id)
        [q:q]
    }

    def editChunksOfTrainingQ(){
        Owner admin = Owner.findByType("Admin")
        def q = TrainingQ.get(params.id)
        [q:q, admin: admin]
    }

    def updateTrainingQ(){
        print params
        def admin = Owner.findByType("Admin")
        def workers = Owner.findAllByType("Worker")
        def q = TrainingQ.get(params.id)
        def isError = false

        q.type = QType.get(params.type)
        //if(q.type == QType.findByTypeAndShortName("Training", "Type3")) {
            q.chunks.each {a ->
                if(admin.trainingAs.find {it.id == a.id})
                    admin.removeFromTrainingAs(a).save()
                workers.each {w ->
                    if(w.trainingAs.find {it.id == a.id})
                        w.removeFromTrainingAs(a).save()
                }
            }
        //}
        q.chunks.clear()
        q.posts.clear()
        q.save(flush:true)
        print q.posts.size()

        params.list('postText').eachWithIndex  { pT, index ->
            def tQ_P = new TrainingQ_P()
            tQ_P.postText = pT
            if (params.containsKey("latestPost") && params.latestPost.toInteger() == index) {
                print "here"
                tQ_P.isLatest = true
            }

            q.addToPosts(tQ_P)

            if(!q.save(flush:true)){
                isError = true
            }
        }

        if(!isError) {
            redirect(action: "training")
        }
        else{
            render(view: "editTrainingQ", model: [q: q])
        }
    }

    def updateChunksOfTrainingQ(){
        print params
        def q = TrainingQ.get(params.id)
        Owner admin = Owner.findByType("Admin")
        q.chunks.each { c->
            if(admin.trainingAs.find{ it.id == c.id } != null)
                admin.removeFromTrainingAs(c)
        }
        q.chunks.clear()
        q.save(flush:true)

        def numberOfChunks = params.numberOfChunks.toInteger()
        for (def i = 0; i < numberOfChunks; i++) {
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
            admin.addToTrainingAs(chunk)

        }
        if(q.save()) { //validate: false, flush: true
            admin.save()
            redirect(action: "training")
        }
        else {
            render(view: "editChunksOfTrainingQ", model: [q: q, admin:admin])
        }

    }

    def deleteTrainingQ(){
        def q = TrainingQ.get(params.id)
        Owner admin = Owner.findByType("Admin")
        q.chunks.each { c->
            if(admin.trainingAs.find{ it.id == c.id } != null)
                admin.removeFromTrainingAs(c)
        }
        q.delete(flush:true)
        redirect(action:"training")
    }

}
