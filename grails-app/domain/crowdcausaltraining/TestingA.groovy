package crowdcausaltraining

class TestingA {

    static constraints = {
        answerText nullable:false
        answerText blank: false
        answerText type: 'text'
    }

    static belongsTo = [question: TestingQ]
    String answerText
}
