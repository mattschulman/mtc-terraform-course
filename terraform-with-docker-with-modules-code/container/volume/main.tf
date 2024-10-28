resource "docker_volume" "container_volume" {
  # count = var.count_in
  # count = length(var.volumes_in)
  count = var.volume_count
  # name  = "${var.name_in}-${random_string.random[count.index].result}-volume"
  # name = "${var.name_in}-${count.index}-volume"
  name = "${var.volume_name}-${count.index}"


  lifecycle {
    prevent_destroy = false
  }

  #
  # This does not work on MacOS/Windows using Docker Desktop since the containers are running an a VM
  #
  #   provisioner "local-exec" {
  #     when = destroy
  #     command = "mkdir ${path.cwd}/../backup/"
  #     on_failure = continue
  #   }

  #   provisioner "local-exec" {
  #     when = destroy
  #     command = "sudo tar -czvf ${path.cwd}/../backup/${self.name}.tar.gz ${self.mountpoint}/"
  #     on_failure = fail
  #   }
}