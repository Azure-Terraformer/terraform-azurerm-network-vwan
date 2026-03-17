output "id" {
  value       = azurerm_virtual_wan.main.id
  description = "Virtual WAN ID"
}
output "primary_hub" {
  value       = azurerm_virtual_hub.primary.id
  description = "Primary Virtual Hub ID"
}
output "additional_hubs" {
  value = length(azurerm_virtual_hub.additional_regions) > 0 ? {
    for region, hub in azurerm_virtual_hub.additional_regions :
    region => hub.id
  } : {}
}
