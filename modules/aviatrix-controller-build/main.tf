resource "google_compute_instance" "controller" {
  name = var.controller_name
  machine_type = var.controller_machine_type

  boot_disk {
    initialize_params {
      image = "aviatrix-public/avx-controller-gcp-2021-05-05"
    }
  }

  service_account {
    email = var.service_account_email
    scopes = var.service_account_scopes
  }

  network_interface {
    network = var.network
    subnetwork = var.subnetwork

    access_config {
      nat_ip = var.public_ip
    }
  }
}

resource "google_compute_firewall" "controller_firewall" {
  name = "aviatrix-controller-firewall"
  network = var.network

  source_ranges = var.incoming_ssl_cidrs

  allow {
    protocol = "tcp"
    ports = ["443"]
  }
}
