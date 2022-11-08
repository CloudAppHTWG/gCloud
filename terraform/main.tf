# setup provider 
provider "google" {
  project     = "cloud-app-366313"
  region      = "europe-west3-b"
  credentials = file("../coderecources/ChristophJurisch.json")
}

# app engine frontend angular
resource "google_app_engine_flexible_app_version" "frontend" {
  project    = "cloud-app"
  service    = "frontend"
  version_id = "v1"
  runtime    = "custom"
  deployment {
    zip {
      source_url = "../coderecources/CloudApp_frontend.zip"
    }
  }
  readiness_check {
    path = "/"
  }
  liveness_check {
    path = "/"
  }
  automatic_scaling {
    cpu_utilization {
      target_utilization = 0.95
    }
  }
}

# app engine backend nodejs
resource "google_app_engine_flexible_app_version" "nodeJSEndpoint" {
  project    = "cloud-app"
  service    = "nodeJSEndpoint"
  version_id = "v1"
  runtime    = "nodejs"
  entrypoint {
    shell = "node index.js"
  }
  deployment {
    zip {
      source_url = "../coderecources/nodeJSEndpoint.zip"
    }
  }
  readiness_check {
    path = "/"
  }
  liveness_check {
    path = "/"
  }
  automatic_scaling {
    cpu_utilization {
      target_utilization = 0.95
    }
  }
}


