module "setup" {
  source = "../../testing/setup"

  name_prefix = var.application_name
  location    = var.location
}


# This obtains the Entra ID Provider Client Configuration
data "azuread_client_config" "current" {}
# This obtains a list of well-known Entra ID Applications
data "azuread_application_published_app_ids" "well_known" {}

locals {
  # Spearfish the Azure VPN Application ID from the well-known list
  azure_vpn_app_id = data.azuread_application_published_app_ids.well_known.result["AzureVPN"]
}

module "vwan" {

  source = "../../modules/network"

  resource_group_name   = module.setup.resource_group_name
  location              = module.setup.location
  name                  = "${var.application_name}-${module.setup.suffix}"
  primary_address_space = var.address_space
  additional_regions    = var.additional_regions

}

module "p2s" {
  source = "../../modules/vpn/p2s/entra"

  resource_group_name = module.setup.resource_group_name
  location            = module.setup.location
  name                = "${var.application_name}-${module.setup.suffix}"
  virtual_hub_id      = module.vwan.primary_virtual_hub_id
  address_space       = var.vpn_address_space
  tenant_id           = data.azuread_client_config.current.tenant_id
  audience            = local.azure_vpn_app_id
}
