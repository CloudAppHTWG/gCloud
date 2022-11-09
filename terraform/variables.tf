variable "project" {
  type    = string
  default = "terraformtestproject-368119"
}

variable "region" {
  type    = string
  default = "europe-west3-b"
}

variable "roles" {
  type    = set(string)
  default = ["roles/compute.networkUser", "roles/logging.logWriter", "roles/storage.objectCreator", "roles/appengine.appAdmin", "roles/storage.objectViewer", "roles/firebase.admin"]
}
