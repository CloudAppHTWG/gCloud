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

resource "google_storage_bucket" "app_engine" {
  project       = var.project
  name          = "${var.project}-app-engine"
  location      = "EU"
  force_destroy = true
}

resource "google_storage_bucket_object" "nodejsEndpoint" {
  name   = "nodejsEndpoint.zip"
  bucket = google_storage_bucket.app_engine.name
  source = "../coderecources/nodeJSEndpoint.zip"
}

resource "google_app_engine_standard_app_version" "nodejsEndpoint" {
  version_id = "v1"
  service    = "default"
  runtime    = "nodejs16"

  entrypoint {
    shell = "node ./nodejsEndpoint/index.js"
  }

  deployment {
    zip {
      source_url = "https://storage.googleapis.com/${google_storage_bucket.app_engine.name}/${google_storage_bucket_object.nodejsEndpoint.name}"
    }
  }

  delete_service_on_destroy = true
  service_account           = google_service_account.service_account.email
}
