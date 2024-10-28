resource "random_string" "random" {
  count = var.count_in
  # for_each = local.deployment
  length  = 4
  special = false
  upper   = false
}

# resource "random_string" "random" {
#   count   = local.container_count
#   length  = 4
#   special = false
#   upper   = false
# }

resource "docker_container" "app_container" {
  count = var.count_in
  # name  = var.name_in
  name  = join("-", [var.name_in, terraform.workspace, random_string.random[count.index].result])
  image = var.image_in

  ports {
    internal = var.int_port_in
    external = var.ext_port_in[count.index]
  }

  # volumes {
  #   container_path = var.container_path_in
  #   volume_name    = docker_volume.container_volume[count.index].name
  # }

  dynamic "volumes" {
    for_each = var.volumes_in
    content {
      container_path = volumes.value["container_path_each"]
      # volume_name    = docker_volume.container_volume[volumes.key].name
      volume_name = module.volume[count.index].volume_output[volumes.key]
    }
  }

  provisioner "local-exec" {
    command = "echo ${self.name}: ${self.network_data.0.ip_address}:${join("", [for x in self.ports[*]["external"] : x])} >> containers.txt"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -f containers.txt"
  }

  lifecycle {
    # ignore_changes = [command, cpu_shares, dns, dns_opts, dns_search, entrypoint, env, group_add, 
    #   hostname, id, ipc_mode, log_opts, max_retry_count, memory, memory_swap, network_mode, privileged, 
    #   publish_all_ports, shm_size, sysctls, tmpfs, user, working_dir, healthcheck, labels, ports, image]    
    ignore_changes = [image, network_mode]
  }
}

module "volume" {
  source       = "./volume"
  count        = var.count_in
  volume_count = length(var.volumes_in)
  volume_name  = "${var.name_in}-${terraform.workspace}-${random_string.random[count.index].result}-volume"
}


# resource "docker_volume" "container_volume" {
#   # count = var.count_in
#   count = length(var.volumes_in)
#   # name  = "${var.name_in}-${random_string.random[count.index].result}-volume"
#   name = "${var.name_in}-${count.index}-volume"


#   lifecycle {
#     prevent_destroy = false
#   }

#   #
#   # This does not work on MacOS/Windows using Docker Desktop since the containers are running an a VM
#   #
#   #   provisioner "local-exec" {
#   #     when = destroy
#   #     command = "mkdir ${path.cwd}/../backup/"
#   #     on_failure = continue
#   #   }

#   #   provisioner "local-exec" {
#   #     when = destroy
#   #     command = "sudo tar -czvf ${path.cwd}/../backup/${self.name}.tar.gz ${self.mountpoint}/"
#   #     on_failure = fail
#   #   }
# }