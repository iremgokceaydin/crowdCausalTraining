package crowdcausaltraining

class TrainingQ {

    static constraints = {
        type nullable: false
        posts cascade: "all-delete-orphan"
        chunks cascade: "all-delete-orphan"
        posts sort:'isLatest'
    }
    static hasMany = [posts: TrainingQ_P, chunks: TrainingA]
    QType type
}
