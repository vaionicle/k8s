
# Create virtual machine
resource "azurerm_linux_virtual_machine" "vm" {
  name = "${var.host_name}.vm"

  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  size = var.vm_specs.size

  network_interface_ids = [
    azurerm_network_interface.vnet_interface.id
  ]

  os_disk {
    name                 = local.os_disk_name
    caching              = var.vm_specs.os_disk.caching
    storage_account_type = var.vm_specs.os_disk.storage_type
  }

  source_image_reference {
    publisher = var.vm_specs.image.publisher
    offer     = var.vm_specs.image.offer
    sku       = var.vm_specs.image.sku
    version   = var.vm_specs.image.version
  }

  computer_name                   = var.host_name
  admin_username                  = var.vm_username
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.vm_username
    public_key = tls_private_key.generate_ssh_key.public_key_openssh
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }

  tags = local.tags
}