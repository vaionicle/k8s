resource "random_id" "random_id_os_disk" {
  keepers = {
    resource_group = var.resource_group_name
  }

  byte_length = 8
}

locals {
  os_disk_name = "${var.host_name}.vm.${var.vm_specs.os_disk.name}.${random_id.random_id_os_disk.hex}"

  tags = {
    project     = var.resource_group_name
    environment = "k8s"
    host        = var.host_name
  }
}