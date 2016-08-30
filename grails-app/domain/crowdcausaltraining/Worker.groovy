package crowdcausaltraining

class Worker {

    static constraints = {
        workerId blank : false, nullable : false
    }

    int workerId
    static hasMany = [testingQs: TestingQ, testingAs: TestingA, trainingQs: TrainingQ, trainingAs: TrainingA]

}
