variable "token"  {}
variable "image"  {}
variable "region" {}

variable "counts" {
  type = "map"
  default = {
    swarm-master = "1"
    swarm-worker = "1"
  }
}

variable "sizes" {
  type = "map"
  default = {
    swarm-master = "512mb"
    swarm-worker = "1gb"
  }
}

variable ssh_keys {
  type = "list"
  default = []
}