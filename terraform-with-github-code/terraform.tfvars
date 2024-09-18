repo_max = 2
env      = "dev"

#
# Convert repos to a map so that we can have different files created in a repo depending on the repo type
# repos    = ["infra", "backend"]

repos = {
  infra = {
    lang     = "terraform",
    filename = "main.tf",
    pages = true
  },
  backend = {
    lang     = "python",
    filename = "main.py",
    pages = false
  }
}

#
## Was need to demonstrate variable precedence
# varsource = "terraform.tfvars"