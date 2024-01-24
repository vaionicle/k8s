resource "azurerm_resource_group" "rg" {
  name     = var.rg_name_prefix
  location = var.rg_location

  tags = local.tags
}