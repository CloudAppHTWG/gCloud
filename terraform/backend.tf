terraform {
 backend "gcs" {
   bucket  = "terraformtestproject-368119-cloud-app-terraform-state"
   prefix  = "terraform/state"
 }
}