variable "gcp_project" {}
variable "gcp_region" {}

provider "google" {
  credentials = file("../CREDENTIALS_FILE.json")
  project     = var.gcp_project
  region      = var.gcp_region
  version     = "3.8.0"
}
