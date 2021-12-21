resource "azurerm_virtual_network" "star_vpc" {
  name  =   "star-vpc"
  location = azurerm_resource_group.star_rg.location
  resource_group_name = azurerm_resource_group.star_rg.name
  address_space = ["10.0.0.0/16"]

  depends_on = [ azurerm_resource_group.star_rg ]
}