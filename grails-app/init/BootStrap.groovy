import com.crowdCausalTraining.Role
import com.crowdCausalTraining.User
import com.crowdCausalTraining.UserRole

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

        assert User.count() == 1
        assert Role.count() == 2
        assert UserRole.count() == 1
    }
    def destroy = {
    }
}
