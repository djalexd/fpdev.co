provider "digitalocean" {
  token = "${var.token}"
}

resource "digitalocean_tag" "docker_swarm_worker" {
  name = "docker_swarm_worker"
}