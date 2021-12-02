resource "google_compute_address" "ip_address" {
  name = var.ip_address_name
  address_type = "EXTERNAL"
}