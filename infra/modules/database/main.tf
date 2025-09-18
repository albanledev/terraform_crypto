resource "random_id" "suffix" {
  byte_length = 4
}

resource "azurerm_cosmosdb_account" "cosmos" {
  name                = "${var.prefix}-cosmos-${random_id.suffix.hex}"
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "MongoDB"
  offer_type          = "Standard"

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  capabilities {
    name = "EnableMongo"
  }
}

resource "azurerm_cosmosdb_mongo_database" "crypto_db" {
  name                = "crypto"
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmos.name
}

# Mot de passe utilisateur MongoDB
resource "random_password" "mongo_password" {
  length  = 20
  special = true
}

# Output de la connection string Mongo
output "mongo_connection_string" {
  value     = "mongodb://crypto_user:${random_password.mongo_password.result}@${azurerm_cosmosdb_account.cosmos.endpoint}:10255/?ssl=true&replicaSet=globaldb"
  sensitive = true
}

output "cosmos_account_name" {
  value = azurerm_cosmosdb_account.cosmos.name
}

variable "prefix" {
  type        = string
  description = "Préfixe pour les ressources"
}

variable "location" {
  type        = string
}

variable "resource_group_name" {
  type = string
}
