package crowdcausaltraining

class TestingA {

    static constraints = {
        answerText type: 'text', nullable:false, blank: false, unique: 'question' //TODO apply this
    }

    static belongsTo = [question: TestingQ]

    String answerText
}
