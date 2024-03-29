module "vm_cp" {
  source = "./vm/"

  host_name   = "k8s-cp"
  vm_username = var.username

  resource_group_name     = azurerm_resource_group.rg.name
  resource_group_location = azurerm_resource_group.rg.location

  # public network
  public_vnet_id = azurerm_public_ip.public_net.id

  # private network
  private_vnet_id   = azurerm_virtual_network.private_net.id
  private_subnet_id = azurerm_subnet.private_net_subnet.id

  #   storage_account_uri = azurerm_storage_account.storage_diagnostics.primary_blob_endpoint

  open_wide_ports = [
    # { port = 80, address = "*" },
    # { port = 443, address = "*" },
    { port = 22, address = "${var.my_public_ip}" },
  ]

  notification_email = var.email

  depends_on = [azurerm_resource_group.rg]
}

output "vm_cp" {
  value     = module.vm_cp
  sensitive = true
}