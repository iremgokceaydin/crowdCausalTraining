import com.crowdCausalTraining.Role
import com.crowdCausalTraining.User
import com.crowdCausalTraining.UserRole
import crowdcausaltraining.TestingType

class BootStrap {

    def init = { servletContext ->
        def adminRole = new Role(authority: 'ROLE_ADMIN').save()
        def userRole = new Role(authority: 'ROLE_USER').save()

        def admin = new User(username: 'admin', password: '1').save()
        UserRole.create admin, adminRole

        UserRole.withSession {
            it.flush()
            it.clear()
        }

        def testingType1 = new TestingType(shortName: 'Type1', longName: 'No highlight').save()
        def testingType2 = new TestingType(shortName: 'Type2', longName: 'Highlights').save()
    }
    def destroy = {
    }
}
