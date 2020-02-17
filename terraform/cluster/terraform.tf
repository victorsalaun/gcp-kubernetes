terraform {
  backend "remote" {
    organization = "victorsalaun"

    workspaces {
      name = "gcp-kubernetes-cluster"
    }
  }

  required_version = ">=0.12.20"
}

data "terraform_remote_state" "network" {
  backend = "remote"
  config  = {
    organization = "victorsalaun"
    workspaces   = {
      name = "gcp-kubernetes-network"
    }
  }
}
