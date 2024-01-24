
output "tls_private_key" {
  value     = tls_private_key.generate_ssh_key.private_key_pem
  sensitive = true
}

output "tls_public_key" {
  value     = tls_private_key.generate_ssh_key.public_key_pem
  sensitive = true
}

output "vm_username" {
  value = var.vm_username
}

output "private_ip" {
  value = azurerm_network_interface.vnet_interface.private_ip_address
}