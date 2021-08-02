resource "google_compute_image" "i" {
  count = var.aviatrix_controller_image == "" ? 1 : 0
  name = "aviatrix-controller-image"

  raw_disk {
    source = "https://storage.googleapis.com/aviatrix300/aviatrix-cloud-services-gateway-032020-byol.tar.gz"
  }
}

resource "google_compute_instance" "controller" {
  name = "aviatrix-controller"
  machine_type = "e2-standard-2"

  boot_disk {
    initialize_params {
      image = var.aviatrix_controller_image == "" ? google_compute_image.i[0].self_link : var.aviatrix_controller_image
    }
  }

  service_account {
    scopes = ["cloud-platform"]
  }

  network_interface {
    network = var.aviatrix_controller_network == "" ? google_compute_network.controller_network[0].self_link : var.aviatrix_controller_network

    access_config {
      nat_ip = google_compute_address.ip_address.address
    }
  }
}

resource "google_compute_network" "controller_network" {
  count = var.aviatrix_controller_network == "" ? 1 : 0
  name = "aviatrix-controller-network"
}

resource "google_compute_firewall" "controller_firewall" {
  count = var.aviatrix_controller_network == "" ? 1 : 0
  name = "aviatrix-controller-firewall"
  network = google_compute_network.controller_network[0].self_link

  allow {
    protocol = "tcp"
    ports = ["443"]
  }
}

resource "google_compute_address" "ip_address" {
  name = "aviatrix-controller-address"
  address_type = "EXTERNAL"
}

output "public_ip" {
  value = google_compute_instance.controller.network_interface[0].access_config[0].nat_ip
}

output "private_ip" {
  value = google_compute_instance.controller.network_interface[0].network_ip
}