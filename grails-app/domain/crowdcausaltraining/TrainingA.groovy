package crowdcausaltraining

class TrainingA {

    static constraints = {
        highlights cascade: "all-delete-orphan"
    }

    static hasMany = [highlights: TrainingA_H, owners: Owner]
    static belongsTo = [TrainingQ, Owner]

    String text
    TrainingQ question


}
