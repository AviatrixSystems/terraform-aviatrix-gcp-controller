resource "google_compute_instance" "controller" {
  name         = var.controller_name
  machine_type = var.controller_machine_type
  tags         = var.network_tags

  boot_disk {
    initialize_params {
      image = var.image == "" ? jsondecode(data.http.image_info.response_body)["BYOL"] : var.image
    }
  }

  service_account {
    email  = var.service_account_email
    scopes = var.service_account_scopes
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork

    access_config {
      nat_ip = var.public_ip
    }
  }
}

resource "google_compute_firewall" "controller_firewall" {
  name          = var.firewall_name
  network       = var.network
  target_tags   = google_compute_instance.controller.tags
  source_ranges = var.incoming_ssl_cidrs

  allow {
    protocol = "tcp"
    ports = ["443"]
  }
}

data "http" "image_info" {
  url = "https://cdn.prod.sre.aviatrix.com/image-details/gcp_controller_image_details.json"

  request_headers = {
    "Accept" = "application/json"
  }
}
