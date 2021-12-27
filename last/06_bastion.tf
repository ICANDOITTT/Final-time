resource "azurerm_public_ip" "star_bastionip" {
    name = "star-bastionip"
    location = azurerm_resource_group.star_rg.location
    resource_group_name = azurerm_resource_group.star_rg.name
    allocation_method = "Static"
    sku = "Standard"

    depends_on = [azurerm_subnet_network_security_group_association.star_nsgass6]
}

resource "azurerm_bastion_host" "star_bastion" {
    name = "star-bastion"
    location = azurerm_resource_group.star_rg.location
    resource_group_name = azurerm_resource_group.star_rg.name

    ip_configuration {
        name = "configuration"
        subnet_id = azurerm_subnet.star_sub5.id
        public_ip_address_id = azurerm_public_ip.star_bastionip.id
    }

    depends_on = [ azurerm_public_ip.star_bastionip ]
}