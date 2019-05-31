resource "google_compute_firewall" "kumaya-firewall" {
  name    = "kumaya-firewall"
  network = "${google_compute_network.kumaya-vpc.name}"

  allow {
    protocol = "tcp"
    ports    = [22]
  }
}