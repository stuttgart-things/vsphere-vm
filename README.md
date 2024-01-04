# stuttgart-things/vsphere-vm

terraform module for building/cloning vsphere vms based on existing vm-templates

## CALL THE MODULE

change the values for the variables according to your vsphere environment and existing vm templates.

```hcl
module "labda-vm" {
  source                  = "github.com/stuttgart-things/vsphere-vm"
  vm_count                = 1
  vsphere_vm_name         = "michigan"
  vm_memory               = 6144
  vm_disk_size            = "64"
  vm_num_cpus             = 6
  firmware                = "bios"
  vsphere_vm_folder_path  = "stuttgart-things/testing"
  vsphere_datacenter      = "/NetApp-HCI-Datacenter"
  vsphere_datastore       = "/NetApp-HCI-Datacenter/datastore/DatastoreCluster/NetApp-HCI-Datastore-02"
  vsphere_resource_pool   = "Resources"
  vsphere_network         = "/NetApp-HCI-Datacenter/network/tiab-prod"
  vsphere_vm_template     = "/NetApp-HCI-Datacenter/vm/stuttgart-things/vm-templates/ubuntu23"
  vm_ssh_user             = var.vm_ssh_user
  vm_ssh_password         = var.vm_ssh_password
  bootstrap               = ["echo STUTTGART-THINGS"]
  annotation              = "VSPHERE-VM BUILD w/ TERRAFORM FOR STUTTGART-THINGS"
}

provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
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

variable "vm_ssh_user" {
  default     = false
  type        = string
  description = "username of ssh user for vm"
}

variable "vm_ssh_password" {
  default     = false
  type        = string
  description = "password of ssh user for vm"
}
```

## EXECUTE TERRAFORM / CREATE VM

```bash
terraform init
terraform plan
terraform apply --auto-approve \
-var "vsphere_server=<FQDN>" \
-var "vm_ssh_user=<USER>" \
-var "vm_ssh_password=<PASSWORD>" \
-var "vsphere_user=<VSPHERE_USER>" \
-var "vsphere_password=<VSPHERE_PASSWORD>"
```

### DESTROY VM

```bash
terraform destroy --auto-approve
```

## Author Information

```bash
Patrick Hermann, stuttgart-things 12/2019
```

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
