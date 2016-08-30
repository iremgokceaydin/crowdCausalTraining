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

        name newTesting: "/admin/testing/new" {
            controller = "admin"
            action = "newTestingQ"
        }

        name editTesting: "/admin/testing/edit/$id" {
            controller = "admin"
            action = "editTestingQ"
        }

        name updateTesting: "/admin/testing/update/$id" {
            controller = "admin"
            action = "updateTestingQ"
        }

        name editTestingHighlights: "/admin/testing/edit/$id/highlights"{
            controller = "admin"
            action = "editHighlightsOfTestingQ"
        }
    }
}
