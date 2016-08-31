package crowdcausaltraining

class TrainingA {

    static constraints = {
    }

    String text
    static hasMany = [highlights: TrainingA_H, questions: TrainingQ, owners: Owner]
    static belongsTo = [TrainingQ, Owner]
}
