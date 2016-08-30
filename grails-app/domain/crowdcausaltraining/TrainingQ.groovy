package crowdcausaltraining

class TrainingQ {

    static constraints = {
        post type: 'text', nullable: false, blank: false//, unique: true
        type nullable: false
    }
    static mapping = {
    }

    String postText
    static hasMany = [chunks: TrainingA]
    QType type
}
