resource "azurerm_public_ip" "star_was_publicip" {
    name = "star-was-publicip"
    resource_group_name = azurerm_resource_group.star_rg.name
    location = azurerm_resource_group.star_rg.location
    allocation_method = "Static"
}

resource "azurerm_network_interface" "star_was_nwif" {      
    name = "star-was-nwif"
    location = azurerm_resource_group.star_rg.location
    resource_group_name = azurerm_resource_group.star_rg.name

    ip_configuration {
        name = "internal2"
        subnet_id = azurerm_subnet.star_sub6.id
        public_ip_address_id = azurerm_public_ip.star_was_publicip.id
        private_ip_address_allocation = "Dynamic"
    }

    depends_on = [ azurerm_public_ip.star_was_publicip ]
}
