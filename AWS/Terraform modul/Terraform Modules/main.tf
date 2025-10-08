provider "aws" {
  region     = var.web_region
  access_key = var.access_key
  secret_key = var.secret_key
  token      = var.token
}

module "rouf-webserver-1" {
  source = ".//module-1"
}

module "rouf-webserver-2" {
  source = ".//module-2"
}