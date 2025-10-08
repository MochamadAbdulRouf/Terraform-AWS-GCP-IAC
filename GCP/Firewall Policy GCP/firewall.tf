resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh-from-anywhere"
  network = "default"
  project = ""PROJECT_ID""

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh-allowed"]
}