# File: modules/instances/outputs.tf

output "instance_names" {
  description = "Nama-nama dari VM yang dibuat."
  value = [
    google_compute_instance.instance_1.name,
    google_compute_instance.instance_2.name,
    # Hapus baris di bawah ini jika Anda sudah menghapus instance_3
    # google_compute_instance.instance_3.name, 
  ]
}

output "internal_ips" {
  description = "Daftar alamat IP internal VM."
  value = [
    google_compute_instance.instance_1.network_interface[0].network_ip,
    google_compute_instance.instance_2.network_interface[0].network_ip,
    # Hapus baris di bawah ini jika Anda sudah menghapus instance_3
    # google_compute_instance.instance_3.network_interface[0].network_ip,
  ]
}

output "external_ips" {
  description = "Daftar alamat IP eksternal VM."
  value = [
    # [0].access_config[0].nat_ip adalah cara mengambil IP eksternal
    # Tambahkan tanda tanya (?) untuk menghindari error jika IP eksternal tidak ada
    try(google_compute_instance.instance_1.network_interface[0].access_config[0].nat_ip, null),
    try(google_compute_instance.instance_2.network_interface[0].access_config[0].nat_ip, null),
    # Hapus baris di bawah ini jika Anda sudah menghapus instance_3
    # try(google_compute_instance.instance_3.network_interface[0].access_config[0].nat_ip, null),
  ]
}