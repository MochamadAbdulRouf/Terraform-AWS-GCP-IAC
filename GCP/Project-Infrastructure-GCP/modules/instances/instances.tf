# File: ./modules/instances/instances.tf
# Dibawah ini adalah resource untuk membuat terraform mengetahui bahwa sudah ada 2 VM dibuat 
# Dan menautkannya menggunakan terraform import.
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

  # Mencegah pembaruan otomatis yang dapat menghentikan instance
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

