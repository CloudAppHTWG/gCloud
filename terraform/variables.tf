variable "project" {
  type    = string
  default = "cloud-app-366313"
}

variable "region" {
  type    = string
  default = "europe-west3-b"
}

variable "roles" {
  type    = set(string)
  default = ["roles/compute.networkUser", "roles/logging.logWriter", "roles/storage.objectViewer"]
}
