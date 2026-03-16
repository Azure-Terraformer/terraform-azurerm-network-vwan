terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.38.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "b2dcbc85-4327-454d-8972-b8ab7fcf5e76"
}
