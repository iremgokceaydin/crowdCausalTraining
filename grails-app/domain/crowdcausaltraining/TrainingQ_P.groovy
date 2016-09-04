package crowdcausaltraining

class TrainingQ_P {

    static constraints = {
        postText type: 'text', nullable: false, blank: false, unique: 'question'
        isLatest default: false//, unique: 'question' //TODO: uniqueness based on value, should be only one 'true'
    }

    static mapping = {
        highlights cascade: "all-delete-orphan"
    }

    static belongsTo = [question: TrainingQ]
    static hasMany = [highlights: TrainingA_H]

    String postText
    boolean isLatest

}
