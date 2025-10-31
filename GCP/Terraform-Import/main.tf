# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "docker" {
  host = "unix:///./ /docker.sock"
}
