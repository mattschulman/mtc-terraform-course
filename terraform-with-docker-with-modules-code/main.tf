module "image" {
  source   = "./image"
  for_each = local.deployment
  image_in = each.value.image
}

module "container" {
  source      = "./container"
  count_in    = each.value.container_count
  for_each    = local.deployment
  name_in     = each.key
  image_in    = module.image[each.key].image_out
  int_port_in = each.value.int
  ext_port_in = each.value.ext
  # container_path_in = each.value.container_path
  volumes_in = each.value.volumes
}

# module "container" {
#   source            = "./container"
#   count             = local.container_count
#   name_in           = join("-", ["nodered", terraform.workspace, random_string.random[count.index].result])
#   image_in          = module.image["nodered"].image_out
#   int_port_in       = var.int_port
#   ext_port_in       = var.ext_port[terraform.workspace][count.index]
#   container_path_in = "/data"
# }

