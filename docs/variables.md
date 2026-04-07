# Variables Reference

## vSphere API

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `vsphere_server` | string | - | vSphere server FQDN |
| `vsphere_user` | string | - | vSphere API username |
| `vsphere_password` | string | - | vSphere API password |
| `unverified_ssl` | bool | `true` | Allow unverified SSL connections |

## Infrastructure

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `vsphere_datacenter` | string | - | vSphere datacenter name |
| `vsphere_datastore` | string | - | vSphere datastore path |
| `vsphere_resource_pool` | string | - | Resource pool name |
| `vsphere_network` | string | - | Network path |
| `vsphere_vm_template` | string | - | VM template to clone from |
| `vsphere_vm_folder_path` | string | `/` | Target VM folder path |

## VM Configuration

| Name | Type | Default | Validation | Description |
|------|------|---------|------------|-------------|
| `vsphere_vm_name` | string | `terraform-vm` | starts with letter, 1-32 chars | Base name for VMs |
| `vm_count` | number | `1` | 1-5 | Number of VMs to create |
| `annotation` | string | `====STUTTGART-THINGS/VM====` | - | VM notes in vCenter |
| `firmware` | string | `bios` | - | Firmware type (bios or EFI) |

## Compute

| Name | Type | Default | Validation | Description |
|------|------|---------|------------|-------------|
| `vm_num_cpus` | number | `4` | 2,4,6,8,10,12,16 | CPU cores |
| `vm_memory` | number | `4096` | 1024,2048,4096,6144,8192,12288,16384,20480,24576 | Memory in MB |

## Storage

| Name | Type | Default | Validation | Description |
|------|------|---------|------------|-------------|
| `vm_disk_size` | string | `"32"` | 20,32,64,96,128,196,256 | Disk size in GB |
| `vm_disk_label` | string | `"disk0"` | - | Disk label |

## SSH Provisioner

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `vm_ssh_user` | string | - | SSH username for post-clone provisioning |
| `vm_ssh_password` | string | - | SSH password for post-clone provisioning |
| `ssh_agent` | bool | `false` | Use ssh-agent for authentication |
| `bootstrap` | list(string) | `["whoami", "hostname"]` | Commands to run after VM creation |

The SSH provisioner sets the hostname and regenerates the machine-id after cloning.
