variable "cluster_name" {}
variable "cluster_location" {}

variable "cluster_node_one_count" {}
variable "cluster_node_one_machine_type" {}
variable "cluster_node_one_name" {}

data "google_container_engine_versions" "gce_version_location" {
  location = var.cluster_location
}

resource "google_container_cluster" "cluster" {
  name     = var.cluster_name
  location = var.cluster_location

  min_master_version = data.google_container_engine_versions.gce_version_location.latest_master_version
  node_version       = data.google_container_engine_versions.gce_version_location.latest_master_version

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = data.terraform_remote_state.network.outputs.network_selflink
  subnetwork = data.terraform_remote_state.network.outputs.subnetwork_selflink

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "cluster_node_one" {
  name     = var.cluster_node_one_name
  cluster  = google_container_cluster.cluster.name
  location = google_container_cluster.cluster.location

  node_count = var.cluster_node_one_count

  node_config {
    preemptible  = true
    machine_type = var.cluster_node_one_machine_type
  }
}
