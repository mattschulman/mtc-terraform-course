terraform {
  required_providers {
    gitlab = {
      source  = "integrations/github"
      vversion = "~> 6.0"
    }
  }
}

# provider "gitlab" {
#   # Configuration options
# }