
resource "azurerm_virtual_network" "private_net" {
  name                = var.private_network_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]

  depends_on = [azurerm_resource_group.rg]
  tags       = local.tags
}

resource "azurerm_subnet" "private_net_subnet" {
  name                 = "${var.private_network_name}.subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.private_net.name
  address_prefixes     = ["10.0.0.0/24"]

  depends_on = [azurerm_resource_group.rg]
}

resource "azurerm_public_ip" "public_net" {
  name = var.public_network_name

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  domain_name_label   = "${azurerm_resource_group.rg.name}-domain"

  depends_on = [azurerm_resource_group.rg]
  tags       = local.tags
}