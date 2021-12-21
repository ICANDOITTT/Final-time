resource "azurerm_public_ip" "star_elbip" {
    name = "star-elbip"
    location = azurerm_resource_group.star_rg.location
    resource_group_name = azurerm_resource_group.star_rg.name
    allocation_method = "Static"
    sku = "Standard"

    depends_on = [azurerm_virtual_machine_extension.star_vmex_was]
}

resource "azurerm_lb" "star_elb" {      #외부 로드밸런서!!
    name = "star-elb"
    location = azurerm_resource_group.star_rg.location
    resource_group_name = azurerm_resource_group.star_rg.name
    sku = "Standard"

    frontend_ip_configuration {
        name = "publicIPAddress"
        public_ip_address_id = azurerm_public_ip.star_elbip.id
    }

    depends_on = [ azurerm_public_ip.star_elbip ]
}

resource "azurerm_lb_backend_address_pool" "star_backend" {
    loadbalancer_id = azurerm_lb.star_elb.id
    name = "star-backend"

    depends_on = [ azurerm_lb.star_elb ]
}

resource "azurerm_lb_probe" "star_elbprobe" {
    resource_group_name = azurerm_resource_group.star_rg.name
    loadbalancer_id = azurerm_lb.star_elb.id
    name = "star-elbprobe"
    port = 80

    depends_on = [ azurerm_lb_backend_address_pool.star_backend ]
}

resource "azurerm_lb_rule" "star_inbound" {
    resource_group_name = azurerm_resource_group.star_rg.name
    loadbalancer_id = azurerm_lb.star_elb.id
    name = "star-inbound"
    frontend_ip_configuration_name = "publicIPAddress"
    backend_address_pool_ids = [ azurerm_lb_backend_address_pool.star_backend.id ]
    protocol = "Tcp"
    frontend_port = 80
    backend_port = 80
    probe_id = azurerm_lb_probe.star_elbprobe.id
    disable_outbound_snat = "true"

    depends_on = [ azurerm_lb_probe.star_elbprobe ]
}

resource "azurerm_lb_outbound_rule" "star_outb" {
    resource_group_name = azurerm_resource_group.star_rg.name
    loadbalancer_id = azurerm_lb.star_elb.id
    name = "star-outb"
    protocol = "All"
    backend_address_pool_id = azurerm_lb_backend_address_pool.star_backend.id
    allocated_outbound_ports = "1024"

    frontend_ip_configuration {
        name = "publicIPAddress"
    }

    depends_on = [ azurerm_lb_rule.star_inbound ]
}