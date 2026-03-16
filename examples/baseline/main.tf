module "setup" {
  source = "../../testing/setup"

  name_prefix = var.application_name
  location    = var.location
}

module "vwan" {

  source = "../../modules/network"

  resource_group_name   = module.setup.resource_group_name
  location              = module.setup.location
  name                  = "${var.application_name}-${module.setup.suffix}"
  primary_address_space = var.address_space
  additional_regions    = var.additional_regions

}
