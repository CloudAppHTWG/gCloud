
# create bucket for storing terraform state
resource "google_storage_bucket" "terraform-state" {
  project       = var.project
  name          = "${var.project}-cloud-app-terraform-state"
  location      = "EU"
  force_destroy = true
}

# create bucket for storing media files
resource "google_storage_bucket" "databucket1" {
  project       = var.project
  name          = "${var.project}-databucket1"
  location      = "EU"
  force_destroy = true
}

# firestore database for storing metadata
resource "google_firestore_document" "files" {
  project     = var.project
  collection  = "files"
  document_id = "files"
  #fields as json string: name, desc, bucketKey
  fields = "{\"something\":{\"mapValue\":{\"fields\":{\"akey\":{\"stringValue\":\"avalue\"}}}}}"
}
