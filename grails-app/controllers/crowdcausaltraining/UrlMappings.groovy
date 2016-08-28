package crowdcausaltraining

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(view:"/introduction/index")
        "500"(view:'/error')
        "404"(view:'/notFound')

        "/admin/testing/new" {
            controller = "admin"
            action = "newTestingQ"
        }

        name editTesting: "/admin/testing/edit/$id" {
            controller = "admin"
            action = "editTestingQ"
        }

        name editTestingHighlights: "/admin/testing/edit/$id/highlights"{
            controller = "admin"
            action = "editHighlightsOfTestingQ"
        }
    }
}
