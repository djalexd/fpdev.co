variable "do_token" {}

variable "image" {
    default = "ubuntu-16-04-x64"
}

variable "region" {
    description = "Region where this cluster is managed"
}

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

provider "digitalocean" {
    token = "${var.do_token}"
}

resource "digitalocean_ssh_key" "default" {
    name = "ssh access key"
    public_key = "${file("./secrets/key1.pub")}"
}

resource "digitalocean_tag" "docker-engine" {
    name = "docker_engine"
}

resource "digitalocean_tag" "swarm-master" {
    name = "docker_swarm_manager"
}

resource "digitalocean_tag" "swarm-worker" {
    name = "docker_swarm_worker"
}

resource "digitalocean_droplet" "swarm-master" {
    image    = "${var.image}"
    name     = "swarm-master-${format("%02d", count.index + 1)}"
    region   = "${var.region}"
    count    = "${lookup(var.counts, "swarm-master")}"
    size     = "${lookup(var.sizes, "swarm-master")}"
    ssh_keys = ["${digitalocean_ssh_key.default.id}"]
    tags     = ["${digitalocean_tag.swarm-master.id}", "${digitalocean_tag.docker-engine.id}"]
}

resource "digitalocean_droplet" "swarm-worker" {
    image    = "${var.image}"
    name     = "swarm-worker-${format("%02d", count.index + 1)}"
    region   = "${var.region}"
    count    = "${lookup(var.counts, "swarm-worker")}"
    size     = "${lookup(var.sizes, "swarm-worker")}"
    ssh_keys = ["${digitalocean_ssh_key.default.id}"]
    tags     = ["${digitalocean_tag.swarm-worker.id}", "${digitalocean_tag.docker-engine.id}"]
}

output "swarm_ip" {
    value = {
        masters = ["${digitalocean_droplet.swarm-master.*.ipv4_address}"]
        workers = ["${digitalocean_droplet.swarm-worker.*.ipv4_address}"]
    }
}