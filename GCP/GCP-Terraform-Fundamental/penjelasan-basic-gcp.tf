
# Blok 'terraform' digunakan untuk mendefinisikan pengaturan inti Terraform.
terraform {
  # 'required_providers' adalah tempat kita mendeklarasikan provider apa saja
  # yang dibutuhkan oleh kode ini beserta versinya.
  required_providers {
    # Membutuhkan provider "google" dari HashiCorp dengan versi sekitar 3.5.0.
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

# Blok 'provider' digunakan untuk mengkonfigurasi provider yang sudah dideklarasikan.
# Di sini, kita mengatur provider "google".
provider "google" {
  # Menetapkan ID proyek Google Cloud yang akan digunakan.
  project = "qwiklabs-gcp-00-7f515e8e31bc"
  # Menetapkan region default untuk semua resource.
  region  = "us-central1"
  # Menetapkan zona default untuk semua resource.
  zone    = "us-central1-a"
}

# Membuat resource baru yaitu sebuah Google Cloud Storage Bucket.
resource "google_storage_bucket" "example_bucket" {
  # Menetapkan nama unik untuk bucket. Nama bucket harus unik secara global.
  name     = "bucket-punya-rouf"
  # Menetapkan lokasi geografis tempat bucket akan dibuat.
  location = "US"

  # Mengkonfigurasi bucket agar bisa berfungsi sebagai hosting website statis.
  website {
    # 'index.html' akan menjadi halaman utama saat bucket diakses.
    main_page_suffix = "index.html"
    # '404.html' akan ditampilkan jika halaman yang diminta tidak ditemukan.
    not_found_page   = "404.html"
  }
}

# Membuat resource baru yaitu sebuah Virtual Machine (VM) kedua.
resource "google_compute_instance" "another_instance" {
  # 'depends_on' adalah meta-argumen yang memberitahu Terraform secara eksplisit
  # untuk membuat resource ini HANYA SETELAH resource yang dirujuk (bucket)
  # selesai dibuat. Ini berguna jika tidak ada dependensi implisit.
  depends_on = [google_storage_bucket.example_bucket]

  # Menetapkan nama untuk instance VM ini.
  name         = "terraform-instance-2"
  # Menetapkan tipe mesin (ukuran CPU dan RAM) untuk VM. 'e2-micro' adalah salah satu yang terkecil.
  machine_type = "e2-micro"

  # 'boot_disk' mengkonfigurasi disk utama yang akan digunakan VM untuk booting.
  boot_disk {
    # 'initialize_params' mengatur bagaimana disk akan diinisialisasi.
    initialize_params {
      # Menetapkan image sistem operasi yang akan di-install di disk.
      # 'cos-cloud/cos-stable' adalah Container-Optimized OS dari Google.
      image = "cos-cloud/cos-stable"
    }
  }

  # 'network_interface' mengkonfigurasi bagaimana VM terhubung ke jaringan.
  network_interface {
    # Menghubungkan VM ke jaringan VPC yang bernama 'vpc_network'.
    network = google_compute_network.vpc_network.self_link
    # 'access_config' digunakan untuk memberikan akses internet ke VM.
    # Blok kosong seperti ini akan memberikan IP eksternal yang dinamis (ephemeral).
    access_config {
    }
  }
}

# Membuat resource baru yaitu sebuah alamat IP eksternal yang statis.
# Resource ini hanya "memesan" alamat IP, belum menempelkannya ke mana pun.
resource "google_compute_address" "vm_static_ip" {
  # Memberi nama pada resource alamat IP statis ini.
  name = "terraform-static-ip"
}

# Membuat resource baru yaitu sebuah jaringan Virtual Private Cloud (VPC).
# Jaringan ini akan menjadi tempat bagi VM untuk berkomunikasi.
resource "google_compute_network" "vpc_network" {
  # Memberi nama pada jaringan VPC.
  name = "terraform-network"
}

# Membuat resource VM utama.
resource "google_compute_instance" "vm_instance" {
  # Menetapkan nama untuk instance VM.
  name         = "terraform-instance"
  # Menetapkan tipe mesin.
  machine_type = "e2-micro"
  # Memberikan tag ke VM, berguna untuk aturan firewall atau identifikasi.
  tags = ["web", "dev"]

  # 'provisioner' menjalankan skrip setelah resource berhasil dibuat.
  # PERINGATAN: Provisioner sebaiknya menjadi pilihan terakhir dalam Terraform.
  provisioner "local-exec" {
    # Menjalankan perintah di mesin LOKAL (tempat Terraform dijalankan), BUKAN di dalam VM baru.
    # Perintah ini akan mengambil nama dan IP publik VM, lalu menyimpannya ke file 'ip_address.txt'.
    command = "echo ${google_compute_instance.vm_instance.name}:  ${google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip} >> ip_address.txt"
  }

  # Mengkonfigurasi disk booting untuk VM ini.
  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }

  # Mengkonfigurasi antarmuka jaringan untuk VM ini.
  network_interface {
    # Menghubungkan VM ke jaringan VPC yang sama.
    network = google_compute_network.vpc_network.self_link
    # Mengkonfigurasi akses internet.
    access_config {
      # Menetapkan IP eksternal VM menggunakan IP statis yang sudah dipesan sebelumnya.
      # Ini menempelkan 'google_compute_address.vm_static_ip' ke VM ini.
      nat_ip = google_compute_address.vm_static_ip.address
    }
  }
}