resource "azurerm_cosmosdb_account" "cosmos" {
  name                = "${var.prefix}-cosmos"
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "MongoDB"
  offer_type          = "Standard"  # Free tier n'est pas affecté par Managed Identity ou AZ

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  capabilities {
    name = "EnableMongo"
  }

  consistency_policy {
    consistency_level = "Session"
  }
}

variable "prefix" {
  type        = string
  description = "Préfixe pour les ressources"
}

variable "location" {
  type        = string
  description = "Region Azure"
}

variable "resource_group_name" {
  type        = string
  description = "Nom du resource group"
}
