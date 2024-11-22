data "terraform_remote_state" "kubeconfig" {
  backend = "remote"
  
  config = {
    organization = "mattschulman"
    workspaces = {
      name = "mtc-dev"
    }
  }
}