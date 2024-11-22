# --- root/main.tf ---

resource "kubernetes_deployment" "iotdep" {
  for_each = local.deployment
  metadata {
    name = "${each.key}-dep"
    labels = {
      app = "iotapp"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "iotapp"
      }
    }

    template {
      metadata {
        labels = {
          app = "iotapp"
        }
      }

      spec {
        container {
          image = each.value.image
          name  = "${each.key}-container"
          volume_mount {
            name       = "${each.key}-vol"
            mount_path = each.value.volumepath
          }
          port {
            container_port = each.value.int
            host_port      = each.value.ext
          }
        }
        volume {
          name = "${each.key}-vol"
          empty_dir {
            medium = ""
          }
        }
      }
    }
  }
}

# resource "kubernetes_deployment" "iotdep" {
#   metadata {
#     name = "iotdep"
#     labels = {
#       app = "iotapp"
#     }
#   }

#   spec {
#     replicas = 1

#     selector {
#       match_labels = {
#         app = "iotapp"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = "iotapp"
#         }
#       }

#       spec {
#         container {
#           image = "nodered/node-red:latest"
#           name  = "nodered-container"
#           volume_mount {
#             name       = "nodered-vol"
#             mount_path = "/data"
#           }
#           port {
#             container_port = 1880
#             host_port      = 8000
#           }
#         }
#         volume {
#           name = "nodered-vol"
#           empty_dir {
#             medium = ""
#           }
#         }
#       }
#     }
#   }
# }