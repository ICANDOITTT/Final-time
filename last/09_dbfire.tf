resource "azurerm_mysql_firewall_rule" "star_dbwall" {      #첨에는 공용아이피로 만든 was에서 접근하기떄문에 azure 방문서비스허용해주는구간~~
    name = "star-dbwall"
    resource_group_name = azurerm_resource_group.star_rg.name
    server_name = azurerm_mysql_server.star_myser.name
    start_ip_address = "0.0.0.0"
    end_ip_address = "0.0.0.0"

    depends_on = [ azurerm_mysql_configuration.star_time ]
}