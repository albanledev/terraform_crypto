variable "resource_group_name" {
  description = "Nom du Resource Group"
  type        = string
}

variable "location" {
  description = "Région Azure"
  type        = string
}


variable "prefix" {
  description = "Préfixe pour le nom des ressources"
  type        = string
}