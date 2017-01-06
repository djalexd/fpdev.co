variable token {}

provider "digitalocean" {
  token = "${var.token}"
}

resource "digitalocean_ssh_key" "default" {
  name = "ssh access key"
  public_key = "${file("${path.module}/secrets/key1.pub")}"
}

output ssh_key_id {
  value = "${digitalocean_ssh_key.default.id}"
}