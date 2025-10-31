provider "google" {
  project     = "PROJECT_ID" # Replace it with your Project ID
  region      = "us-central1"
}

terraform {
  backend "gcs" {
    bucket = "PROJECT_ID"
    prefix = "terraform/state"
  }
}

resource "google_storage_bucket" "test-bucket-for-state" {
  name        = "PROJECT_ID"
  location    = "US"
  uniform_bucket_level_access = true
  # force_destroy = true 
}

