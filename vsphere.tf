data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = var.vsphere_resource_pool
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

# By UUID when vsphere_vm_template_uuid is set, else by name. A bare name is
# resolved datacenter-wide and fails with "resolves to multiple vms" as soon as
# a second object carries it anywhere; prefer an inventory path relative to
# the datacenter's vm folder, e.g. "stuttgart-things/vm-templates/sthings-u26".
data "vsphere_virtual_machine" "template" {
  name          = var.vsphere_vm_template_uuid == null ? var.vsphere_vm_template : null
  uuid          = var.vsphere_vm_template_uuid
  datacenter_id = data.vsphere_datacenter.dc.id
}
