
# create bucket for storing terraform state
resource "google_storage_bucket" "terraform-state" {
  project       = var.project
  name          = "${var.project}-cloud-app-terraform-state"
  location      = "EU"
  force_destroy = true
}

# create bucket for storing media files
resource "google_storage_bucket" "databuckets1" {
  project       = var.project
  name          = "${var.project}-databuckets1"
  location      = "EU"
  force_destroy = true
}

# firestore database for storing metadata
resource "google_firestore_document" "files" {
  project     = var.project
  collection  = "files"
  document_id = "images"
  #fields as json string: name, desc, bucketKey
  fields = "{\"something\":{\"mapValue\":{\"fields\":{\"bucketKey\":{\"stringValue\":\"avalue\"}}}}}"
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
resource "google_storage_bucket_object" "angularFrontend" {
  name   = "CloudApp_frontend.zip"
  bucket = google_storage_bucket.app_engine.name
  source = "../coderecources/CloudApp_frontend.zip"
  # media_link = "https://github.com/ChrisMythos/CloudApp/archive/refs/heads/exercise4.zip"
}
