
# Memberikan nilai untuk variable di Root Module
# Nilai ini diberikan ke Child Module yang tidak punya default value
variable "project_id" {
  description = "The ID of the project in which to provision resources."
  type        = string
  default     = "qwiklabs-gcp-00-63ea5c371a45"
}

variable "name" {
  description = "Name of the buckets to create."
  type        = string
  default     = "qwiklabs-gcp-00-63ea5c371a45"
}