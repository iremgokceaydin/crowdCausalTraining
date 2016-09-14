package crowdcausaltraining

class TrainingQ {

    static constraints = {
        type nullable: false
    }

    static mapping = {
        posts cascade: "all-delete-orphan"
        chunks cascade: "all-delete-orphan"
        chunks sort: 'id', order:'asc'
        sort type: "asc", id:"asc"
        //posts sort:'isLatest' needed no more since I am creating the latest post latest.
        posts sort:'id'
    }

    static hasMany = [posts: TrainingQ_P, chunks: TrainingA]
    QType type
}
