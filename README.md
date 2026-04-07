# stuttgart-things/vsphere-vm

Terraform module for creating vSphere virtual machines based on the [hashicorp/vsphere](https://registry.terraform.io/providers/hashicorp/vsphere/latest) provider (v2.12.0).

| | |
|---|---|
| Documentation | [stuttgart-things.github.io/vsphere-vm](https://stuttgart-things.github.io/vsphere-vm/) |

## Usage

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

output "ip" {
  value = module.vsphere-vm.ip
}
```

## Variables

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `vsphere_server` | string | - | vSphere server FQDN |
| `vsphere_user` | string | - | vSphere API username |
| `vsphere_password` | string | - | vSphere API password |
| `unverified_ssl` | bool | `true` | Allow unverified SSL connections |
| `vsphere_datacenter` | string | - | vSphere datacenter name |
| `vsphere_datastore` | string | - | vSphere datastore path |
| `vsphere_resource_pool` | string | - | Resource pool name |
| `vsphere_network` | string | - | Network path |
| `vsphere_vm_template` | string | - | VM template to clone from |
| `vsphere_vm_folder_path` | string | `/` | Target VM folder path |
| `vsphere_vm_name` | string | `terraform-vm` | VM name (1-32 chars, starts with letter) |
| `vm_count` | number | `1` | Number of VMs (1-5) |
| `vm_num_cpus` | number | `4` | CPU cores (2,4,6,8,10,12,16) |
| `vm_memory` | number | `4096` | Memory in MB (1024,2048,4096,6144,8192,12288,16384,20480,24576) |
| `vm_disk_size` | string | `"32"` | Disk size in GB (20,32,64,96,128,196,256) |
| `vm_disk_label` | string | `"disk0"` | Disk label |
| `firmware` | string | `"bios"` | Firmware type (bios or EFI) |
| `annotation` | string | `====STUTTGART-THINGS/VM====` | VM notes in vCenter |
| `vm_ssh_user` | string | - | SSH username for provisioner |
| `vm_ssh_password` | string | - | SSH password for provisioner |
| `ssh_agent` | bool | `false` | Use ssh-agent for authentication |
| `bootstrap` | list(string) | `["whoami", "hostname"]` | Commands to run after VM creation |

## Outputs

| Name | Description |
|------|-------------|
| `ip` | IPv4 addresses of created VMs |

## Crossplane Usage

This module can be used with the [Upbound Terraform Provider](https://marketplace.upbound.io/providers/upbound/provider-terraform/) for Crossplane:

```yaml
apiVersion: tf.upbound.io/v1beta1
kind: Workspace
metadata:
  name: vsphere-vm-app
spec:
  providerConfigRef:
    name: terraform-default
  forProvider:
    source: Remote
    module: git::https://github.com/stuttgart-things/vsphere-vm.git
    vars:
      - key: vm_count
        value: "1"
      - key: vsphere_vm_name
        value: appserver
      - key: vm_num_cpus
        value: "4"
      - key: vm_memory
        value: "4096"
      - key: vm_disk_size
        value: "64"
      - key: firmware
        value: bios
      - key: vsphere_vm_folder_path
        value: stuttgart-things/dev
      - key: vsphere_datacenter
        value: /MyDatacenter
      - key: vsphere_datastore
        value: /MyDatacenter/datastore/MyDatastore
      - key: vsphere_resource_pool
        value: Resources
      - key: vsphere_network
        value: /MyDatacenter/network/VM Network
      - key: vsphere_vm_template
        value: /MyDatacenter/vm/templates/ubuntu24
    varFiles:
      - source: SecretKey
        secretKeyRef:
          namespace: default
          name: vsphere-tfvars
          key: terraform.tfvars
```

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

## Author Information

Patrick Hermann, stuttgart-things 12/2019
