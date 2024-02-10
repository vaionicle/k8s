module "vm_nodes" {
  for_each = toset(["node1", "node2", "node3"])
  source   = "./vm/"

  host_name   = "${var.rg_name_prefix}-${each.key}"
  vm_username = var.username

  resource_group_name     = azurerm_resource_group.rg.name
  resource_group_location = azurerm_resource_group.rg.location

  # public network
  # public_vnet_id = azurerm_public_ip.public_net.id

  # private network
  private_vnet_id   = azurerm_virtual_network.private_net.id
  private_subnet_id = azurerm_subnet.private_net_subnet.id

  #   storage_account_uri = azurerm_storage_account.storage_diagnostics.primary_blob_endpoint

  open_wide_ports = [
    { port = 22, address = "${var.my_public_ip}" },
  ]

  notification_email = var.email

  depends_on = [azurerm_resource_group.rg]
}

output "vm_nodes" {
  value     = module.vm_nodes[*]
  sensitive = true
}

