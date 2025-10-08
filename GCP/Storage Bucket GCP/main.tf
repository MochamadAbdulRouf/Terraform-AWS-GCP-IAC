terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }

  backend "gcs" {
    bucket = ""PROJECT_ID"-tf-state"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = ""PROJECT_ID""
  region  = ""REGION""
}

resource "google_storage_bucket" "default" {
  name          = ""PROJECT_ID"-my-terraform-bucket"
  location      = ""REGION""
  force_destroy = true

  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}