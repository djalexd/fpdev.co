variable domain     {}
variable subdomain  {}
variable ip         {}
variable token      {}

provider "digitalocean" {
    token = "${var.token}"
}

resource "digitalocean_record" "default" {
    domain = "${var.domain}"
    type = "A"
    name = "${var.subdomain}"
    value = "${var.ip}"
}