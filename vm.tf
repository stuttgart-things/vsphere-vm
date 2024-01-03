resource "vsphere_virtual_machine" "vm" {
  name = count.index > 0 ? "${var.vsphere_vm_name}-${count.index + 1}" : var.vsphere_vm_name 
  folder           = var.vsphere_vm_folder_path
  count            = var.vm_count
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  firmware = var.firmware
  num_cpus  = var.vm_num_cpus
  memory    = var.vm_memory
  guest_id  = data.vsphere_virtual_machine.template.guest_id
  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  annotation = var.annotation

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }
  disk {
    label            = var.vm_disk_label
    size             = var.vm_disk_size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks[0].eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks[0].thin_provisioned
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

  }

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      host     = self.default_ip_address
      user     = var.vm_ssh_user
      password = var.vm_ssh_password
      agent    = false

    }
    inline = var.bootstrap
  }

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      host     = self.default_ip_address
      user     = var.vm_ssh_user
      password = var.vm_ssh_password
    }
    inline = [
      "sudo echo '${count.index > 0 ? "${var.vsphere_vm_name}-${count.index + 1}" : var.vsphere_vm_name}' | sudo tee /etc/hostname",
      "sudo systemd-machine-id-setup",
      "sudo reboot -f"
    ]
    on_failure = continue
  }
}
