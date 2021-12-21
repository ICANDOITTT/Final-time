resource "azurerm_network_interface" "star_web_nwif" {
    name = "star-nwif1"
    location = azurerm_resource_group.star_rg.location
    resource_group_name = azurerm_resource_group.star_rg.name

    ip_configuration {
        name = "internal"
        subnet_id = azurerm_subnet.star_sub2.id
        private_ip_address_allocation = "Dynamic"
    }

    depends_on = [azurerm_lb_outbound_rule.star_outb]
}

resource "azurerm_network_interface_backend_address_pool_association" "star_elb_backass" {      
    network_interface_id = azurerm_network_interface.star_web_nwif.id
    ip_configuration_name = "internal"
    backend_address_pool_id = azurerm_lb_backend_address_pool.star_backend.id

    depends_on = [ azurerm_network_interface.star_web_nwif ]
}