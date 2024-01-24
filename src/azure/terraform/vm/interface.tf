# Create network interface
resource "azurerm_network_interface" "vnet_interface" {
  name                = "${var.host_name}.interface"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.host_name}.ip_configuration"
    subnet_id                     = var.private_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_vnet_id
  }

  tags = local.tags
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "security_group_association" {
  network_interface_id      = azurerm_network_interface.vnet_interface.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
