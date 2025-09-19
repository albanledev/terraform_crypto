resource "random_id" "suffix" {
  byte_length = 4
}

resource "azurerm_storage_account" "tfstate" {
  name = "tfstatestorage${var.prefix}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}

output "storage_account_name" {
  value = azurerm_storage_account.tfstate.name
}
