variable "gcp_credentials_file" {}
variable "gcp_project" {}
variable "gcp_region" {}

provider "google" {
  credentials = file(var.gcp_credentials_file)
  project     = var.gcp_project
  region      = var.gcp_region
  version     = "3.8.0"
}
