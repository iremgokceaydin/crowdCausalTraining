package crowdcausaltraining

class TrainingA_H {

    static constraints = {
        text type: 'text', nullable: false, blank: false
        referencedPost nullable: false
    }

    String text
    TrainingQ_P referencedPost
    static belongsTo = [chunk: TrainingA]
}
