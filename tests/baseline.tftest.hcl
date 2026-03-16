provider "azurerm" {
  features {}
  subscription_id = "b2dcbc85-4327-454d-8972-b8ab7fcf5e76"
}

variables {
  application_name = "aztf-test"
  location         = "westus3"
}

run "baseline" {
  module {
    source = "./examples/baseline"
  }

  variables {
    address_space      = "10.8.0.0/23"
    additional_regions = {}
  }

  providers = {
    azurerm = azurerm
  }

  assert {
    condition     = length(module.vwan.id) > 0
    error_message = "Must have a valid V-WAN ID"
  }
}
