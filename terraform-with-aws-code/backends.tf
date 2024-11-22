terraform {
  cloud {

    organization = "mattschulman"

    workspaces {
      name = "mtc-dev"
    }
  }
}