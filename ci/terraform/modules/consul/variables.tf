variable token  {}
variable image  {}
variable region {}
variable size   { default = "512mb" }
# How many instances of consul agent in server mode
# do we plan to run?
variable count  { default = 1 }
variable ssh_keys { 
  type = "list"
  default = [] 
}