#
# Commented out when switching from count to for_each
#
# resource "random_id" "random" {
#   byte_length = 2
#   count       = var.repo_count
# }
#
# resource "github_repository" "mtc_repo" {
#   #count       = var.repo_count
#   name        = "mtc-repo-${random_id.random[count.index].dec}"
#   description = "Code for MTC"
#   visibility  = var.env == "dev" ? "private" : "public"
#   auto_init   = true
# }

#
# Commented out when converting repos var to a map
#
resource "github_repository" "mtc_repo" {
  for_each = var.repos
  name     = "mtc-repo-${each.key}"
  # description = "${each.value} Code for MTC"
  description = "${each.value.lang} Code for MTC"
  visibility  = var.env == "dev" ? "public" : "private"
  auto_init   = true
  dynamic "pages" {
    for_each = each.value.pages ? [1] : []
    content {
      source {
        branch = "main"
        path   = "/"
      }
    }
  }

  provisioner "local-exec" {
    command = "gh repo view ${self.name} --web"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -rf ${self.name}"
  }
}


resource "terraform_data" "repo-clone" {
  depends_on = [github_repository_file.main, github_repository_file.readme]

  for_each = var.repos
  provisioner "local-exec" {
    command = "gh repo clone ${github_repository.mtc_repo[each.key].name}"
  }
}

#
# Commented out when switching from count to for_each
#
# resource "github_repository_file" "readme" {
#   count               = var.repo_count
#   repository          = github_repository.mtc_repo[count.index].name
#   branch              = "main"
#   file                = "README.md"
#   content             = "# This ${var.env} repository is for infra developers."
#   overwrite_on_create = true
# }

# resource "github_repository_file" "index_html" {
#   count               = var.repo_count
#   repository          = github_repository.mtc_repo[count.index].name
#   branch              = "main"
#   file                = "index.html"
#   content             = "Hello Terraform!"
#   overwrite_on_create = true
# }

resource "github_repository_file" "readme" {
  for_each   = var.repos
  repository = github_repository.mtc_repo[each.key].name
  branch     = "main"
  file       = "README.md"
  content = templatefile("templates/readme.tftpl", {
    env        = var.env,
    lang       = each.value.lang,
    repo       = each.key
    authorname = data.github_user.current.name
  })

  #
  # Commented out when converting from a heredoc string to a template file
  #
  # content             = <<-EOT
  #                       # This ${var.env} ${each.value.lang} repository is for ${each.key} developers. 
  #                       Last modified by: ${data.github_user.current.name}.
  #                       EOT

  overwrite_on_create = true

  # lifecycle {
  #   ignore_changes = [
  #     content,
  #   ]
  # }
}

resource "github_repository_file" "main" {
  for_each            = var.repos
  repository          = github_repository.mtc_repo[each.key].name
  branch              = "main"
  file                = each.value.filename
  content             = "# Hello ${each.value.lang}!"
  overwrite_on_create = true

  lifecycle {
    ignore_changes = [
      content,
    ]
  }
}

#
# Commented out after the index file was renamed to main and applied.  After that it is no longer needed
#
# moved {
#   from = github_repository_file.index
#   to   = github_repository_file.main
# }