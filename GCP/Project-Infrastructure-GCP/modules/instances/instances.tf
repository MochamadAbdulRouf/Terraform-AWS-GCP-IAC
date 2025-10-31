# File: ./modules/instances/instances.tf

# Resource untuk instance pertama
resource "google_compute_instance" "instance_1" {
  # --- WAJIB DIPERIKSA DI CONSOLE ---
  name         = "tf-instance-1"
  machine_type = "e2-standard-2" # GANTI INI dengan Tipe Mesin dari Console
  zone         = var.zone      # Menggunakan variabel zone dari modul

  boot_disk {
    initialize_params {
      image = "debian-11-bullseye-v20251014" # GANTI INI dengan 'Boot disk image' dari Console
    }
  }

  network_interface {
    network    = "tf-vpc-404749" # Nama VPC 
    subnetwork = "subnet-01" # Nama Subnet
  }

  metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
  
  allow_stopping_for_update = true
}

# Resource untuk instance kedua
resource "google_compute_instance" "instance_2" {
  # --- WAJIB DIPERIKSA DI CONSOLE ---
  name         = "tf-instance-2"
  machine_type = "e2-standard-2"
  zone         = var.zone     

  boot_disk {
    initialize_params {
      image = "debian-11-bullseye-v20251014" 
    }
  }
  # --- AKHIR BAGIAN WAJIB DIPERIKSA ---

  network_interface {
    network    = "tf-vpc-404749" 
    subnetwork = "subnet-02"
  }

  metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
  
  allow_stopping_for_update = true
}

