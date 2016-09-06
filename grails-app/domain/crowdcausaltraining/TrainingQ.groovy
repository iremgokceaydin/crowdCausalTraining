package crowdcausaltraining

class TrainingQ {

    static constraints = {
        type nullable: false
        posts sort:'isLatest'
    }

    static mapping = {
        posts cascade: "all-delete-orphan"
        chunks cascade: "all-delete-orphan"
        chunks sort: 'id'
        sort type: "asc"
    }

    static hasMany = [posts: TrainingQ_P, chunks: TrainingA]
    QType type
}
