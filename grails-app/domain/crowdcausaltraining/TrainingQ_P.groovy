package crowdcausaltraining

class TrainingQ_P {

    static constraints = {
        postText type: 'text', nullable: false, blank: false, unique: true
        isLatest default: false
    }

    static belongsTo = [question: TrainingQ]

    String postText
    boolean isLatest

}
