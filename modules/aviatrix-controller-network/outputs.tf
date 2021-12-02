output "network" {
  value = google_compute_network.controller_network.self_link
}

output "subnetwork" {
  value = google_compute_subnetwork.controller_subnet.self_link
}