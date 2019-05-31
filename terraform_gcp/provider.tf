provider "google" {
  project = "kumaya-terraform-test"
  credentials = "${file("kumaya-terraform-test.json")}"
  region      = "${var.region}"
  zone        = "${var.zone}"
}