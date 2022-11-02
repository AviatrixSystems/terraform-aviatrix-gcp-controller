terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

module "aviatrix-controller-network" {
  count  = var.use_existing_network ? 0 : 1
  source = "./modules/aviatrix-controller-network"

  network_name = var.network_name
  subnet_name  = var.subnet_name
  subnet_cidr  = var.subnet_cidr
}

module "aviatrix-controller-ip-address" {
  source = "./modules/aviatrix-controller-ip-address"
  ip_address_name = var.ip_address_name
}

data "google_compute_network" "controller_network" {
  count = var.use_existing_network ? 1 : 0
  name  = var.network_name
}

data "google_compute_subnetwork" "controller_subnet" {
  count = var.use_existing_network ? 1 : 0
  name  = var.subnet_name
}

module "aviatrix-controller-build" {
  source = "./modules/aviatrix-controller-build"

  network                 = var.use_existing_network ? data.google_compute_network.controller_network[0].self_link : module.aviatrix-controller-network[0].network
  subnetwork              = var.use_existing_network ? data.google_compute_subnetwork.controller_subnet[0].self_link : module.aviatrix-controller-network[0].subnetwork
  public_ip               = module.aviatrix-controller-ip-address.public_ip
  image                   = var.image
  network_tags            = var.network_tags
  firewall_name           = var.firewall_name
  incoming_ssl_cidrs      = var.incoming_ssl_cidrs
  controller_name         = var.controller_name
  service_account_email   = var.service_account_email
  service_account_scopes  = var.service_account_scopes
  controller_machine_type = var.controller_machine_type
}

module "aviatrix-controller-initialize" {
  source = "./modules/aviatrix-controller-initialize"

  access_account_name                 = var.access_account_name
  aviatrix_customer_id                = var.aviatrix_customer_id
  avx_controller_admin_email          = var.aviatrix_controller_admin_email
  avx_controller_admin_password       = var.aviatrix_controller_admin_password
  avx_controller_private_ip           = module.aviatrix-controller-build.private_ip
  avx_controller_public_ip            = module.aviatrix-controller-build.public_ip
  gcloud_project_credentials_filepath = var.gcloud_project_credentials_filepath
  controller_version                  = var.controller_version

  depends_on = [module.aviatrix-controller-build]
}
