locals {
  servers = {
    namespace = var.rg_name_prefix
    username  = "azureuser"
    proxy     = { ip = azurerm_public_ip.public_net.ip_address, name = "cp", port = 22 }
    cp = [
      { ip = azurerm_public_ip.public_net.ip_address, name = "cp", port = 22 }
    ]
    nodes = [
      { ip = module.vm_nodes["node1"].private_ip, name = "node1", port = 22 },
      { ip = module.vm_nodes["node2"].private_ip, name = "node2", port = 22 },
      { ip = module.vm_nodes["node3"].private_ip, name = "node3", port = 22 }
    ]
  }
}

resource "local_file" "ssh_config" {
  content         = templatefile("${path.module}/templates/ssh_config.tftpl", local.servers)
  file_permission = 0600
  filename        = "/home/user/.ssh/config"
}