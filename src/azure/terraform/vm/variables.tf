variable "host_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}
variable "resource_group_location" {
  type = string
}

variable "public_vnet_id" {
  type    = string
  default = null
}

variable "private_vnet_id" {
  type    = string
  default = ""
}

variable "private_subnet_id" {
  type    = string
  default = ""
}

variable "storage_account_uri" {
  type    = string
  default = ""
}

variable "vm_username" {
  type        = string
  default     = "azureuser"
  description = "Default Admin username"
}

variable "vm_specs" {
  type = object({
    size = string
    image = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    os_disk = object({
      name         = string
      caching      = string
      storage_type = string
    })
  })

  default = {
    size = "Standard_B2ms"
    image = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts-gen2"
      version   = "latest"
    }
    os_disk = {
      name         = "OsDisk"
      caching      = "ReadWrite"
      storage_type = "Standard_LRS"
    }
  }
}

variable "open_wide_ports" {
  description = "Open ports in wide network"
  type = list(object({
    port = string, address = string
  }))
  default = [
    { port = 80, address = "*" },
    { port = 443, address = "*" },
  ]
}


variable "notification_email" {
  type    = string
  default = ""
}