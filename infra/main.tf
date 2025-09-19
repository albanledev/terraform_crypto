provider "azurerm" {
  features {}
  subscription_id = "1e207a24-e01f-4fc4-9a20-10dc78bdbd67"
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-crypto-tracker-agr"
  location = "West Europe"
}

# -------------------
# Storage pour Terraform state / Function App
# -------------------
module "storage" {
  source              = "./modules/storage"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  prefix              = "crypto"   # <-- tu passes la variable ici
}

# -------------------
# Database CosmosDB
# -------------------
module "database" {
  source              = "./modules/database"
  prefix              = "crypto"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# -------------------
# Key Vault
# -------------------
module "keyvault" {
  source                   = "./modules/keyvault"
  prefix                   = "crypto"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  cosmos_connection_string = module.database.mongo_connection_string
  coingecko_api_key        = "CG-72Xxpib8envvUzpaQbwMbuiX"
}

module "app_service" {
  source                   = "./modules/app_service"
  prefix                   = "crypto"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  cosmos_connection_string = module.database.mongo_connection_string
  coingecko_api_key        = "CG-72Xxpib8envvUzpaQbwMbuiX"
}




output "mongo_connection_string" {
  value     = "mongodb://crypto_user:${random_password.mongo_password.result}@${azurerm_cosmosdb_account.cosmos.endpoint}:10255/?ssl=true&replicaSet=globaldb"
  sensitive = true
}


