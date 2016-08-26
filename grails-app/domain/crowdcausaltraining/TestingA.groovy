package crowdcausaltraining

class TestingA {

    static constraints = {
        answerText nullable:false
    }

    static belongsTo = [question: TestingQ]
    String answerText
}
