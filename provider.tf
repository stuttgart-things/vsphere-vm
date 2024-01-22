terraform {
  required_version = ">= 1.5.5"

  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = ">= 2.6.1"
    }
  }
}

provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = var.unverified_ssl
}
