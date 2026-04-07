# vSphere VM

Terraform module for creating vSphere virtual machines based on the [hashicorp/vsphere](https://registry.terraform.io/providers/hashicorp/vsphere/latest) provider (v2.12.0).

## Overview

This module provisions VMs on VMware vSphere by cloning templates. It supports:

- Multi-VM creation (1-5 VMs per invocation)
- CPU, memory, disk, and network customization
- Firmware selection (BIOS or EFI)
- Automatic hostname provisioning via SSH
- Bootstrap command execution on first boot

## Quick Start

```hcl
module "vsphere-vm" {
  source                 = "git::https://github.com/stuttgart-things/vsphere-vm.git"
  vsphere_vm_name        = "my-vm"
  vm_count               = 1
  vm_memory              = 4096
  vm_num_cpus            = 4
  vm_disk_size           = "32"
  firmware               = "bios"
  vsphere_vm_folder_path = "stuttgart-things/dev"
  vsphere_datacenter     = "/MyDatacenter"
  vsphere_datastore      = "/MyDatacenter/datastore/MyDatastore"
  vsphere_resource_pool  = "Resources"
  vsphere_network        = "/MyDatacenter/network/VM Network"
  vsphere_vm_template    = "/MyDatacenter/vm/templates/ubuntu24"
  vm_ssh_user            = var.vm_ssh_user
  vm_ssh_password        = var.vm_ssh_password
  bootstrap              = ["echo STUTTGART-THINGS"]
  vsphere_user           = var.vsphere_user
  vsphere_password       = var.vsphere_password
  vsphere_server         = var.vsphere_server
}
```

## Outputs

| Name | Description |
|------|-------------|
| `ip` | IPv4 addresses of created VMs |

## Crossplane Integration

This module can also be used with [Crossplane](https://crossplane.io/) via the Upbound Terraform Provider as a `Workspace` resource. See the [README](https://github.com/stuttgart-things/vsphere-vm#usage-crossplane) for a full example.

## Related Documentation

- [Variables Reference](variables.md)
- [CI/CD](CICD.md)
