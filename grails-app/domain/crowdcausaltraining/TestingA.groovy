package crowdcausaltraining

class TestingA {

    static constraints = {
        answerText type: 'text', nullable:false, blank: false, unique: 'question'
    }

    static belongsTo = [TestingQ]

    String answerText
    TestingQ question
}
