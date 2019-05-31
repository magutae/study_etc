resource "google_compute_instance" "kumaya-public-instance" {
  name         = "kumaya-public-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "${var.compute_instance_image}"
      size = "30"
    }
  }

  network_interface {
    network       = "${google_compute_network.kumaya-vpc.name}"
    subnetwork = "${google_compute_subnetwork.kumaya-public-subnet.name}"

    access_config {
      nat_ip = "${google_compute_address.kumaya-ip.address}"
    }
  }

}

resource "google_compute_instance" "kumaya-private-instance" {
  name         = "kumaya-private-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "${var.compute_instance_image}"
      size = "30"
    }
  }

  network_interface {
    network       = "${google_compute_network.kumaya-vpc.name}"
    subnetwork = "${google_compute_subnetwork.kumaya-private-subnet.name}"
  }

}