variable "network_name" {}

resource "google_compute_network" "network" {
  name                    = var.network_name
  project                 = var.gcp_project
  auto_create_subnetworks = false
}
