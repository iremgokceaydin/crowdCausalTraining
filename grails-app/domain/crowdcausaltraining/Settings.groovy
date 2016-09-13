package crowdcausaltraining

class Settings {

    static constraints = {
        pageFactorTesting nullable: false, blank: false
        pageFactorTraining nullable: false, blank: false
        numberOfCorrectTestingToFinish nullable: false, blank: false
    }

    int pageFactorTesting   //number of question within one page
    int pageFactorTraining  //number of question within one page
    int numberOfCorrectTestingToFinish
}
