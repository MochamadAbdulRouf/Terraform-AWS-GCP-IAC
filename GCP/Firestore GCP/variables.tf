variable "project_id" {
  type        = string
  description = "The ID of the Google Cloud project."
  default     = "qwiklabs-gcp-04-a2b5fba15c7d"
}

variable "bucket_name" {
  type        = string
  description = "Bucket name for terraform state"
  default     = "qwiklabs-gcp-04-a2b5fba15c7d-tf-state"
}