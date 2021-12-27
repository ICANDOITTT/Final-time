######################################################################## 1번째
resource "azurerm_network_interface" "star_web_nwif01" {
    name = "star-nwif01"
    location = azurerm_resource_group.star_rg.location
    resource_group_name = azurerm_resource_group.star_rg.name

    ip_configuration {
        name = "internal01"
        subnet_id = azurerm_subnet.star_sub2.id
        private_ip_address_allocation = "Dynamic"
    }

    depends_on = [azurerm_lb_outbound_rule.star_outb]
}

resource "azurerm_network_interface_backend_address_pool_association" "star_elb_backass01" {      
    network_interface_id = azurerm_network_interface.star_web_nwif01.id
    ip_configuration_name = "internal01"
    backend_address_pool_id = azurerm_lb_backend_address_pool.star_backend.id

    depends_on = [ azurerm_network_interface.star_web_nwif01 ]
}

######################################################################## 2번째
resource "azurerm_network_interface" "star_web_nwif02" {
    name = "star-nwif02"
    location = azurerm_resource_group.star_rg.location
    resource_group_name = azurerm_resource_group.star_rg.name

    ip_configuration {
        name = "internal02"
        subnet_id = azurerm_subnet.star_sub2.id
        private_ip_address_allocation = "Dynamic"
    }

    depends_on = [azurerm_network_interface_backend_address_pool_association.star_elb_backass01]
}

resource "azurerm_network_interface_backend_address_pool_association" "star_elb_backass02" {      
    network_interface_id = azurerm_network_interface.star_web_nwif02.id
    ip_configuration_name = "internal02"
    backend_address_pool_id = azurerm_lb_backend_address_pool.star_backend.id

    depends_on = [ azurerm_network_interface.star_web_nwif02 ]
}

######################################################################## 3번째
resource "azurerm_network_interface" "star_web_nwif03" {
    name = "star-nwif03"
    location = azurerm_resource_group.star_rg.location
    resource_group_name = azurerm_resource_group.star_rg.name

    ip_configuration {
        name = "internal03"
        subnet_id = azurerm_subnet.star_sub2.id
        private_ip_address_allocation = "Dynamic"
    }

    depends_on = [azurerm_network_interface_backend_address_pool_association.star_elb_backass02]
}

resource "azurerm_network_interface_backend_address_pool_association" "star_elb_backass03" {      
    network_interface_id = azurerm_network_interface.star_web_nwif03.id
    ip_configuration_name = "internal03"
    backend_address_pool_id = azurerm_lb_backend_address_pool.star_backend.id

    depends_on = [ azurerm_network_interface.star_web_nwif02 ]
}

######################################################################## 4번째
resource "azurerm_network_interface" "star_web_nwif04" {
    name = "star-nwif04"
    location = azurerm_resource_group.star_rg.location
    resource_group_name = azurerm_resource_group.star_rg.name

    ip_configuration {
        name = "internal04"
        subnet_id = azurerm_subnet.star_sub2.id
        private_ip_address_allocation = "Dynamic"
    }

    depends_on = [azurerm_network_interface_backend_address_pool_association.star_elb_backass03]
}

resource "azurerm_network_interface_backend_address_pool_association" "star_elb_backass04" {      
    network_interface_id = azurerm_network_interface.star_web_nwif04.id
    ip_configuration_name = "internal04"
    backend_address_pool_id = azurerm_lb_backend_address_pool.star_backend.id

    depends_on = [ azurerm_network_interface.star_web_nwif04 ]
}