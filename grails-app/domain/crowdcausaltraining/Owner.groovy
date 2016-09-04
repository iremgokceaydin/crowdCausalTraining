package crowdcausaltraining

class Owner {

    static constraints = {
        workerId nullable:true
    }

    static mapping = {
        trainingAs cascade: "all-delete-orphan"
    }

    String type //Admin OR Worker
    int workerId
    static hasMany = [testingAs: TestingA, trainingAs: TrainingA]

}