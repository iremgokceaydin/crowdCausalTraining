package crowdcausaltraining

class TrainingQ {

    static constraints = {
        post type: 'text', nullable: false, blank: false//, unique: true
        type nullable: false
    }
    static mapping = {
        chunks sort:'id', order:'desc'
    }

    String postText
    static hasMany = [chunks: TrainingA]
    QType type
}
