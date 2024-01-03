terraform {
  required_version = ">= 1.6.6"

  required_providers {
    kubernetes = {
      source  = "hashicorp/vsphere"
      version = ">= 2.6.1"
    }
  }
}
