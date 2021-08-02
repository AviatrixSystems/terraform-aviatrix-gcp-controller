output "aviatrix_controller_public_ip" {
  value = google_compute_instance.controller.network_interface[0].access_config[0].nat_ip
}

output "aviatrix_controller_private_ip" {
  value = google_compute_instance.controller.network_interface[0].network_ip
}