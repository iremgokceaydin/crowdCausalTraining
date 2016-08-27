package crowdcausaltraining

class TestingQ {

    static constraints = {
        questionText nullable: false
        questionText blank: false
        correctAnswer nullable: true
    }
    static mapping = {
        answers sort:'id', order:'asc'
        answers cascade: "all-delete-orphan"
    }

    String questionText
    static hasMany = [answers: TestingA]
    TestingA correctAnswer
}
