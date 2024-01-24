locals {
  servers = {
    username = "azureuser"
    proxy    = { ip = azurerm_public_ip.public_net.ip_address, name = "k8s-cp", port = 22 }
    cp = [
      { ip = azurerm_public_ip.public_net.ip_address, name = "cp", port = 22 }
    ]
    nodes = [
      #   { ip = module.vm_node1.private_ip, name = "node1", port = 22 }
    ]
  }
}

resource "local_file" "ssh_config" {
  content         = templatefile("${path.module}/templates/ssh_config.tftpl", local.servers)
  file_permission = 0600
  filename        = "/home/user/.ssh/config"
}