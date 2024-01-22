variable "vsphere_datacenter" {
  default     = false
  type        = string
  description = "name of datacenter"
}

variable "vsphere_datastore" {
  default     = false
  type        = string
  description = "name of vsphere datastore"
}

variable "vsphere_resource_pool" {
  default     = false
  type        = string
  description = "name of resource_pool"
}

variable "annotation" {
  default     = "====STUTTGART-THINGS/VM===="
  type        = string
  description = "annotation/vm notes in vcenter"
}

variable "vsphere_network" {
  default     = false
  type        = string
  description = "name of vsphere network"
}

variable "vsphere_vm_template" {
  default     = false
  type        = string
  description = "name of vsphere vm template"
}

variable "vsphere_vm_name" {
  default     = "terraform-vm"
  type        = string
  description = "name of vsphere virtual machine"

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z\\-\\0-9]{1,32}$", var.vsphere_vm_name))
    error_message = "VM name must start with letter, only contain letters, numbers, dashes, and must be between 1 and 32 characters."
  }

}

variable "firmware" {
  default     = "bios"
  type        = string
  description = "The firmware interface to use on the virtual machine. Can be one of bios or EFI. Default: bios"
}

variable "vsphere_vm_folder_path" {
  default     = "/"
  type        = string
  description = "target (vm) folder path of vsphere virtual machine"
}

variable "vm_memory" {
  default     = 4096
  type        = number
  description = "amount of memory of the vm"
}

variable "vm_num_cpus" {
  default     = 4
  type        = number
  description = "amount of cpus from the vm"

  validation {
    condition     = contains([2, 4, 6, 8, 10, 12, 16], var.vm_num_cpus)
    error_message = "Valid values for vm_num_cpus are (2, 4, 6, 8, 10, 12, 16)"
  }

}

variable "vm_disk_label" {
  default     = "disk0"
  type        = string
  description = "label of disk"
}

variable "vm_disk_size" {
  default     = "32"
  type        = string
  description = "size of disk"

  validation {
    condition     = contains(["20", "32", "64", "96", "128", "196", "256"], var.vm_disk_size)
    error_message = "Valid values for vm_disk_size are (20, 32, 64, 96, 128, 196, 256)"
  }

}

variable "vm_count" {
  default     = 1
  type        = number
  description = "amount of vms"

  validation {
    condition     = var.vm_count >= 1 && var.vm_count <= 5 && floor(var.vm_count) == var.vm_count
    error_message = "Accepted values: 1-5."
  }

}

variable "vm_ssh_user" {
  default     = false
  type        = string
  description = "username of ssh user for vm"
}

variable "vm_ssh_password" {
  default     = false
  type        = string
  description = "password of ssh user"
}

variable "bootstrap" {
  description = "Bootstrap os"
  type        = list(string)
  default     = ["whoami", "hostname"]
}

variable "vsphere_server" {
  default     = false
  type        = string
  description = "vsphere server"
}

variable "vsphere_user" {
  default     = false
  type        = string
  description = "password of vsphere user"
}

variable "vsphere_password" {
  default     = false
  type        = string
  description = "password of vsphere user"
}

variable "unverified_ssl" {
  default     = true
  type        = bool
  description = "enable unverified_ssl"
}
