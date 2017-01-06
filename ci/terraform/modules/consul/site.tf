
provider "digitalocean" {
  token = "${var.token}"
}

resource "digitalocean_tag" "consul" {
  name = "consul"
}

resource "digitalocean_droplet" "consul" {
  image    = "${var.image}"
  name     = "consul-${format("%02d", count.index + 1)}"
  region   = "${var.region}"
  count    = "${var.count}"
  size     = "${var.size}"
  ssh_keys = ["${var.ssh_keys}"]
  tags     = ["${digitalocean_tag.consul.id}"]
  
  # Copy necessary files
  provisioner "file" {
    source      = "${path.module}/requirements.txt"
    destination = "/tmp/requirements.txt"
  }
  provisioner "file" {
    source = "${path.module}/playbook.yml"
    destination = "/tmp/playbook.yml"
  }
  
  # Run the provisioner
  provisioner "remote-exec" {
    inline = [
      "ansible-galaxy install -r /tmp/requirements.txt",
      "ansible-playbook /tmp/playbook.yml"
    ]
  } 
}

output "ip" {
  value = ["${digitalocean_droplet.consul.*.ipv4_address}"]
}