
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

# StorageTypes
#   Standard_LRS, Premium_LRS, StandardSSD_LRS, UltraSSD_LRS, Premium_ZRS, StandardSSD_ZRS, PremiumV2_LRS

locals {
  tags = {
    project     = var.rg_name_prefix
    environment = "Production"
    application = "terraform"
  }
}