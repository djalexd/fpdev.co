variable "token"  {}
variable "image"  {}
variable "region" {}

variable "counts" {
  type = "map"
  default = {
    docker_swarm_manager = "1"
    docker_swarm_worker  = "1"
  }
}

variable "sizes" {
  type = "map"
  default = {
    docker_swarm_manager = "512mb"
    docker_swarm_worker  = "1gb"
  }
}

variable ssh_keys {
  type = "list"
  default = []
}