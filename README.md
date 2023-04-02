# stuttgart-things/vsphere-vm

terraform module for building/cloning vsphere vms (based on an existing vcenter templates)

## HOW TO USE

### Create terraform code to call the module

change the values for the variables according to your vsphere environment / vm templates.

```
cat <<EOF > ./create-vsphere-vm.tf
module "newprovider" {
  vm_count               = 1
  vsphere_vm_name        = "newprovider"
  vm_memory              = 6144
  vm_disk_size           = "64"
  vm_num_cpus            = 6
  firmware               = "bios"
  vsphere_vm_folder_path = var.vsphere_vm_folder_path
  source                 = "git::https://github.com/stuttgart-things/vsphere-vm.git"
  vsphere_datacenter     = var.vsphere_datacenter
  vsphere_datastore      = var.vsphere_datastore
  vsphere_resource_pool  = var.vsphere_resource_pool
  vsphere_network        = var.vsphere_network
  vsphere_vm_template    = var.vsphere_vm_template
  vm_ssh_user            = var.vm_ssh_user
  vm_ssh_password        = var.vm_ssh_password
  bootstrap              = ["echo STUTTGART-THINGS"]
  annotation             = "VSPHERE-VM BUILD w/ SHIPYARD FOR STUTTGART-THINGS"
}

#provider

terraform {
  backend "s3" {
    endpoint                    = "https://artifacts.tiab.labda.sva.de"
    key                         = "vm-newprovider.tfstate"
    region                      = "main"
    bucket                      = "vsphere-vm"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    force_path_style            = true
  }

  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = ">= 2.3.1"
    }

  }
  required_version = ">= 1.3.7"
}

provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

#variables

variable "vsphere_server" {
  default     = false
  description = "vsphere server"
}

variable "vsphere_user" {
  default     = false
  description = "password of vsphere user"
}

variable "vsphere_password" {
  default     = false
  description = "password of vsphere user"
}

variable "vm_ssh_user" {
  default     = false
  description = "username of ssh user for vm"
}

variable "vm_ssh_password" {
  default     = false
  description = "password of ssh user for vm"
}

variable "vsphere_datastore" {
  default     = false
  description = "name of vsphere datastore"
}

variable "vsphere_datacenter" {
  default     = false
  description = "name of vsphere datacenter"
}

variable "vsphere_resource_pool" {
  default     = false
  description = "name of vsphere resource pool"
}

variable "vsphere_network" {
  default     = false
  description = "name of vsphere network"
}

variable "vsphere_vm_template" {
  default     = false
  description = "name/path of vsphere vm template"
}

variable "vsphere_vm_folder_path" {
  default     = false
  description = "folder path of to be created vm on datacenter"
}

#output

output "newprovider_ip" {
  value = module.newprovider.ip
}
EOF
```

### Create tf vars

```
cat <<EOF > ./terraform.tfvars
vsphere_datastore      = "/NetApp-HCI-Datacenter/datastore/DatastoreCluster/NetApp-HCI-Datastore-04"
vsphere_resource_pool  = "Resources"
vsphere_network        = "/NetApp-HCI-Datacenter/network/tiab-prod"
vsphere_vm_template    = "/NetApp-HCI-Datacenter/host/NetApp-HCI-Cluster-01/10.100.135.46/ubuntu22"
vsphere_datacenter     = "/NetApp-HCI-Datacenter"
vsphere_vm_folder_path = "stuttgart-things/testing"
EOF
```

### 2. set environment variables
```
export TF_VAR_vsphere_user=
export TF_VAR_vsphere_password=
export TF_VAR_vsphere_server=
export TF_VAR_vm_ssh_user=
export TF_VAR_vm_ssh_password=
```

### 3. execute terraform / create vm
```
terraform init
terraform plan
terraform apply
```

### 4. destroy vm
```
terraform destroy --auto-approve
```

Role history
----------------
| date  | who | changelog |
|---|---|---|
|2023-03-09 | Patrick Hermann | updated for move to github
|2021-03-03 | Patrick Hermann | updated tf code + Readme
|2019-12-21 | Patrick Hermann | intial commit for this module in codehub

License
-------

BSD

Author Information
------------------

Patrick Hermann, Stuttgart-Things 12/2019
