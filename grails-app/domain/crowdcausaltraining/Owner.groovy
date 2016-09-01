package crowdcausaltraining

class Owner {

    static constraints = {
        workerId nullable:true
        trainingAs cascade: "all-delete-orphan"
    }

    String type //Admin OR Worker
    int workerId
    static hasMany = [testingAs: TestingA, trainingAs: TrainingA]

}