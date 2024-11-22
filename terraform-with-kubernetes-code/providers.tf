locals {
  config = data.terraform_remote_state.kubeconfig.outputs.kubeconfig
}

terraform {
  required_providers {
    kubernetes = {
      source = "kubernetes"
    }
  }
}

provider "kubernetes" {
  # config_path = "../k3s-mtc_node-57902.yaml"
  config_path = split("=",local.config[0])[1]
}