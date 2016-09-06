package crowdcausaltraining

class TrainingA {

    static constraints = {
        text nullable: true, blank: false
    }

    static mapping = {
        highlights cascade: "all-delete-orphan"
        highlights sort:'id', order:'asc'
    }

    static hasMany = [highlights: TrainingA_H]
    static belongsTo = [question: TrainingQ, owner: Owner]

    String text

}
