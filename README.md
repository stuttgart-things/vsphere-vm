# stuttgart-things/vsphere-vm
terraform module for building vsphere vms (based on an existing vcenter templates)

## how to use 

### 1. create a tf file wich calls the module

change the values for the variables according to your vsphere environment / vm template. value for source can be the cloned/downloaded content of this repository or directly from git: git::https://{{ git_token }}@codehub.sva.de/Lab/stuttgart-things/virtual-machines/vsphere-vm.git. additionaly we host it on s3: https://artifacts.tiab.labda.sva.de/modules/vsphere-vm.zip.

```
cat <<EOF > ./create-vsphere-vm.tf
terraform {
  required_providers {
    vsphere = {
      version = "<= 1.24.3"
    }
  }
  required_version = ">= 0.14.7"
}

module "my-vsphere-vm" {
  source                 = "./vsphere-vm"
  vm_count               = 1
  vsphere_vm_name        = "vault-test"
  vsphere_vm_folder_path = "phermann/testing"
  vm_memory              = 4096
  vm_disk_size           = "32"
  vm_num_cpus            = 4
  firmware               = "bios"
  vsphere_resource_pool = "Resources"
  vsphere_datacenter  = "LabUL"
  vsphere_datastore   = "/LabUL/host/Cluster01/10.31.101.41/DD1"
  vsphere_network     = "/LabUL/host/Cluster01/10.31.101.41/LAB-10.31.102"
  vsphere_vm_template = "/LabUL/host/Cluster01/10.31.101.40/centos8"

  vm_ssh_user     = var.vm_ssh_user
  vm_ssh_password = var.vm_ssh_password

  bootstrap = ["echo `date` >> /tmp/info.txt && cat /etc/os-release >> /tmp/info.txt"]
}

output "my-vsphere-vm_ip" {
  value = module.my-vsphere-vm.ip
}

variable "vm_ssh_user" {
  default     = false
  description = "username of ssh user for vm"
}

variable "vm_ssh_password" {
  default     = false
  description = "password of ssh user for vm"
}

variable "vsphere_server" {
  default     = false
  description = "vsphere server up"
}

variable "vsphere_user" {
  default     = false
  description = "password of vsphere user"
}

variable "vsphere_password" {
  default     = false
  description = "password of vsphere user"
}

provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}
EOF
```

### 2. set environment variables
```
export TF_VAR_vsphere_user=
export TF_VAR_vsphere_password=
export TF_VAR_vsphere_server=10.31.101.51
export TF_VAR_vm_ssh_user=
export TF_VAR_vm_ssh_password=
```

### 3. execute terraform / create vm
```
terraform init
terraform apply --auto-approve
```

### 4. destroy vm
```
terraform destroy --auto-approve
```

Role history
----------------
| date  | who | changelog |
|---|---|---|
|2021-03-03  | Patrick Hermann | updated tf code + Readme
|2019-12-21  | Patrick Hermann | intial commit for this module in codehub

License
-------

BSD

Author Information
------------------

Patrick Hermann, SVA GmbH 12/2019
