resource "google_compute_route" "public-route" {
  name        = "public-route"
  region = "${var.region}"
  network     = "${google_compute_network.kumaya-vpc.name}"
  dest_range  = "0.0.0.0/0"
  next_hop_gateway = "default-internet-gateway"
  
  priority    = 100
}

resource "google_compute_route" "private-route" {
  name        = "private-route"
  region = "${var.region}"
  network     = "${google_compute_network.kumaya-vpc.name}"
  dest_range  = "0.0.0.0/0"
  #NAT랑 연결?
  priority    = 100
}

resource "google_compute_router_nat" "kumaya-nat" {
  name                               = "kumaya-nat"
  router                             = "${google_compute_router.private-route.name}"
  region = "${var.region}"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}