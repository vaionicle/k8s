output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "public_ip" {
  value = azurerm_public_ip.public_net.ip_address
}

output "domain_name_label" {
  value = azurerm_public_ip.public_net.domain_name_label
}

output "username" {
  value = var.username
}

