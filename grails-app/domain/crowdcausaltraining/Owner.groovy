package crowdcausaltraining

class Owner {

    static constraints = {
        workerId nullable:true
        isWorkerEligible nullable:true
        isPassedTesting1 nullable:true
        isPassedTesting2 nullable:true
        lastTestingPageVisitedByWorker nullable:true
    }

    static mapping = {
        trainingAs cascade: "all-delete-orphan"
        trainingAs sort:'id', order:'asc'
    }

    String type //Admin OR Worker
    static hasMany = [testingAs: TestingA, trainingAs: TrainingA]

    //followings are worker specific
    int workerId
    boolean isWorkerEligible
    boolean isPassedTesting1, isPassedTesting2
    int lastTestingPageVisitedByWorker


}