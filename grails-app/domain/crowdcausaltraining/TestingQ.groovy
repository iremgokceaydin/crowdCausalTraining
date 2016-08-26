package crowdcausaltraining

class TestingQ {

    static constraints = {
        questionText nullable: false
        correctAnswer nullable: true
    }
    static mapping = {
        answers sort:'id', order:'asc'
    }

    String questionText
    static hasMany = [answers: TestingA]
    TestingA correctAnswer
}
