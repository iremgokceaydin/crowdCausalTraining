import com.crowdCausalTraining.Role
import com.crowdCausalTraining.AppUser
import com.crowdCausalTraining.UserRole
import crowdcausaltraining.Owner
import crowdcausaltraining.QType
import crowdcausaltraining.Settings

class BootStrap {

    def init = { servletContext ->
        def adminRole = new Role(authority: 'ROLE_ADMIN').save()
        def userRole = new Role(authority: 'ROLE_USER').save()

        def admin = new AppUser(username: 'admin', password: '1').save()
        UserRole.create admin, adminRole

        UserRole.withSession {
            it.flush()
            it.clear()
        }

        def testingType1 = new QType(type: 'Testing', shortName: 'Type1', longName: 'No highlight').save()
        def testingType2 = new QType(type: 'Testing', shortName: 'Type2', longName: 'Highlights').save()
        def trainingType1 = new QType(type: 'Training', shortName: 'Type1', longName: 'No text').save()
        def trainingType2 = new QType(type: 'Training', shortName: 'Type2', longName: 'No text and no highlight').save()
        def trainingType3 = new QType(type: 'Training', shortName: 'Type3', longName: 'No answer').save()

        def adminOwner = Owner.findByType("Admin")

        if (adminOwner == null) {
            adminOwner = new Owner(type: 'Admin').save()
        }

        if (!Settings.count) {
            def settings = new Settings(pageFactorTesting: 5, pageFactorTraining: 1, numberOfCorrectTestingToFinish:5, showPreviousTrainingPostsFactor:3).save()
        }

        QType.withSession {
            it.flush()
            it.clear()
        }

        Owner.withSession {
            it.flush()
            it.clear()
        }

        Settings.withSession {
            it.flush()
            it.clear()
        }

    }
    def destroy = {
    }
}
