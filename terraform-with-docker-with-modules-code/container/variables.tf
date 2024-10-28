variable "name_in" {
  description = "Name of Container"
}

variable "image_in" {
  description = "Name of Image"
}

variable "int_port_in" {
  description = "List of Internal Ports"
}

variable "ext_port_in" {
  description = "List of External Ports"
}

# variable "container_path_in" {
#   description = "Path for container data"
# }

variable "count_in" {
  description = "Number of containers to create"
}

variable "volumes_in" {
  description = "Volume paths"
}

# variable "host_path_in" {
#   description = "Path to local data dir for container"
# }