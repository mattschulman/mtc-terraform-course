output "clone-urls" {
  value = { for i in github_repository.mtc_repo : i.name => {
    ssh-clone-url  = i.ssh_clone_url,
    http-clone-url = i.http_clone_url,
    pages-url = try(i.pages[0].html_url, "no page")

    # Commented out when converted pages to a dynamic block
    # pages-url      = i.pages[0].html_url
    }
  }
  description = "Repository Names and URLs"
  sensitive   = false
}


#
# Used to demonstrate variable precedence
#
# output "varsource" {
#   value = var.varsource
#   description = "Source being used to source variable definition."
# }