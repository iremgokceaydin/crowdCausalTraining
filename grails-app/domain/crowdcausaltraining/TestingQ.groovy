package crowdcausaltraining

class TestingQ {

    static constraints = {
        questionText type: 'text', nullable: false, blank: false, unique: 'type'
        type nullable: false
        highlights nullable: true
    }
    static mapping = {
        answers sort:'id', order:'asc'
        answers cascade: "all-delete-orphan"
        sort type: "asc", id: "asc"
    }

    String questionText
    static hasMany = [answers: TestingA]
    QType type
    List<String> highlights
}
