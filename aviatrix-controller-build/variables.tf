variable "image" {
  type = string
  description = "The Google compute image to build the Aviatrix Controller"
  default = ""
}

variable "network" {
  type = string
  description = "The network to attach to the Aviatrix Controller"
  default = ""
}

variable "public_ip" {
  type = string
  description = "The public IP address to assign to the controller"
  default = ""
}

variable "controller_name" {
  type = string
  description = "The Aviatrix Controller name"
  default = "aviatrix-controller"
}