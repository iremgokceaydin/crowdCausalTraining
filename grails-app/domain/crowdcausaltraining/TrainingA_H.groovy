package crowdcausaltraining

class TrainingA_H {

    static constraints = {
        text type: 'text', nullable: false, blank: false
    }

    String text
    static belongsTo = [chunk: TrainingA, referencedPost: TrainingQ_P]
}
