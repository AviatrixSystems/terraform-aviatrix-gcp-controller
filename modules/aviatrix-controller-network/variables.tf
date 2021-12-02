variable "network_name" {
  type = string
  description = "Name of the network to be created"
  default = "aviatrix-controller-network"
}

variable "subnet_name" {
  type = string
  description = "Name of the subnetwork to be created"
  default = "aviatrix-controller-subnetwork"
}

variable "subnet_cidr" {
  type = string
  description = "The cidr for the subnetwork this module will create or an existing subnet"
  default = "10.128.0.0/9"
}
