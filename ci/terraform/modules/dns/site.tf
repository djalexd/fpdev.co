variable domain {}
variable ip     {}
variable token  {}

provider "digitalocean" {
    token = "${var.token}"
}

resource "digitalocean_domain" "default" {
    name = "${var.domain}"
    ip_address = "${var.ip}"
}

output "registered_domain" {
    value = "${digitalocean_domain.default.id}"
}