variable "network_cidr" {}
variable "network_name" {}

resource "google_compute_network" "network" {
  name                    = var.network_name
  project                 = var.gcp_project
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork" {
  name                     = var.network_name
  project                  = var.gcp_project
  ip_cidr_range            = var.network_cidr
  network                  = google_compute_network.network.self_link
  region                   = var.gcp_region
  private_ip_google_access = true
}

output "network_selflink" {
  value = google_compute_network.network.self_link
}

output "subnetwork_selflink" {
  value = google_compute_subnetwork.subnetwork.self_link
}