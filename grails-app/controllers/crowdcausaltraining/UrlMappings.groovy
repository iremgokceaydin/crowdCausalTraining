package crowdcausaltraining

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller:"admin", action: "index")
        "500"(view:'/error')
        "404"(view:'/notFound')

        name introduction: "/introduction/index" {
            controller = "introduction"
            action = "index"
        }

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



        name newTraining: "/admin/training/new" {
            controller = "admin"
            action = "newTrainingQ"
        }

        name editTraining: "/admin/training/edit/$id" {
            controller = "admin"
            action = "editTrainingQ"
        }

        name editTrainingChunks: "/admin/training/edit/$id/chunks"{
            controller = "admin"
            action = "editChunksOfTrainingQ"
        }

        name updateTraining: "/admin/training/update/$id" {
            controller = "admin"
            action = "updateTrainingQ"
        }

    }
}
