
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.host_name}.nsg"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  tags = local.tags
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule
resource "azurerm_network_security_rule" "open_wide_ports" {
  count = length(var.open_wide_ports)

  name      = "${var.host_name}.nsg.${var.open_wide_ports[count.index].port}"
  priority  = 100 + count.index
  direction = "Inbound"

  access   = "Allow"
  protocol = "Tcp"

  # FROM ANY WHERE
  # The recommended value for source port ranges is * (Any). Port filtering is mainly used with destination port.
  source_port_range     = "*"
  source_address_prefix = var.open_wide_ports[count.index].address

  # TO
  destination_port_range     = var.open_wide_ports[count.index].port
  destination_address_prefix = "*"

  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}
