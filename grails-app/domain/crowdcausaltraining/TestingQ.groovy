package crowdcausaltraining

class TestingQ {

    static constraints = {
        questionText type: 'text', nullable: false, blank: false, unique: true
        correctAnswer nullable: true
        type nullable: false
        highlights nullable: true
    }
    static mapping = {
        answers sort:'id', order:'desc'
        answers cascade: "all-delete-orphan"
    }

    String questionText
    static hasMany = [answers: TestingA]
    TestingA correctAnswer
    QType type
    List<String> highlights
}
