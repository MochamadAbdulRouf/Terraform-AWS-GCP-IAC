variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "az" {
  default = "us-east-1a"
}

variable "ami_id" {
  description = "AMI ID untuk EC2 (contoh: Ubuntu)"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "Nama SSH key pair di AWS"
}

variable "bucket_name" {
  description = "Nama unik untuk S3 bucket"
}
