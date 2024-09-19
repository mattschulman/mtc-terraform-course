terraform {
  required_providers {
    gitlab = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

# provider "gitlab" {
#   # Configuration options
# }