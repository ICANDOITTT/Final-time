resource "azurerm_mysql_server" "star_myser" {      #mysql를 위한 server를 만들어준다.
    name = "star-myser"
    location = azurerm_resource_group.star_rg.location
    resource_group_name = azurerm_resource_group.star_rg.name 
    
    administrator_login = "nana"
    administrator_login_password = "gkwltnsmscjswo1!"

    sku_name = "GP_Gen5_2"
    storage_mb = 5120
    version = "5.7"

    auto_grow_enabled = false
    backup_retention_days = 7
    geo_redundant_backup_enabled = true
    infrastructure_encryption_enabled = false 
    public_network_access_enabled = true
    ssl_enforcement_enabled = false

    depends_on = [ azurerm_bastion_host.star_bastion ]
}


resource "azurerm_mysql_database" "star_db" {       #petclinic database를 만들어주고 
    name = "petclinic"
    resource_group_name = azurerm_resource_group.star_rg.name
    server_name = azurerm_mysql_server.star_myser.name
    charset = "utf8"
    collation = "utf8_unicode_ci"

    depends_on = [ azurerm_mysql_server.star_myser ]
}

resource "azurerm_mysql_configuration" "star_time" {        #db연동을 위해서 timezone도 한국시간으로 맞추어 줘야지! 눈누난나~
    name = "time_zone"
    resource_group_name = azurerm_resource_group.star_rg.name

    server_name = azurerm_mysql_server.star_myser.name
    value = "+09:00"

    depends_on = [ azurerm_mysql_database.star_db ]
}
