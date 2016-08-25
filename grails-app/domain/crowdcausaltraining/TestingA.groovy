package crowdcausaltraining

class TestingA {

    static constraints = {
        question nullable:false
    }

    static belongsTo = [question: TestingQ]
    String answerText
    TestingQ question
}
