terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
  backend "gcs" {
    bucket = "qwiklabs-gcp-04-a2b5fba15c7d-tf-state"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = "qwiklabs-gcp-04-a2b5fba15c7d"
  region  = "us-west1"
}

resource "google_firestore_database" "default" {
  name     = "default"
  project  = "qwiklabs-gcp-04-a2b5fba15c7d"
  location_id = "nam5"
  type     = "FIRESTORE_NATIVE"
}

output "firestore_database_name" {
  value       = google_firestore_database.default.name
  description = "The name of the Cloud Firestore database."
}