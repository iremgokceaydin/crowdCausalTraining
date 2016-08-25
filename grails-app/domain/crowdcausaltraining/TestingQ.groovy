package crowdcausaltraining

class TestingQ {

    static constraints = {
    }

    String questionText
    static hasMany = [answers: TestingA]
    int rightAnswer
}
