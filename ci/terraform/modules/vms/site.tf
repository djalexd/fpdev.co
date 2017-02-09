
provider "digitalocean" {
  token = "${var.token}"
}

resource "digitalocean_tag" "docker_engine" {
  name = "docker_engine"
}

resource "digitalocean_tag" "docker_swarm_manager" {
  name = "docker_swarm_manager"
}

resource "digitalocean_tag" "docker_swarm_worker" {
  name = "docker_swarm_worker"
}

resource "digitalocean_droplet" "docker_swarm_manager" {
  image    = "${var.image}"
  name     = "docker-swarm-manager-${format("%02d", count.index + 1)}"
  region   = "${var.region}"
  count    = "${lookup(var.counts, "docker_swarm_manager")}"
  size     = "${lookup(var.sizes, "docker_swarm_manager")}"
  ssh_keys = ["${var.ssh_keys}"]
  tags     = ["${digitalocean_tag.docker_swarm_manager.id}", "${digitalocean_tag.docker_engine.id}"]
}

resource "digitalocean_droplet" "docker_swarm_worker" {
  image    = "${var.image}"
  name     = "docker-swarm-worker-${format("%02d", count.index + 1)}"
  region   = "${var.region}"
  count    = "${lookup(var.counts, "docker_swarm_worker")}"
  size     = "${lookup(var.sizes, "docker_swarm_worker")}"
  ssh_keys = ["${var.ssh_keys}"]
  tags     = ["${digitalocean_tag.docker_swarm_worker.id}", "${digitalocean_tag.docker_engine.id}"]
}

output "ip" {
  value = {
    managers = ["${digitalocean_droplet.docker_swarm_manager.*.ipv4_address}"]
    workers = ["${digitalocean_droplet.docker_swarm_worker.*.ipv4_address}"]
  }
}