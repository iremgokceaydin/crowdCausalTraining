package crowdcausaltraining

class TestingA {

    static constraints = {
        answerText type: 'text', nullable:false, blank: false, unique: true
    }

    static belongsTo = [question: TestingQ]
    String answerText
}
