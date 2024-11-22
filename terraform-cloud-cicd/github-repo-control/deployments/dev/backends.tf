terraform {
  backend "remote" {
    organization = "mattschulman"

    workspaces {
      name = "mtc-dev-repo"
    }
  }
}