data "azurerm_client_config" "current" {}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "azurerm_key_vault" "kv" {
  name                = "${var.prefix}-kv-${random_id.suffix.hex}"
  resource_group_name = var.resource_group_name
  location            = var.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

access_policy {
  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id
  secret_permissions = ["Get", "Set", "List", "Recover", "Purge"]
  }
}

# Secret Cosmos DB
resource "azurerm_key_vault_secret" "cosmos_connection_string" {
  name         = "cosmos-connection-string"
  value        = var.cosmos_connection_string
  key_vault_id = azurerm_key_vault.kv.id
}

# Secret CoinGecko
resource "azurerm_key_vault_secret" "coingecko_api_key" {
  name         = "coingecko-api-key"
  value        = var.coingecko_api_key
  key_vault_id = azurerm_key_vault.kv.id
}

output "key_vault_id" {
  value = azurerm_key_vault.kv.id
}

variable "prefix" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "cosmos_connection_string" {
  type = string
}

variable "coingecko_api_key" {
  type = string
  default = "CG-72Xxpib8envvUzpaQbwMbuiX"
}
