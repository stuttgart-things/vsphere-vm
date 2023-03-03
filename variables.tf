variable "vsphere_datacenter" {
  default     = false
  description = "name of datacenter"
}

variable "vsphere_datastore" {
  default     = false
  description = "name of vsphere datastore"
}

variable "vsphere_resource_pool" {
  default     = false
  description = "name of resource_pool"
}

variable "annotation" {
  default     = "====STUTTGART-THINGS/VM===="
  description = "annotation/vm notes in vcenter"
}


variable "vsphere_network" {
  default     = false
  description = "name of vsphere network"
}

variable "vsphere_vm_template" {
  default     = false
  description = "name of vsphere vm template"
}

variable "vsphere_vm_name" {
  default     = "terraform-vm"
  description = "name of vsphere virtual machine"
}

variable "firmware" {
  default     = "bios"
  description = "The firmware interface to use on the virtual machine. Can be one of bios or EFI. Default: bios"
}

variable "vsphere_vm_folder_path" {
  default     = "/"
  description = "target (vm) folder path of vsphere virtual machine"
}

variable "vm_memory" {
  default     = 2048
  description = "amount of memory of the vm"
}

variable "vm_num_cpus" {
  default     = 2
  description = "amount of cpus from the vm"
}

variable "vm_disk_label" {
  default     = "disk0"
  description = "label of disk"
}

variable "vm_disk_size" {
  default     = "30"
  description = "size of disk"
}

variable "vm_count" {
  default     = 1
  description = "amount of vms"
}

variable "vm_ssh_user" {
  default     = false
  description = "username of ssh user for vm"
}

variable "vm_ssh_password" {
  default     = false
  description = "password of ssh user"
}

variable "bootstrap" {
  description = "Bootstrap os"
  type        = list(string)
  default     = ["whoami", "hostname"]
}

