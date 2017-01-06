
provider "digitalocean" {
  token = "${var.token}"
}

resource "digitalocean_tag" "nginx" {
  name = "nginx"
}

resource "digitalocean_droplet" "nginx" {
  image    = "${var.image}"
  name     = "nginx-01"
  region   = "${var.region}"
  count    = "1"
  size     = "${var.size}"
  ssh_keys = ["${var.ssh_keys}"]
  tags     = ["${digitalocean_tag.nginx.id}"]
  
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
  value = "${digitalocean_droplet.nginx.ipv4_address}"
}