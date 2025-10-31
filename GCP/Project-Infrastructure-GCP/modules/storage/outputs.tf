# File: modules/storage/outputs.tf

output "bucket_name" {
  description = "Nama GCS bucket yang dibuat."
  value       = google_storage_bucket.bucket.name
}

output "bucket_self_link" {
  description = "Self-link unik dari GCS bucket."
  value       = google_storage_bucket.bucket.self_link
}   