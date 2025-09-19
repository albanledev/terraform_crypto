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
  type      = string
  sensitive = true
}

variable "coingecko_api_key" {
  type      = string
  sensitive = true
}

# -------------------
# Static Web App (Front React Vite) - FREE
# -------------------
resource "azurerm_static_site" "frontend" {
  name                = "${var.prefix}-frontend-swa"
  resource_group_name = var.resource_group_name
  location            = var.location

  sku_tier = "Free"
  sku_size = "Free"
}

# -------------------
# Storage Account pour Function App
# -------------------
resource "azurerm_storage_account" "func_storage" {
  name                     = "${var.prefix}funcsa"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# -------------------
# App Service Plan pour Azure Function (Backend Flask)
# -------------------
resource "azurerm_app_service_plan" "function_plan" {
  name                = "${var.prefix}-func-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "FunctionApp"
  reserved            = true  # Linux

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

# -------------------
# Azure Function App (Backend Flask)
# -------------------
resource "azurerm_function_app" "backend" {
  name                       = "${var.prefix}-func"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  app_service_plan_id        = azurerm_app_service_plan.function_plan.id
  storage_account_name       = azurerm_storage_account.func_storage.name
  storage_account_access_key = azurerm_storage_account.func_storage.primary_access_key
  os_type                    = "linux"

  site_config {
    linux_fx_version = "PYTHON|3.11"  # Flask sous Python 3.11
  }

  app_settings = {
    "COSMOS_DB_CONNECTION" = var.cosmos_connection_string
    "COINGECKO_API_KEY"    = var.coingecko_api_key
  }

  identity {
    type = "SystemAssigned"
  }
}

# -------------------
# Outputs
# -------------------
output "frontend_swa_hostname" {
  value = azurerm_static_site.frontend.default_host_name
}

output "backend_function_app_url" {
  value = azurerm_function_app.backend.default_hostname
}

output "function_storage_account" {
  value = azurerm_storage_account.func_storage.name
}
