package crowdcausaltraining

class TestingQ {

    static constraints = {
        questionText type: 'text', nullable: false, blank: false, unique: 'type'
//        correctAnswer nullable: true //Owner admin's answer will be the correct one.
        type nullable: false
        highlights nullable: true
    }
    static mapping = {
        answers sort:'id', order:'asc'
        answers cascade: "all-delete-orphan"
    }

    String questionText
    static hasMany = [answers: TestingA]
//    TestingA correctAnswer //Owner admin's answer will be the correct one.
    QType type
    List<String> highlights
}
