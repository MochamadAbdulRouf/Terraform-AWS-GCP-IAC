resource "google_compute_instance" "default" {
    project = "qwiklabs-gcp-00-7a33fa0d060a"
    zone = "europe-west1-c"
    name = "terraform"
    machine_type = "e2-medium"
    boot_disk {
      initialize_params {
        image = "debian-cloud/debian-12"
      }
    }
    network_interface {
      network = "default"
    }
}