resource "null_resource" "dockervol" {
  provisioner "local-exec" {
    command = "mkdir noderedvol/ || true && sudo chown -R 1000:1000 noderedvol/"
    # command = "mkdir noderedvol/ || true"
  }
}

resource "docker_image" "nodered_image" {
  # name = "nodered/node-red:latest"
  # name = lookup(var.image, var.env)
  # name = lookup(var.image, terraform.workspace)
  name = var.image[terraform.workspace]
}

resource "random_string" "random" {
  count   = local.container_count
  length  = 4
  special = false
  upper   = false
}

# resource "docker_volume" "nodered_volume" {
#   count = local.container_count
#   name = join("-", ["nodered-vol", random_string.random[count.index].result])
#   lifecycle {
#     # prevent_destroy = true
#   }
# }

resource "docker_container" "nodered_container" {
  count = local.container_count
  # name  = join("-", ["nodered", random_string.random[count.index].result])
  name  = join("-", ["nodered", terraform.workspace, random_string.random[count.index].result])
  image = docker_image.nodered_image.name

  ports {
    internal = var.int_port
    # external = var.ext_port[count.index]
    # external = lookup(var.ext_port, var.env)[count.index]
    # external = lookup(var.ext_port, terraform.workspace)[count.index]
    external = var.ext_port[terraform.workspace][count.index]
  }

  volumes {
    container_path = "/home/data"
    # volume_name = join("-", ["docker_volume.nodered-vol",random_string.random[count.index].result])
    host_path = "${path.cwd}/noderedvol"
  }

  lifecycle {
    # ignore_changes = [command, cpu_shares, dns, dns_opts, dns_search, entrypoint, env, group_add, 
    #   hostname, id, ipc_mode, log_opts, max_retry_count, memory, memory_swap, network_mode, privileged, 
    #   publish_all_ports, shm_size, sysctls, tmpfs, user, working_dir, healthcheck, labels, ports, image]
    
    ignore_changes = [image, network_mode]

  }
}

