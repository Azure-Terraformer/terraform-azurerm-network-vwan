resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

resource "azurerm_resource_group" "test" {
  name     = "rg-${var.name_prefix}-${random_string.suffix.result}"
  location = var.location
}
