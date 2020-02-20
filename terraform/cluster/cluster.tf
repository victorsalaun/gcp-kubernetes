variable "cluster_name" {}
variable "cluster_location" {}

variable "cluster_node_admin_count" {}
variable "cluster_node_admin_machine_type" {}
variable "cluster_node_admin_name" {}
variable "cluster_node_admin_max_node_count" {}
variable "cluster_node_admin_min_node_count" {}

variable "cluster_node_default_count" {}
variable "cluster_node_default_machine_type" {}
variable "cluster_node_default_name" {}
variable "cluster_node_default_max_node_count" {}
variable "cluster_node_default_min_node_count" {}

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

  enable_legacy_abac = false

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "cluster_node_admin" {
  name     = var.cluster_node_admin_name
  cluster  = google_container_cluster.cluster.name
  location = google_container_cluster.cluster.location

  node_count = var.cluster_node_admin_count

  autoscaling {
    min_node_count = var.cluster_node_admin_min_node_count
    max_node_count = var.cluster_node_admin_max_node_count
  }

  management {
    auto_upgrade = false
    auto_repair  = true
  }

  node_config {
    preemptible  = false
    machine_type = var.cluster_node_admin_machine_type

    labels = {
      "node-role.kubernetes.io/${var.cluster_node_admin_name}" = var.cluster_node_admin_name
    }

    taint {
      key    = "ProtectedNodes"
      value  = "AdminNodes"
      effect = "NO_SCHEDULE"
    }
  }
}

resource "google_container_node_pool" "cluster_node_default" {
  name     = var.cluster_node_default_name
  cluster  = google_container_cluster.cluster.name
  location = google_container_cluster.cluster.location

  node_count = var.cluster_node_default_count

  autoscaling {
    min_node_count = var.cluster_node_default_min_node_count
    max_node_count = var.cluster_node_default_max_node_count
  }

  management {
    auto_upgrade = true
    auto_repair  = true
  }

  node_config {
    preemptible  = true
    machine_type = var.cluster_node_default_machine_type

    labels = {
      "node-role.kubernetes.io/${var.cluster_node_default_name}" = var.cluster_node_default_name
    }
  }
}

output "cluster_name" {
  value = google_container_cluster.cluster.name
}

output "cluster_region" {
  value = google_container_cluster.cluster.region
}

output "cluuster_endpoint" {
  value = google_container_cluster.cluster.endpoint
}

output "cluster_node_version" {
  value = google_container_cluster.cluster.node_version
}
