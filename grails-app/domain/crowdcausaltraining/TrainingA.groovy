package crowdcausaltraining

class TrainingA {

    static constraints = {
        highlights cascade: "all-delete-orphan"
        text nullable: true, blank: false
    }

    static hasMany = [highlights: TrainingA_H]
    static belongsTo = [TrainingQ, Owner]

    String text
    TrainingQ question
    Owner owner


}
