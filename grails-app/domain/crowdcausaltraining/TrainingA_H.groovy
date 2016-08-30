package crowdcausaltraining

class TrainingA_H {

    static constraints = {
    }

    String text
    TrainingQ referencedPost
    static belongsTo = [answer: TrainingA]
}
