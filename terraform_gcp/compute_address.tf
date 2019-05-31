resource "google_compute_address" "kumaya-ip" {
  name = "kumaya-ip"
  region = "${var.region}"
}