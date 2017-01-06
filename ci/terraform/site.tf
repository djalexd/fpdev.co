# Make sure SSH key was added
module "ssh" {
  source = "./modules/ssh"
  token  = "${var.token}"
}

module "dns" "default" {
  source     = "./modules/dns"

  token      = "${var.token}"
  domain     = "${var.domain}"
  ip         = "${var.default_ip}"
}

module "consul" "default" {
  source   = "./modules/consul"
  token    = "${var.token}"
  image    = "${var.image}"
  region   = "${var.region}"
  ssh_keys = ["${module.ssh.ssh_key_id}"]
}

module "dns_subdomain_consul" "consul" {
  source     = "./modules/dns_subdomain"

  token     = "${var.token}"
  domain    = "${var.domain}"
  subdomain = "${var.discovery_endpoint}"
  ip         = "${element(module.consul.ip, 0)}"
}

module "lb" "default" {
  source   = "./modules/lb"
  token    = "${var.token}"
  image    = "${var.image}"
  region   = "${var.region}"
  ssh_keys = ["${module.ssh.ssh_key_id}"]
}

module "dns_subdomain_dev" "dev" {
  source     = "./modules/dns_subdomain"

  token     = "${var.token}"
  domain    = "${var.domain}"
  subdomain = "dev"
  ip         = "${module.lb.ip}"
}