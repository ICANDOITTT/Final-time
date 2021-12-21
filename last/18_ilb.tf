resource "azurerm_lb" "star_ilb" {          #내부 로드밸런서다~
    name = "star-ilb"
    location = azurerm_resource_group.star_rg.location
    resource_group_name = azurerm_resource_group.star_rg.name
    sku = "Standard"

    frontend_ip_configuration {
        name = "privateIPAddress"
        private_ip_address_allocation = "Dynamic"
        subnet_id = azurerm_subnet.star_sub3.id
    }
}

resource "azurerm_lb_backend_address_pool" "star_ilb_backend" {
    loadbalancer_id = azurerm_lb.star_ilb.id
    name = "star-ilb-backend"

    depends_on = [ azurerm_lb.star_ilb ]
}

resource "azurerm_lb_probe" "star_ilbprobe" {
    resource_group_name = azurerm_resource_group.star_rg.name
    loadbalancer_id = azurerm_lb.star_ilb.id
    name = "star-ilbprobe"
    port = 8080

    depends_on = [ azurerm_lb_backend_address_pool.star_ilb_backend ]
}

resource "azurerm_lb_rule" "star_ilb_inbound" {
    resource_group_name = azurerm_resource_group.star_rg.name
    loadbalancer_id = azurerm_lb.star_ilb.id
    name = "star-ilb_inbound"
    frontend_ip_configuration_name = "privateIPAddress"
    backend_address_pool_ids = [ azurerm_lb_backend_address_pool.star_ilb_backend.id ]
    protocol = "Tcp"
    frontend_port = 8080
    backend_port = 8080
    probe_id = azurerm_lb_probe.star_ilbprobe.id
    disable_outbound_snat = "true"

    depends_on = [ azurerm_lb_probe.star_ilbprobe ]
}