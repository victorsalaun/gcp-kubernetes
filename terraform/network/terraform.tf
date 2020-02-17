terraform {
  backend "remote" {
    organization = "victorsalaun"

    workspaces {
      name = "gcp-kubernetes-network"
    }
  }

  required_version = ">=0.12.20"
}
