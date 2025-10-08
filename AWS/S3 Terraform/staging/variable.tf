variable "bucket_name" {
  type        = string
  description = "Test bucket"
  default     = "rouf-s3-bucket"
}

variable "upload_bucket_name" {
  type        = string
  description = "Test bucket for upload"
  default     = "my-demo-upload-bucket"
}