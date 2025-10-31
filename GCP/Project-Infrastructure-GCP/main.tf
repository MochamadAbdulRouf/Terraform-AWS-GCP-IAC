terraform {
    backend "gcs" {
        bucket = "tf-bucket-657920"
        prefix = "terraform/state"
    }
}

module "instances" {
    source = "./modules/instances"
    region      = var.region 
    zone        = var.zone 
    project_id  = var.project_id
}

module "storage" {
    source = "./modules/storage"
}

module "vpc" {
    source = "terraform-google-modules/network/google"
    version = "10.0.0"

    project_id = var.project_id
    network_name = "tf-vpc-404749"
    routing_mode = "GLOBAL"

    delete_default_internet_gateway_routes = true 

    subnets = [
        {
            subnet_name = "subnet-01"
            subnet_ip   = "10.10.10.0/24"
            subnet_region = "us-east1"
        },
        {
            subnet_name = "subnet-02"
            subnet_ip   =  "10.10.20.0/24"
            subnet_region = "us-east1"
        }
    ]
}

resource "google_compute_firewall" "tf-firewall" {
  # Nama resource firewall di GCP
  name    = "tf-firewall"
  project = var.project_id

  # Menghubungkan firewall ini ke VPC yang dibuat oleh modul "vpc"
  # Ini adalah cara yang benar, BUKAN hardcoding ID
  # Kita mengambil 'network_self_link' dari 'output' modul vpc
  network = module.vpc.network_self_link

  # Aturan untuk mengizinkan traffic masuk (ingress)
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  # Berlaku untuk semua IP sumber (0.0.0.0/0 berarti 'dari mana saja')
  source_ranges = ["0.0.0.0/0"]
}