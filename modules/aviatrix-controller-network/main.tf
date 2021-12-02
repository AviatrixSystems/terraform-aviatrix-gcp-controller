resource "google_compute_network" "controller_network" {
  name = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "controller_subnet" {
  name = var.subnet_name
  network = google_compute_network.controller_network.self_link
  ip_cidr_range = var.subnet_cidr
}
