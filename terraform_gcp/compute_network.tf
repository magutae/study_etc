resource "google_compute_network" "kumaya-vpc" {
  name                    = "kumaya-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "kumaya-public-subnet" {
  name   = "kumaya-public-subnet"
  region = "${var.region}"
  ip_cidr_range = "10.0.1.0/24"
  network = "${google_compute_network.kumaya-vpc.name}"
}

resource "google_compute_subnetwork" "kumaya-private-subnet" {
  name   = "kumaya-private-subnet"
  region = "${var.region}"
  ip_cidr_range = "10.0.101.0/24"
  private_ip_google_access = true
  network = "${google_compute_network.kumaya-vpc.name}"
}