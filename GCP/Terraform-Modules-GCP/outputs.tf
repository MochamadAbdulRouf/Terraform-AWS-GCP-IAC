
# Mendefinisikan output dari Root Module
# Output ini akan menampilkan nama bucket yang dibuat dari Child Module
output "bucket-name" {
  description = "Bucket names."
  value       = "module.gcs-static-website-bucket.bucket"
}