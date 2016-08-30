package crowdcausaltraining

class QType {

    static constraints = {
        shortName (unique: ['type'])
    }

    String shortName
    String longName
    String type
}
