# setup provider 
provider "google" {
  project = var.project
  region  = var.region
}

resource "google_app_engine_application" "cloud_app" {
  project       = var.project
  location_id   = "europe-west3"
  database_type = "CLOUD_FIRESTORE"
}

resource "google_project_service" "service" {
  project                    = var.project
  service                    = "appengineflex.googleapis.com"
  disable_dependent_services = false
}

resource "google_service_account" "service_account" {
  project      = var.project
  account_id   = "cloud-app-sa"
  display_name = "CloudApp Service Account"
}

resource "google_project_iam_member" "gae_api" {
  for_each = var.roles
  project  = var.project
  role     = each.value
  member   = "serviceAccount:${google_service_account.service_account.email}"
}



resource "google_app_engine_standard_app_version" "nodejsEndpoint" {
  version_id = "v1"
  service    = "default"
  runtime    = "nodejs16"

  env_variables = {
    projectId = var.project
  }

  entrypoint {
    shell = "node ./index.js"
  }


  deployment {
    zip {
      source_url = "https://storage.googleapis.com/${google_storage_bucket.app_engine.name}/${google_storage_bucket_object.nodejsEndpoint.name}"
    }
  }
  delete_service_on_destroy = true
  service_account           = google_service_account.service_account.email
}
#frontend
resource "google_app_engine_flexible_app_version" "angularFrontend" {
  version_id     = "v1"
  service        = "frontend"
  runtime        = "custom"
  instance_class = "F4"

  liveness_check {
    path = "./"
  }
  readiness_check {
    path = "./"
  }
  env_variables = {
    url = "test url"
  }
  automatic_scaling {
    cpu_utilization {
      target_utilization = 0.9
    }
  }

  entrypoint {
    shell = "cd CloudApp-exercise4"
  }
  deployment {
    zip {
      source_url = "https://storage.googleapis.com/${google_storage_bucket.app_engine.name}/${google_storage_bucket_object.angularFrontend.name}"
    }
  }

  delete_service_on_destroy = true
  service_account           = google_service_account.service_account.email
}
# activate firestore api
resource "google_project_service" "firestore" {
  project = var.project
  service = "firestore.googleapis.com"

  disable_dependent_services = true
}
# output app engine url nodejsEndpoint
output "nodejsEndpoint" {
  value = "https://${google_app_engine_standard_app_version.nodejsEndpoint.id}.appspot.com"
}

/* # output app engine url nodejsEndpoint
output "nodejsEndpoint" {
  value = google_app_engine_standard_app_version.nodejsEndpoint.default_hostname
}
 */

# output service account email for nodejsEndpoint
output "service_account_email" {
  value = google_service_account.service_account.email
}

