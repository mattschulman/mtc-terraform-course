terraform {
  cloud {

    organization = "mattschulman"

    workspaces {
      name = "mtc-k8s"
    }
  }
}