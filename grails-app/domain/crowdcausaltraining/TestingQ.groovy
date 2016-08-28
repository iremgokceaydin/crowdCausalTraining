package crowdcausaltraining

class TestingQ {

    static constraints = {
        questionText nullable: false
        questionText blank: false
        questionText type: 'text'
        correctAnswer nullable: true
        type nullable: false
        highlights nullable: true
    }
    static mapping = {
        answers sort:'id', order:'asc'
        answers cascade: "all-delete-orphan"
    }

    String questionText
    static hasMany = [answers: TestingA]
    TestingA correctAnswer
    TestingType type
    List<String> highlights
}
