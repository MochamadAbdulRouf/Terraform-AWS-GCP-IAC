# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# Terraform configuration

resource "docker_container" "web" {
    image = "sha256:87a94228f133e2da99cb16d653cd1373c5b4e8689956386c1c12b60a20421a02"
    name = "terraform-learn"
    ports {
        external = 8080
        internal = 80 
        ip       = "0.0.0.0"
        protocol = "tcp"
    }

}