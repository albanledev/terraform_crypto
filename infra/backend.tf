terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-crypto-tracker-agr"       # ton RG
    storage_account_name = "tfstatestoragefd5ae13e"   # output de ton module storage
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
