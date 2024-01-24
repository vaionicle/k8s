
# Create (and display) an SSH key
resource "tls_private_key" "generate_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_ssh_public_key" "public_key" {
  name = "${var.host_name}_ssh_key"

  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  public_key = tls_private_key.generate_ssh_key.public_key_openssh

  tags = local.tags
}

resource "local_file" "private_key" {
  content         = tls_private_key.generate_ssh_key.private_key_openssh
  file_permission = 0600
  filename        = "/home/user/.ssh/${var.host_name}.id_rsa"
}

resource "local_file" "public_key" {
  content         = tls_private_key.generate_ssh_key.public_key_openssh
  file_permission = 0600
  filename        = "/home/user/.ssh/${var.host_name}.id_rsa.pub"
}