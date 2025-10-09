# Memberikan seluruh informasi tentang bucket yang dibuat
# Ketika "Terraform apply" dijalankan, Output ini akan menampilkan seluruh informasi bucket
output "bucket" {
  description = "The created storage bucket"
  value       = google_storage_bucket.bucket
}