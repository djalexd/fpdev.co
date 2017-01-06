variable token    {}
variable image    {}
variable region   {}
variable size     { 
  default = "512mb" 
}
variable ssh_keys {
  type = "list"
  default = []
}