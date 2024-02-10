variable "dns_zone_name" {
  type        = string
  description = "Domain name will create the dns zone and dns records for the project"
}

variable "rg_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "rg_location" {
  type        = string
  default     = "eastus"
  description = "Location of the resource group. (uksouth,ukwest)"
}
variable "username" {
  type        = string
  default     = "azureuser"
  description = "Username for the VMs"
}

variable "private_network_name" {
  type        = string
  default     = "network.private"
  description = "Private Network name"
}

variable "public_network_name" {
  type        = string
  default     = "network.public"
  description = "Public Network name"
}

variable "my_public_ip" {
  type        = string
  default     = "*"
  description = "My Public Ip Address for SSH rule"
}

variable "email" {
  type        = string
  default     = ""
  description = "email for notifications"
}


# StorageTypes 
#   Standard_LRS, Premium_LRS, StandardSSD_LRS, UltraSSD_LRS, Premium_ZRS, StandardSSD_ZRS, PremiumV2_LRS

locals {
  tags = {
    project     = var.rg_name_prefix
    environment = "Production"
    application = "terraform"
  }
}