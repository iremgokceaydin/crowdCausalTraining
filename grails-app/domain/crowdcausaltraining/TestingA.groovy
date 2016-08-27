package crowdcausaltraining

class TestingA {

    static constraints = {
        answerText nullable:false
        answerText blank: false
    }

    static belongsTo = [question: TestingQ]
    String answerText
}
