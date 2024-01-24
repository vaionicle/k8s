terraform {
  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.88.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.azure.subscription_id
  client_id       = var.azure.client_id
  client_secret   = var.azure.client_secret
  tenant_id       = var.azure.tenant_id
}