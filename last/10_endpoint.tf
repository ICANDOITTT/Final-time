resource "azurerm_private_dns_zone" "star_zone" {
    name  = "privatelink.mysql.database.azure.com"
    resource_group_name = azurerm_resource_group.star_rg.name

    depends_on = [azurerm_mysql_configuration.star_time]
}

resource "azurerm_private_endpoint" "star_endpoint" {
    name = "star-endpoint"
    location = azurerm_resource_group.star_rg.location
    resource_group_name = azurerm_resource_group.star_rg.name
    subnet_id = azurerm_subnet.star_sub4.id

    private_service_connection {
        name = "star-privateserviceconnection-db"
        private_connection_resource_id = azurerm_mysql_server.star_myser.id
        is_manual_connection = false
        subresource_names = ["mysqlServer"]
    }

    private_dns_zone_group {
        name = "privatelink-mysql-database-azure-com"
        private_dns_zone_ids = [azurerm_private_dns_zone.star_zone.id]
    }

    depends_on = [azurerm_private_dns_zone.star_zone]
}

resource "azurerm_private_dns_zone_virtual_network_link" "star_link" {
    name = "linkstar"
    resource_group_name = azurerm_resource_group.star_rg.name
    private_dns_zone_name = azurerm_private_dns_zone.star_zone.name
    virtual_network_id = azurerm_virtual_network.star_vpc.id

    depends_on = [azurerm_private_endpoint.star_endpoint]
}
