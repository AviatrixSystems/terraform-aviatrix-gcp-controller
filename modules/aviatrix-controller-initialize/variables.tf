variable "avx_controller_public_ip" {
  type        = string
  description = "aviatrix controller public ip address(required)"
}

variable "avx_controller_private_ip" {
  type        = string
  description = "aviatrix controller private ip address(required)"
}

variable "avx_controller_admin_email" {
  type        = string
  description = "aviatrix controller admin email address"
}

variable "avx_controller_admin_password" {
  type        = string
  description = "aviatrix controller admin password"
}

variable "gcloud_project_credentials_filepath" {
  type        = string
  description = "Google Cloud project credentials filepath"
}

variable "access_account_name" {
  type        = string
  description = "aviatrix controller access account name"
}

variable "controller_version" {
  type        = string
  description = "Aviatrix Controller version"
  default     = "latest"
}

variable "aviatrix_customer_id" {
  type        = string
  description = "aviatrix customer license id"
}
