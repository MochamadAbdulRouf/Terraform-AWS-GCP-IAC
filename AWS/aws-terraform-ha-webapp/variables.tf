variable "aws_region" {
  description = "Region AWS yang digunakan"
  type        = string
}

variable "aws_access_key" {
  description = "AWS Access key disini"
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS Secret key disini"
  sensitive   = true
}

variable "aws_token" {
  description = "Token AWS disini"
  sensitive   = true
}

variable "project_name" {
  description = "Project name for aws"
  type        = string
}

variable "vpc_cidr" {
  description = "IP Range untuk vpc utama"
  type        = string
}

variable "public_cidrs" {
  description = "List CIDR untuk publlic subnet"
  type        = list(string)
}

variable "azs" {
  description = "List Availibity Zones yang digunakan"
  type        = list(string)
}

