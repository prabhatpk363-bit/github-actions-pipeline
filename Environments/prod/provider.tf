terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.81.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "prod-pk"
    storage_account_name = "pkstorage1231"
    container_name       = "pkcontainer1"
    key                  = "pkt.tfstate"

  }
}
provider "azurerm" {
  features {}
}