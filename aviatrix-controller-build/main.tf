resource "google_compute_image" "controller_image" {
  count = var.image == "" ? 1 : 0
  name = "aviatrix-controller-image"

  raw_disk {
    source = "https://storage.googleapis.com/aviatrix300/aviatrix-cloud-services-gateway-032020-byol.tar.gz"
  }
}

resource "google_compute_instance" "controller" {
  name = var.controller_name
  machine_type = var.controller_machine_type

  boot_disk {
    initialize_params {
      image = var.image == "" ? google_compute_image.controller_image[0].self_link : var.image
    }
  }

  service_account {
    email = var.service_account_email
    scopes = var.service_account_scopes
  }

  network_interface {
    network = var.network
    subnetwork = var.network == "" ? google_compute_subnetwork.controller_subnet[0].self_link : var.subnetwork

    access_config {
      nat_ip = var.public_ip == "" ? google_compute_address.ip_address[0].address : var.public_ip
    }
  }
}

resource "google_compute_network" "controller_network" {
  count = var.network == "" ? 1 : 0
  name = "aviatrix-controller-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "controller_subnet" {
  count = var.network == "" ? 1 : 0
  name = "aviatrix-controller-subnetwork"
  network = google_compute_network.controller_network[0].self_link
  ip_cidr_range = var.subnet_cidr
}

resource "google_compute_firewall" "controller_firewall" {
  name = "aviatrix-controller-firewall"
  network = var.network == "" ? google_compute_network.controller_network[0].self_link : var.network

  source_ranges = var.incoming_ssl_cidrs

  allow {
    protocol = "tcp"
    ports = ["443"]
  }
}

resource "google_compute_address" "ip_address" {
  count = var.public_ip == "" ? 1 : 0

  name = "aviatrix-controller-address"
  address_type = "EXTERNAL"
}