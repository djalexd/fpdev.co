variable token  {}
variable domain { default = "fpdev.co" }
# Custom image with all the goodies baked in (mostly just package installs)
variable image  { default = "22001450" }
variable region { default = "ams3" }

# This is just a placeholder that will be updated later 
variable default_ip { default = "192.168.1.1" }

variable discovery_endpoint { default = "consul" }