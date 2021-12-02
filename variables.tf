variable "access_account_name" {
  type = string
  description = "Name of the access account to create on the Aviatrix Controller"
}

variable "aviatrix_controller_admin_email" {
  type = string
  description = "Aviatrix Controller admin email address"
}

variable "aviatrix_controller_admin_password" {
  type = string
  description = "Aviatrix Controller admin password"
}

variable "aviatrix_customer_id" {
  type = string
  description = "Customer license ID to initialize the Aviatrix Controller with"
}

variable "controller_machine_type" {
  type = string
  description = "The machine type to create the Aviatrix Controller"
  default = "e2-standard-2"
}

variable "controller_name" {
  type = string
  description = "The Aviatrix Controller name"
  default = "aviatrix-controller"
}

variable "controller_version" {
  type        = string
  description = "Aviatrix Controller version"
  default     = "latest"
}

variable "gcloud_project_credentials_filepath" {
  type        = string
  description = "Google Cloud project credentials filepath"
}

variable incoming_ssl_cidrs {
  type = list(string)
  description = "The CIDRs to be allowed for HTTPS(port 443) access to the Aviatrix Controller"
}

variable "network_name" {
  type = string
  description = "Name of the network to be created"
  default = "aviatrix-controller-network"
}

variable "service_account_email" {
  type = string
  description = "The Service Account to assign to the Aviatrix Controller"
  default = ""
}

variable "service_account_scopes" {
  type = list(string)
  description = "The scopes to assign to the Aviatrix Controller's Service Account"
  default = ["cloud-platform"]
}

variable "subnet_cidr" {
  type = string
  description = "The CIDR for the subnetwork this module will create"
  default = "10.128.0.0/9"
}

variable "subnet_name" {
  type = string
  description = "Name of the subnetwork to be created"
  default = "aviatrix-controller-subnetwork"
}
