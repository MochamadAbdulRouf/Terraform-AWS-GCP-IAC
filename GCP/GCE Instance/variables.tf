variable "project_id" {
  type        = string
  description = "The ID of the Google Cloud project"
  default     = "PROJECT_ID"
}

variable "region" {
  type        = string
  description = "The region to deploy resources in"
  default     = "REGION"
}

variable "zone" {
  type        = string
  description = "The zone to deploy resources in"
  default     = "ZONE"
}