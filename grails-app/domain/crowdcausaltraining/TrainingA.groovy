package crowdcausaltraining

class TrainingA {

    static constraints = {
        highlights cascade: "all-delete-orphan"
        text nullable: true, blank: false
    }

    static hasMany = [highlights: TrainingA_H]
    static belongsTo = [question: TrainingQ, owner: Owner]

    String text

}
