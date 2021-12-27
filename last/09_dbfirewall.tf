resource "azurerm_mysql_firewall_rule" "star_dbwall" {
    name = "star-dbwall"
    resource_group_name = azurerm_resource_group.star_rg.name
    server_name = azurerm_mysql_server.star_myser.name
    start_ip_address = "0.0.0.0"
    end_ip_address = "0.0.0.0"

    timeouts {
        delete = "15m"
    }

    depends_on = [ azurerm_mysql_configuration.star_time ]
}